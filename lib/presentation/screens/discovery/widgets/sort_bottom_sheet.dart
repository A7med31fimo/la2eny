import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../providers/places_provider.dart';
import '../../../providers/locale_provider.dart';

class SortBottomSheet extends ConsumerWidget {
  const SortBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeNotifierProvider).languageCode;
    final current = ref.watch(sortByNotifierProvider);

    final options = [
      ('distance', locale == 'ar' ? 'المسافة' : 'Distance', Icons.near_me),
      ('rating', locale == 'ar' ? 'التقييم' : 'Rating', Icons.star),
      ('name', locale == 'ar' ? 'الاسم' : 'Name (A–Z)', Icons.sort_by_alpha),
      ('newest', locale == 'ar' ? 'الأحدث' : 'Newest First', Icons.new_releases_outlined),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(
          20, 16, 20, MediaQuery.of(context).padding.bottom + 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40, height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: AppColors.outline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Text(
            locale == 'ar' ? 'ترتيب حسب' : 'Sort By',
            style: AppTextStyles.headlineMedium,
          ),
          const SizedBox(height: 16),
          ...options.map((opt) {
            final (value, label, icon) = opt;
            final isSelected = current == value;
            return ListTile(
              onTap: () {
                ref.read(sortByNotifierProvider.notifier).setSort(value);
                Navigator.pop(context);
              },
              leading: Icon(
                icon,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
              ),
              title: Text(
                label,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isSelected ? AppColors.primary : AppColors.textPrimary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
              trailing: isSelected
                  ? const Icon(Icons.check_circle, color: AppColors.primary)
                  : null,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              tileColor: isSelected ? AppColors.primaryContainer : null,
            );
          }),
        ],
      ),
    );
  }
}
