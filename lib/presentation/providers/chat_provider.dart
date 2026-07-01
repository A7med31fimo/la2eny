import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/gemma_service.dart';
import '../../core/services/voice_service.dart';
import '../../domain/services/recommendation_engine.dart';

/// Gemini API key — supply via:
///   flutter run --dart-define=GEMINI_API_KEY=your_key_here
///
/// Get a free key at https://aistudio.google.com/app/apikey
const _geminiApiKey = String.fromEnvironment('GEMINI_API_KEY', defaultValue: '');

/// Provides the recommendation engine.
///
/// • If GEMINI_API_KEY is set at build time → uses [GemmaRecommendationEngine]
///   (Gemma 4 via Google AI).
/// • Otherwise → falls back to the local keyword-based engine so the app
///   still works without a key (e.g. CI, quick local tests).
final recommendationEngineProvider = Provider<IRecommendationEngine>((ref) {
  if (_geminiApiKey.isNotEmpty) {
    return GemmaRecommendationEngine(apiKey: _geminiApiKey);
  }
  return const KeywordRecommendationEngine();
});

/// Gemma engine provider — always returns the Gemma engine for screens that
/// want async [GemmaRecommendationEngine.interpretAsync] directly.
final gemmaEngineProvider = Provider<GemmaRecommendationEngine?>((ref) {
  if (_geminiApiKey.isNotEmpty) {
    return GemmaRecommendationEngine(apiKey: _geminiApiKey);
  }
  return null;
});

/// Voice (STT + TTS) service, disposed with the provider scope.
final voiceServiceProvider = Provider<VoiceService>((ref) {
  final service = VoiceService();
  ref.onDispose(service.dispose);
  return service;
});
