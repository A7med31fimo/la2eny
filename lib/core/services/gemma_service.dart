import 'dart:convert';
import 'package:dio/dio.dart';
import '../../domain/entities/place.dart';
import '../../domain/entities/user_preferences.dart';
import '../../domain/services/recommendation_engine.dart';

/// Implements [IRecommendationEngine] using Google's Gemma 4 model
/// (gemma-3-27b-it) via the Google AI Gemini API.
///
/// Drop-in replacement for [KeywordRecommendationEngine] — the chat screen
/// never changes. Simply bind this in [chat_provider.dart]:
///
///   final recommendationEngineProvider = Provider<IRecommendationEngine>(
///     (ref) => GemmaRecommendationEngine(
///       apiKey: const String.fromEnvironment('GEMINI_API_KEY'),
///     ),
///   );
///
/// Get a free API key at: https://aistudio.google.com/app/apikey
///
/// Pass it at run-time:
///   flutter run --dart-define=GEMINI_API_KEY=your_key_here
class GemmaRecommendationEngine implements IRecommendationEngine {
  final String apiKey;

  /// Gemma 4 model identifier on Google AI.
  static const String _model = 'gemma-3-27b-it';
  static const String _baseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/$_model:generateContent';

  final Dio _dio;

  GemmaRecommendationEngine({required this.apiKey})
      : _dio = Dio(BaseOptions(
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 30),
        ));

  // ── IRecommendationEngine ──────────────────────────────────────────────────

  @override
  ChatInterpretation interpret(String message, String locale) {
    // Interpretation is done asynchronously; we return a stub here and use
    // [interpretAsync] from the chat screen when a real LLM response is needed.
    // The sync path keeps backward-compatibility with the interface contract.
    return ChatInterpretation(
      preferences: const UserPreferences.empty(),
      recognisedSomething: false,
    );
  }

  /// Async version that actually calls Gemma 4.
  /// Returns both structured [UserPreferences] AND a natural-language reply.
  Future<GemmaInterpretationResult> interpretAsync({
    required String userMessage,
    required String locale,
    required UserPreferences currentPrefs,
    required List<Place> availablePlaces,
  }) async {
    final systemPrompt = _buildSystemPrompt(locale, availablePlaces);
    final userPrompt = _buildInterpretationPrompt(
      userMessage: userMessage,
      locale: locale,
      currentPrefs: currentPrefs,
    );

    final raw = await _generate(systemPrompt: systemPrompt, userPrompt: userPrompt);
    return _parseInterpretationResult(raw, locale);
  }

  @override
  String greeting(String locale) => locale == 'ar'
      ? 'مرحباً! 👋 أنا مساعدك الذكي المدعوم بـ Gemma 4.\n\nأخبرني ماذا تبحث عنه اليوم — مطعم، مقهى، صيدلية؟ وسأجد لك أفضل الأماكن!'
      : 'Hi there! 👋 I\'m your AI assistant powered by Gemma 4.\n\nTell me what you\'re looking for today — a restaurant, café, pharmacy? I\'ll find the best places for you!';

  @override
  String nextQuestion(UserPreferences prefs, String locale) {
    final isAr = locale == 'ar';
    if (prefs.cuisineType == null && prefs.keywords.isEmpty) {
      return isAr
          ? 'ما نوع المكان الذي تبحث عنه؟'
          : 'What kind of place are you looking for?';
    }
    if (prefs.budgetLevel == null) {
      return isAr
          ? 'ما هو نطاق ميزانيتك؟ (اقتصادي / متوسط / فاخر)'
          : 'What\'s your budget range? (budget / mid / luxury)';
    }
    return isAr
        ? 'هل تريد مكاناً قريباً منك؟'
        : 'Would you like somewhere nearby?';
  }

  @override
  String summarise(List<Place> recommendations, String locale) {
    if (recommendations.isEmpty) {
      return locale == 'ar'
          ? 'لم أجد أماكن تطابق طلبك. حاول تغيير بعض التفضيلات.'
          : 'No places matched your request. Try changing some preferences.';
    }
    return locale == 'ar'
        ? '✨ إليك أفضل ${recommendations.length} اقتراحات لك:'
        : '✨ Here are my top ${recommendations.length} picks for you:';
  }

  // ── Core LLM call ──────────────────────────────────────────────────────────

  Future<String> _generate({
    required String systemPrompt,
    required String userPrompt,
  }) async {
    final body = {
      'system_instruction': {
        'parts': [{'text': systemPrompt}],
      },
      'contents': [
        {
          'role': 'user',
          'parts': [{'text': userPrompt}],
        }
      ],
      'generationConfig': {
        'temperature': 0.7,
        'maxOutputTokens': 512,
        'topP': 0.9,
      },
    };

    final response = await _dio.post(
      '$_baseUrl?key=$apiKey',
      data: body,
      options: Options(headers: {'Content-Type': 'application/json'}),
    );

    final candidates =
        (response.data as Map<String, dynamic>)['candidates'] as List<dynamic>;
    final content = candidates.first['content'] as Map<String, dynamic>;
    final parts = content['parts'] as List<dynamic>;
    return (parts.first as Map<String, dynamic>)['text'] as String;
  }

  // ── Prompt builders ────────────────────────────────────────────────────────

  String _buildSystemPrompt(String locale, List<Place> places) {
    final isAr = locale == 'ar';
    final placesSummary = places
        .take(20)
        .map((p) =>
            '- ID:${p.id} | ${isAr ? p.nameAr : p.nameEn} | '
            'Category: ${p.categories.map((c) => isAr ? c.nameAr : c.nameEn).join(", ")} | '
            'Rating: ${p.rating} | PriceLevel: ${p.priceLevel}/4 | '
            'Address: ${isAr ? p.addressAr : p.addressEn}')
        .join('\n');

    return isAr
        ? '''أنت مساعد ذكي لاكتشاف الأماكن المحلية في منطقة الخليج العربي.
تتحدث بالعربية الفصيحة السهلة وتساعد المستخدمين على إيجاد أفضل الأماكن بناءً على تفضيلاتهم.

الأماكن المتوفرة لديك:
$placesSummary

مهمتك:
1. تحليل رسالة المستخدم واستخراج تفضيلاته (نوع الطعام، الميزانية، المسافة، هل مفتوح الآن)
2. الرد بشكل ودي ومحادثاتي
3. دائماً أرجع JSON منظماً في نهاية ردك بالشكل التالي بالضبط:

<PREFS>
{"cuisineType": "sushi|pizza|burger|arabic|coffee|dessert|bakery|indian|pharmacy|supermarket|null", "budgetLevel": 1-4 أو null, "maxDistanceKm": رقم أو null, "openNow": true/false/null, "keywords": [], "hasEnoughSignals": true/false}
</PREFS>'''
        : '''You are an AI assistant for discovering local places in the GCC region.
You speak naturally in English and help users find the best places based on their preferences.

Available places in the system:
$placesSummary

Your task:
1. Analyze the user's message and extract preferences (food type, budget, distance, open now)
2. Reply in a friendly, conversational tone
3. Always return structured JSON at the end of your reply in exactly this format:

<PREFS>
{"cuisineType": "sushi|pizza|burger|arabic|coffee|dessert|bakery|indian|pharmacy|supermarket|null", "budgetLevel": 1-4 or null, "maxDistanceKm": number or null, "openNow": true/false/null, "keywords": [], "hasEnoughSignals": true/false}
</PREFS>''';
  }

  String _buildInterpretationPrompt({
    required String userMessage,
    required String locale,
    required UserPreferences currentPrefs,
    }) {
    final prefsStr = jsonEncode({
      'cuisineType': currentPrefs.cuisineType,
      'budgetLevel': currentPrefs.budgetLevel,
      'maxDistanceKm': currentPrefs.maxDistanceKm,
      'openNow': currentPrefs.openNow,
      'keywords': currentPrefs.keywords,
    });

    return locale == 'ar'
        ? 'التفضيلات الحالية المجمعة من المحادثة: $prefsStr\n\nرسالة المستخدم: "$userMessage"'
        : 'Current preferences collected from conversation: $prefsStr\n\nUser message: "$userMessage"';
  }

  // ── Response parser ────────────────────────────────────────────────────────

  GemmaInterpretationResult _parseInterpretationResult(
      String raw, String locale) {
    // Extract the natural-language part (before <PREFS>).
    final prefsStart = raw.indexOf('<PREFS>');
    final naturalText =
        prefsStart > 0 ? raw.substring(0, prefsStart).trim() : raw.trim();

    // Extract and parse the JSON block.
    UserPreferences prefs = const UserPreferences.empty();
    bool hasEnoughSignals = false;
    try {
      final jsonStart = raw.indexOf('<PREFS>') + '<PREFS>'.length;
      final jsonEnd = raw.indexOf('</PREFS>');
      if (jsonStart > 0 && jsonEnd > jsonStart) {
        final jsonStr = raw.substring(jsonStart, jsonEnd).trim();
        final map = jsonDecode(jsonStr) as Map<String, dynamic>;
        hasEnoughSignals = map['hasEnoughSignals'] as bool? ?? false;
        prefs = UserPreferences(
          cuisineType: map['cuisineType'] == 'null'
              ? null
              : map['cuisineType'] as String?,
          budgetLevel: map['budgetLevel'] as int?,
          maxDistanceKm: (map['maxDistanceKm'] as num?)?.toDouble(),
          openNow: map['openNow'] as bool?,
          keywords: (map['keywords'] as List<dynamic>?)
                  ?.map((e) => e.toString())
                  .toList() ??
              const [],
        );
      }
    } catch (_) {
      // JSON parse failed — fall back to empty prefs, show the text reply.
    }

    return GemmaInterpretationResult(
      naturalReply: naturalText.isNotEmpty
          ? naturalText
          : nextQuestion(prefs, locale),
      preferences: prefs,
      hasEnoughSignals: hasEnoughSignals,
    );
  }
}

/// Result from [GemmaRecommendationEngine.interpretAsync].
class GemmaInterpretationResult {
  final String naturalReply;
  final UserPreferences preferences;
  final bool hasEnoughSignals;

  const GemmaInterpretationResult({
    required this.naturalReply,
    required this.preferences,
    required this.hasEnoughSignals,
  });
}
