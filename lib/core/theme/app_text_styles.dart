import 'package:flutter/material.dart';
import 'app_colors.dart';
class AppTextStyles {
  AppTextStyles._();
  static const TextStyle displayLarge = TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: AppColors.textPrimary, height: 1.2);
  static const TextStyle headlineLarge = TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary, height: 1.3);
  static const TextStyle headlineMedium = TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary, height: 1.3);
  static const TextStyle headlineSmall = TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary, height: 1.4);
  static const TextStyle bodyLarge = TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.textPrimary, height: 1.6);
  static const TextStyle bodyMedium = TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.textPrimary, height: 1.6);
  static const TextStyle bodySmall = TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.textSecondary, height: 1.5);
  static const TextStyle labelLarge = TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary, letterSpacing: 0.1);
  static const TextStyle labelMedium = TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary, letterSpacing: 0.5);
  static const TextStyle labelSmall = TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.textTertiary, letterSpacing: 0.5);
  static const TextStyle caption = TextStyle(fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.textTertiary);
  static const TextStyle button = TextStyle(fontSize: 15, fontWeight: FontWeight.w600, letterSpacing: 0.2);
  static const TextStyle chatUser = TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.userBubbleText, height: 1.5);
  static const TextStyle chatAi = TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.aiBubbleText, height: 1.5);
  static const TextStyle rating = TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary);
}
