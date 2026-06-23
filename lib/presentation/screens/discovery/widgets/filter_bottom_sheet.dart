import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../providers/places_provider.dart';
import '../../../providers/locale_provider.dart';

class FilterBottomSheet extends ConsumerStatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  ConsumerState<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends ConsumerState<FilterBottomSheet> {
  late PlaceFilter _draft;

  @override
  void initState() {
    super.initState();
    _draft = ref.read(placeFilterNotifierProvider);
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(localeNotifierProvider).languageCode;
    final categoriesAsync = ref.watch(categoriesProvider);

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
          _handle(),
          _header(locale),
          const Divider(),
          const SizedBox(height: 12),
          _sectionLabel(locale == 'ar' ? 'المسافة' : 'Distance'),
          _distanceOptions(locale),
          const SizedBox(height: 20),
          _sectionLabel(locale == 'ar' ? 'الحد الأدنى للتقييم' : 'Minimum Rating'),
          _ratingOptions(),
          const SizedBox(height: 20),
          _sectionLabel(locale == 'ar' ? 'نطاق السعر' : 'Price Range'),
          _priceOptions(),
          const SizedBox(height: 20),
          _openNowToggle(locale),
          const SizedBox(height: 24),
          _buttons(locale),
        ],
      ),
    );
  }

  Widget _handle() => Center(
        child: Container(
          width: 40, height: 4,
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: AppColors.outline,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      );

  Widget _header(String locale) => Row(
        children: [
          Text(
            locale == 'ar' ? 'تصفية الأماكن' : 'Filter Places',
            style: AppTextStyles.headlineMedium,
          ),
          const Spacer(),
          TextButton(
            onPressed: () => setState(() => _draft = const PlaceFilter()),
            child: Text(locale == 'ar' ? 'إعادة تعيين' : 'Reset'),
          ),
        ],
      );

  Widget _sectionLabel(String label) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(label, style: AppTextStyles.labelLarge),
      );

  Widget _distanceOptions(String locale) {
    final options = AppConstants.distanceFilterOptions;
    return Wrap(
      spacing: 8,
      children: [
        _Option(
          label: locale == 'ar' ? 'الكل' : 'Any',
          selected: _draft.maxDistanceKm == null,
          onTap: () => setState(() => _draft = _draft.copyWith(clearDistance: true)),
        ),
        ...options.map((km) => _Option(
              label: '${km.toInt()} km',
              selected: _draft.maxDistanceKm == km,
              onTap: () => setState(() => _draft = _draft.copyWith(maxDistanceKm: km)),
            )),
      ],
    );
  }

  Widget _ratingOptions() => Wrap(
        spacing: 8,
        children: [
          _Option(
            label: 'Any',
            selected: _draft.minRating == null,
            onTap: () => setState(() => _draft = _draft.copyWith(clearRating: true)),
          ),
          ...[3.0, 3.5, 4.0, 4.5].map((r) => _Option(
                label: '★ $r+',
                selected: _draft.minRating == r,
                onTap: () => setState(() => _draft = _draft.copyWith(minRating: r)),
              )),
        ],
      );

  Widget _priceOptions() => Wrap(
        spacing: 8,
        children: [
          _Option(
            label: 'Any',
            selected: _draft.priceLevel == null,
            onTap: () => setState(() => _draft = _draft.copyWith(clearPrice: true)),
          ),
          ...[1, 2, 3, 4].map((p) => _Option(
                label: '\$' * p,
                selected: _draft.priceLevel == p,
                onTap: () => setState(() => _draft = _draft.copyWith(priceLevel: p)),
              )),
        ],
      );

  Widget _openNowToggle(String locale) => Row(
        children: [
          Text(
            locale == 'ar' ? 'مفتوح الآن' : 'Open Now',
            style: AppTextStyles.labelLarge,
          ),
          const Spacer(),
          Switch.adaptive(
            value: _draft.openNow,
            onChanged: (v) => setState(() => _draft = _draft.copyWith(openNow: v)),
            activeColor: AppColors.primary,
          ),
        ],
      );

  Widget _buttons(String locale) => Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: Text(locale == 'ar' ? 'إلغاء' : 'Cancel'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                ref.read(placeFilterNotifierProvider.notifier).updateFilter(_draft);
                Navigator.pop(context);
              },
              child: Text(locale == 'ar' ? 'تطبيق' : 'Apply'),
            ),
          ),
        ],
      );
}

class _Option extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _Option({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryContainer : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(10),
          border: selected ? Border.all(color: AppColors.primary) : null,
        ),
        child: Text(
          label,
          style: AppTextStyles.labelMedium.copyWith(
            color: selected ? AppColors.primary : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
