import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() => const Locale('en');

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('app_locale');
    if (saved != null) {
      state = Locale(saved);
      return;
    }
    final device = WidgetsBinding.instance.platformDispatcher.locale;
    state = device.languageCode == 'ar' ? const Locale('ar') : const Locale('en');
  }

  Future<void> setLocale(String code) async {
    state = Locale(code);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_locale', code);
  }

  bool get isArabic => state.languageCode == 'ar';
}

final localeNotifierProvider = NotifierProvider<LocaleNotifier, Locale>(LocaleNotifier.new);
