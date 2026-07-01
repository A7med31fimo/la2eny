import '../entities/user_preferences.dart';
import '../entities/place.dart';

/// Result of interpreting a user chat message.
class ChatInterpretation {
  final UserPreferences preferences;
  final bool recognisedSomething;

  const ChatInterpretation({
    required this.preferences,
    required this.recognisedSomething,
  });
}

/// Contract every recommendation engine must satisfy.
abstract class IRecommendationEngine {
  /// Synchronously interpret [message] and extract [UserPreferences].
  ChatInterpretation interpret(String message, String locale);

  /// Return an initial greeting for the given locale.
  String greeting(String locale);

  /// Return the next clarifying question to ask.
  String nextQuestion(UserPreferences prefs, String locale);

  /// Summarise the recommendation list for the user.
  String summarise(List<Place> recommendations, String locale);
}

/// Simple keyword-based engine used when no Gemini API key is provided.
class KeywordRecommendationEngine implements IRecommendationEngine {
  const KeywordRecommendationEngine();

  // ── cuisine / type keywords ──────────────────────────────────────────────
  static const _cuisineMap = {
    'sushi': ['sushi', 'japanese', 'يابان', 'سوشي'],
    'pizza': ['pizza', 'بيتزا', 'italian', 'ايطال'],
    'burger': ['burger', 'برجر', 'hamburger', 'fast food', 'وجبة سريعة'],
    'arabic': ['arabic', 'عربي', 'مندي', 'مشاوي', 'kabsa', 'mandi'],
    'coffee': ['coffee', 'قهوة', 'cafe', 'كافيه', 'cappuccino', 'latte'],
    'dessert': ['dessert', 'حلويات', 'ice cream', 'ايس كريم', 'sweets'],
    'bakery': ['bakery', 'مخبز', 'bread', 'خبز', 'pastry'],
    'indian': ['indian', 'هندي', 'biryani', 'برياني', 'curry'],
    'pharmacy': ['pharmacy', 'صيدلية', 'medicine', 'دواء'],
    'supermarket': ['supermarket', 'سوبرماركت', 'grocery', 'بقالة'],
  };

  // ── budget keywords ──────────────────────────────────────────────────────
  static const _budgetMap = {
    1: ['cheap', 'budget', 'رخيص', 'اقتصادي', 'affordable'],
    2: ['moderate', 'mid', 'متوسط', 'medium'],
    3: ['expensive', 'fine', 'فاخر', 'غالي', 'luxury'],
    4: ['ultra', 'premium', 'فخم', 'very expensive'],
  };

  @override
  ChatInterpretation interpret(String message, String locale) {
    final lower = message.toLowerCase();

    String? cuisineType;
    for (final entry in _cuisineMap.entries) {
      if (entry.value.any((kw) => lower.contains(kw))) {
        cuisineType = entry.key;
        break;
      }
    }

    int? budgetLevel;
    for (final entry in _budgetMap.entries) {
      if (entry.value.any((kw) => lower.contains(kw))) {
        budgetLevel = entry.key;
        break;
      }
    }

    final bool? openNow = lower.contains('open') ||
            lower.contains('now') ||
            lower.contains('مفتوح') ||
            lower.contains('الآن')
        ? true
        : null;

    double? maxDistanceKm;
    final distMatch = RegExp(r'(\d+(?:\.\d+)?)\s*km').firstMatch(lower);
    if (distMatch != null) {
      maxDistanceKm = double.tryParse(distMatch.group(1)!);
    }

    final keywords = message
        .split(RegExp(r'\s+'))
        .where((w) => w.length > 3)
        .take(5)
        .toList();

    final prefs = UserPreferences(
      cuisineType: cuisineType,
      budgetLevel: budgetLevel,
      openNow: openNow,
      maxDistanceKm: maxDistanceKm,
      keywords: keywords,
    );

    return ChatInterpretation(
      preferences: prefs,
      recognisedSomething: cuisineType != null ||
          budgetLevel != null ||
          openNow != null ||
          maxDistanceKm != null,
    );
  }

  @override
  String greeting(String locale) => locale == 'ar'
      ? 'مرحباً! 👋 أنا مساعدك للعثور على أفضل الأماكن المحلية.\n\nأخبرني ماذا تبحث عنه — مطعم، مقهى، صيدلية؟'
      : 'Hi there! 👋 I\'m your AI assistant for finding great local places.\n\nTell me what you\'re looking for — a restaurant, café, pharmacy?';

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
    if (prefs.openNow == null) {
      return isAr
          ? 'هل تريد مكاناً مفتوحاً الآن؟'
          : 'Do you want somewhere open right now?';
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
}
