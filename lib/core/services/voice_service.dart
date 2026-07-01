import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';

enum VoiceAvailability { available, notAvailable, denied }

/// Provides speech-to-text (STT) and text-to-speech (TTS) functionality.
class VoiceService {
  final SpeechToText _stt = SpeechToText();
  final FlutterTts _tts = FlutterTts();

  bool _initialised = false;
  bool _sttAvailable = false;
  bool _isListening = false;

  bool get isListening => _isListening;

  // ── Initialisation ────────────────────────────────────────────────────────

  Future<VoiceAvailability> init() async {
    if (_initialised) {
      return _sttAvailable
          ? VoiceAvailability.available
          : VoiceAvailability.notAvailable;
    }
    try {
      _sttAvailable = await _stt.initialize(
        onError: (e) {
          debugPrint('STT error: $e');
          _isListening = false;
        },
      );
      await _tts.setSpeechRate(0.5);
      await _tts.setVolume(1.0);
      await _tts.setPitch(1.0);
      _initialised = true;
      return _sttAvailable
          ? VoiceAvailability.available
          : VoiceAvailability.notAvailable;
    } catch (e) {
      debugPrint('VoiceService.init error: $e');
      _initialised = true;
      _sttAvailable = false;
      return VoiceAvailability.notAvailable;
    }
  }

  // ── STT ──────────────────────────────────────────────────────────────────

  /// Start listening. [onResult] is called with partial results.
  /// [onFinal] is called once with the final transcription.
  Future<void> listen({
    required String localeCode,
    required void Function(String text) onResult,
    required void Function(String finalText) onFinal,
  }) async {
    if (!_sttAvailable || _isListening) return;
    try {
      _isListening = true;
      await _stt.listen(
        onResult: (result) {
          onResult(result.recognizedWords);
          if (result.finalResult) {
            _isListening = false;
            onFinal(result.recognizedWords);
          }
        },
        localeId: localeCode == 'ar' ? 'ar_SA' : 'en_US',
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 3),
        cancelOnError: true,
      );
    } catch (e) {
      debugPrint('VoiceService.listen error: $e');
      _isListening = false;
    }
  }

  Future<void> stopListening() async {
    if (!_isListening) return;
    await _stt.stop();
    _isListening = false;
  }

  Future<void> cancelListening() async {
    if (!_isListening) return;
    await _stt.cancel();
    _isListening = false;
  }

  // ── TTS ──────────────────────────────────────────────────────────────────

  Future<void> speak(String text, [String locale = 'en']) async {
    try {
      await _tts.setLanguage(locale == 'ar' ? 'ar-SA' : 'en-US');
      await _tts.speak(text);
    } catch (e) {
      debugPrint('VoiceService.speak error: $e');
    }
  }

  Future<void> stopSpeaking() async {
    try {
      await _tts.stop();
    } catch (e) {
      debugPrint('VoiceService.stopSpeaking error: $e');
    }
  }

  // ── Disposal ─────────────────────────────────────────────────────────────

  Future<void> dispose() async {
    await stopListening();
    await stopSpeaking();
  }
}
