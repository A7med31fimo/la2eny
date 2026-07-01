class AiConstants {
  AiConstants._();

  // ── Gemma 4 via Google AI (Gemini API) ────────────────────────────────────
  /// Model ID for Gemma 4 (27B instruction-tuned) on Google AI Studio.
  static const String gemmaModel = 'gemma-3-27b-it';

  /// Base URL for the Google AI generateContent endpoint.
  static const String gemmaBaseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models';

  // ── Generation config ─────────────────────────────────────────────────────
  static const int maxTokens = 512;
  static const double temperature = 0.7;
  static const double topP = 0.9;

  // ── Role labels (kept for chat DB compatibility) ──────────────────────────
  static const String roleUser = 'user';
  static const String roleAssistant = 'assistant';
}
