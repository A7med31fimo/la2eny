import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../providers/places_provider.dart';
import '../../../providers/locale_provider.dart';

class FilterBottomSheet extends ConsumerStatefulWidget {
  const FilterBottomSheet({super.key});
  @override ConsumerState<FilterBottomSheet> createState() => _State();
}

class _State extends ConsumerState<FilterBottomSheet> {
  late PlaceFilter _draft;
  @override void initState() { super.initState(); _draft = ref.read(placeFilterNotifierProvider); }

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(localeNotifierProvider).languageCode;
    return Container(
      decoration: const BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      padding: EdgeInsets.fromLTRB(20, 16, 20, MediaQuery.of(context).padding.bottom + 20),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(child: Container(width: 40, height: 4, margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(color: AppColors.outline, borderRadius: BorderRadius.circular(2)))),
        Row(children: [
          Text(locale == 'ar' ? 'تصفية الأماكن' : 'Filter Places', style: AppTextStyles.headlineMedium),
          const Spacer(),
          TextButton(onPressed: () => setState(() => _draft = const PlaceFilter()),
            child: Text(locale == 'ar' ? 'إعادة تعيين' : 'Reset')),
        ]),
        const Divider(), const SizedBox(height: 12),
        Text(locale == 'ar' ? 'المسافة' : 'Distance', style: AppTextStyles.labelLarge),
        const SizedBox(height: 10),
        Wrap(spacing: 8, children: [
          _opt('Any', _draft.maxDistanceKm == null, () => setState(() => _draft = _draft.copyWith(clearDistance: true))),
          ...AppConstants.distanceFilterOptions.map((km) => _opt('${km.toInt()} km', _draft.maxDistanceKm == km,
            () => setState(() => _draft = _draft.copyWith(maxDistanceKm: km)))),
        ]),
        const SizedBox(height: 20),
        Text(locale == 'ar' ? 'الحد الأدنى للتقييم' : 'Minimum Rating', style: AppTextStyles.labelLarge),
        const SizedBox(height: 10),
        Wrap(spacing: 8, children: [
          _opt('Any', _draft.minRating == null, () => setState(() => _draft = _draft.copyWith(clearRating: true))),
          ...[3.0, 3.5, 4.0, 4.5].map((r) => _opt('★ $r+', _draft.minRating == r,
            () => setState(() => _draft = _draft.copyWith(minRating: r)))),
        ]),
        const SizedBox(height: 20),
        Text(locale == 'ar' ? 'نطاق السعر' : 'Price Range', style: AppTextStyles.labelLarge),
        const SizedBox(height: 10),
        Wrap(spacing: 8, children: [
          _opt('Any', _draft.priceLevel == null, () => setState(() => _draft = _draft.copyWith(clearPrice: true))),
          ...[1,2,3,4].map((p) => _opt('\$' * p, _draft.priceLevel == p,
            () => setState(() => _draft = _draft.copyWith(priceLevel: p)))),
        ]),
        const SizedBox(height: 20),
        Row(children: [
          Text(locale == 'ar' ? 'مفتوح الآن' : 'Open Now', style: AppTextStyles.labelLarge),
          const Spacer(),
          Switch.adaptive(value: _draft.openNow, activeColor: AppColors.primary,
            onChanged: (v) => setState(() => _draft = _draft.copyWith(openNow: v))),
        ]),
        const SizedBox(height: 24),
        Row(children: [
          Expanded(child: OutlinedButton(onPressed: () => Navigator.pop(context),
            child: Text(locale == 'ar' ? 'إلغاء' : 'Cancel'))),
          const SizedBox(width: 12),
          Expanded(child: ElevatedButton(onPressed: () {
            ref.read(placeFilterNotifierProvider.notifier).updateFilter(_draft);
            Navigator.pop(context);
          }, child: Text(locale == 'ar' ? 'تطبيق' : 'Apply'))),
        ]),
      ]),
    );
  }

  Widget _opt(String label, bool selected, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? AppColors.primaryContainer : AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(10),
        border: selected ? Border.all(color: AppColors.primary) : null),
      child: Text(label, style: AppTextStyles.labelMedium.copyWith(
        color: selected ? AppColors.primary : AppColors.textSecondary))));
}
