import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/services/gemma_service.dart';
import '../../../core/services/voice_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../domain/entities/chat_message.dart';
import '../../../domain/entities/place.dart';
import '../../../domain/entities/user_preferences.dart';
import '../../providers/chat_provider.dart';
import '../../providers/locale_provider.dart';
import '../../providers/location_provider.dart';
import '../../providers/places_provider.dart';
import '../../router/app_router.dart';
import 'widgets/chat_bubble.dart';
import 'widgets/chat_input_bar.dart';
import 'widgets/recommendation_card.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});
  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final List<ChatMessage> _messages = [];
  final _scrollController = ScrollController();
  bool _isThinking = false;
  UserPreferences _prefs = const UserPreferences.empty();

  @override
  void initState() {
    super.initState();
    _addWelcome();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _addWelcome() {
    final locale = ref.read(localeNotifierProvider).languageCode;
    final engine = ref.read(recommendationEngineProvider);
    setState(() =>
        _messages.add(ChatMessage.assistant(content: engine.greeting(locale))));
  }

  Future<void> _onSend(String text) async {
    if (text.trim().isEmpty || _isThinking) return;
    final locale = ref.read(localeNotifierProvider).languageCode;

    setState(() {
      _messages.add(ChatMessage.user(content: text));
      _isThinking = true;
    });
    _scrollToBottom();

    try {
      final gemmaEngine = ref.read(gemmaEngineProvider);

      String responseText;
      List<Place> recs = [];

      if (gemmaEngine != null) {
        // ── Gemma 4 path ────────────────────────────────────────────────────
        final allPlaces = await ref.read(placesProvider.future);

        final result = await gemmaEngine.interpretAsync(
          userMessage: text,
          locale: locale,
          currentPrefs: _prefs,
          availablePlaces: allPlaces,
        );

        _prefs = _prefs.merge(result.preferences);
        responseText = result.naturalReply;

        if (result.hasEnoughSignals || _prefs.hasEnoughSignals) {
          final loc = await ref.read(userLocationProvider.future);
          recs = await ref.read(placeRepositoryProvider).getRankedPlaces(
                preferences: _prefs,
                userLat: loc?.latitude,
                userLng: loc?.longitude,
                limit: 5,
              );
          if (recs.isNotEmpty) {
            final suffix = locale == 'ar'
                ? '\n\n✨ إليك أفضل ${recs.length} اقتراحات:'
                : '\n\n✨ Here are my top ${recs.length} picks:';
            responseText = '$responseText$suffix';
          }
        }
      } else {
        // ── Keyword fallback path ────────────────────────────────────────────
        await Future<void>.delayed(const Duration(milliseconds: 400));
        final engine = ref.read(recommendationEngineProvider);
        final interpretation = engine.interpret(text, locale);
        _prefs = _prefs.merge(interpretation.preferences);

        if (_prefs.hasEnoughSignals) {
          final loc = await ref.read(userLocationProvider.future);
          recs = await ref.read(placeRepositoryProvider).getRankedPlaces(
                preferences: _prefs,
                userLat: loc?.latitude,
                userLng: loc?.longitude,
                limit: 5,
              );
          responseText = engine.summarise(recs, locale);
        } else {
          responseText = engine.nextQuestion(_prefs, locale);
        }
      }

      if (!mounted) return;
      setState(() {
        _isThinking = false;
        _messages
            .add(ChatMessage.assistant(content: responseText, recommendations: recs));
      });
      _scrollToBottom();

      unawaited(ref.read(voiceServiceProvider).speak(responseText, locale));
    } catch (e) {
      if (!mounted) return;
      final locale = ref.read(localeNotifierProvider).languageCode;
      setState(() {
        _isThinking = false;
        _messages.add(ChatMessage.assistant(
          content: locale == 'ar'
              ? 'حدث خطأ في الاتصال بـ Gemma. تأكد من صحة مفتاح API.\n\nالخطأ: $e'
              : 'Failed to reach Gemma. Check your API key.\n\nError: $e',
        ));
      });
      _scrollToBottom();
    }
  }

  Future<void> _onVoice() async {
    final locale = ref.read(localeNotifierProvider).languageCode;
    final voice = ref.read(voiceServiceProvider);
    final availability = await voice.init();
    if (availability != VoiceAvailability.available) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(locale == 'ar'
            ? 'الميكروفون غير متاح على هذا الجهاز'
            : 'Microphone is not available on this device'),
      ));
      return;
    }
    await voice.listen(
      localeCode: locale,
      onResult: (_) {},
      onFinal: (finalText) {
        if (finalText.trim().isNotEmpty) _onSend(finalText);
      },
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _clearChat() {
    ref.read(voiceServiceProvider).stopSpeaking();
    setState(() {
      _messages.clear();
      _prefs = const UserPreferences.empty();
    });
    _addWelcome();
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(localeNotifierProvider).languageCode;
    final isGemmaActive = ref.watch(gemmaEngineProvider) != null;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Row(mainAxisSize: MainAxisSize.min, children: [
          Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                  color: AppColors.primaryContainer,
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.smart_toy_outlined,
                  color: AppColors.primary, size: 20)),
          const SizedBox(width: 10),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(locale == 'ar' ? 'المساعد الذكي' : 'AI Assistant',
                style: AppTextStyles.headlineSmall),
            Row(children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: isGemmaActive ? Colors.green : Colors.orange,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                isGemmaActive ? 'Gemma 4' : 'Keyword Engine',
                style: AppTextStyles.labelSmall,
              ),
            ]),
          ]),
        ]),
        actions: [
          IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _clearChat,
              tooltip: locale == 'ar' ? 'محادثة جديدة' : 'New Chat'),
        ],
      ),
      body: Column(children: [
        // API key hint banner when running without Gemma
        if (!isGemmaActive)
          Container(
            color: Colors.orange.shade50,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(children: [
              const Icon(Icons.info_outline, size: 16, color: Colors.orange),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  locale == 'ar'
                      ? 'لتفعيل Gemma 4: أضف --dart-define=GEMINI_API_KEY=مفتاحك عند التشغيل'
                      : 'To enable Gemma 4: add --dart-define=GEMINI_API_KEY=your_key when running',
                  style: const TextStyle(fontSize: 11, color: Colors.orange),
                ),
              ),
            ]),
          ),
        Expanded(
            child: ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.all(16),
          itemCount: _messages.length + (_isThinking ? 1 : 0),
          itemBuilder: (ctx, i) {
            if (_isThinking && i == _messages.length) {
              return ChatBubble(
                  message: ChatMessage.loading(), locale: locale);
            }
            final msg = _messages[i];
            return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ChatBubble(message: msg, locale: locale),
                  if (msg.hasRecommendations) ...[
                    const SizedBox(height: 8),
                    ...msg.recommendations.map((p) => RecommendationCard(
                        place: p,
                        locale: locale,
                        onTap: () => ctx.push(AppRoutes.placeDetailPath(p.id)))),
                  ],
                ]);
          },
        )),
        ChatInputBar(
            locale: locale,
            onSend: _onSend,
            onVoice: _onVoice,
            isThinking: _isThinking),
      ]),
    );
  }
}
