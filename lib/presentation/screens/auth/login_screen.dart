import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../providers/locale_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeNotifierProvider).languageCode;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(locale == 'ar' ? 'تسجيل الدخول' : 'Sign In')),
      body: Padding(padding: const EdgeInsets.all(24),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(width: 80, height: 80, decoration: BoxDecoration(
            color: AppColors.primaryContainer, borderRadius: BorderRadius.circular(24)),
            child: const Icon(Icons.place, color: AppColors.primary, size: 40)),
          const SizedBox(height: 24),
          Text(locale == 'ar' ? 'أهلاً بك في LocalAI' : 'Welcome to LocalAI',
            style: AppTextStyles.headlineLarge, textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text(locale == 'ar'
            ? 'سجّل دخولك لحفظ المفضلة وتخصيص تجربتك'
            : 'Sign in to save favorites and personalize your experience',
            style: AppTextStyles.bodySmall, textAlign: TextAlign.center),
          const SizedBox(height: 40),
          _socialButton(Icons.g_mobiledata, locale == 'ar' ? 'المتابعة مع Google' : 'Continue with Google',
            Colors.white, AppColors.textPrimary, AppColors.outline, () => context.pop()),
          const SizedBox(height: 12),
          _socialButton(Icons.apple, locale == 'ar' ? 'المتابعة مع Apple' : 'Continue with Apple',
            Colors.black, Colors.white, Colors.black, () => context.pop()),
          const SizedBox(height: 24),
          TextButton(onPressed: () => context.pop(),
            child: Text(locale == 'ar' ? 'المتابعة كضيف' : 'Continue as Guest',
              style: AppTextStyles.labelLarge.copyWith(color: AppColors.textSecondary))),
        ])),
    );
  }

  Widget _socialButton(IconData icon, String label, Color bg, Color fg, Color border, VoidCallback onTap) =>
    SizedBox(width: double.infinity, height: 52,
      child: OutlinedButton.icon(icon: Icon(icon, color: fg),
        label: Text(label, style: AppTextStyles.button.copyWith(color: fg)),
        style: OutlinedButton.styleFrom(backgroundColor: bg,
          side: BorderSide(color: border),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        onPressed: onTap));
}
