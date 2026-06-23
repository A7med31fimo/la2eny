import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'locale_provider.g.dart';

const _localeKey = 'app_locale';

@riverpod
class LocaleNotifier extends _$LocaleNotifier {
  @override
  Locale build() => const Locale('en'); // default

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_localeKey);
    if (saved != null) {
      state = Locale(saved);
    } else {
      // Detect device locale, default to Arabic if GCC device
      final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
      state = deviceLocale.languageCode == 'ar'
          ? const Locale('ar')
          : const Locale('en');
    }
  }

  Future<void> setLocale(String languageCode) async {
    state = Locale(languageCode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, languageCode);
  }

  bool get isArabic => state.languageCode == 'ar';
}
