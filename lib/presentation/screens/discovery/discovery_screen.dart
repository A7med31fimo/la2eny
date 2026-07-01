import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../domain/entities/place.dart';
import '../../providers/places_provider.dart';
import '../../providers/locale_provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/sync_provider.dart';
import '../../router/app_router.dart';
import '../../widgets/place_list_tile.dart';
import '../../widgets/sync_status_bar.dart';
import 'widgets/filter_bottom_sheet.dart';
import 'widgets/sort_bottom_sheet.dart';

class DiscoveryScreen extends ConsumerWidget {
  const DiscoveryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeNotifierProvider).languageCode;
    final filter = ref.watch(placeFilterNotifierProvider);
    final sortBy = ref.watch(sortByNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(children: [
        const SyncStatusBar(),
        _header(context, ref, locale, filter, sortBy),
        Expanded(child: _body(context, ref, locale)),
      ]),
    );
  }

  Widget _header(BuildContext ctx, WidgetRef ref, String locale, PlaceFilter filter, String sortBy) {
    return Container(
      color: AppColors.surface,
      padding: EdgeInsets.fromLTRB(16, MediaQuery.of(ctx).padding.top + 12, 16, 12),
      child: Column(children: [
        Row(children: [
          Text(locale == 'ar' ? 'اكتشف' : 'Discover', style: AppTextStyles.headlineLarge),
          const Spacer(),
        ]),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => ctx.push(AppRoutes.search),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(12)),
            child: Row(children: [
              const Icon(Icons.search, color: AppColors.textTertiary, size: 18), const SizedBox(width: 8),
              Text(locale == 'ar' ? 'ابحث عن أماكن...' : 'Search places...',
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textTertiary)),
            ]),
          ),
        ),
        const SizedBox(height: 10),
        Row(children: [
          _chip(locale == 'ar' ? 'تصفية' : 'Filter', Icons.tune, filter.hasActiveFilters, filter.activeFilterCount,
            () => showModalBottomSheet(context: ctx, isScrollControlled: true, backgroundColor: Colors.transparent,
              builder: (_) => const FilterBottomSheet())),
          const SizedBox(width: 8),
          _chip(_sortLabel(sortBy, locale), Icons.sort, sortBy != 'distance', 0,
            () => showModalBottomSheet(context: ctx, backgroundColor: Colors.transparent,
              builder: (_) => const SortBottomSheet())),
          if (filter.hasActiveFilters) ...[
            const Spacer(),
            TextButton(
              onPressed: () {
                ref.read(placeFilterNotifierProvider.notifier).reset();
                ref.read(sortByNotifierProvider.notifier).setSort('distance');
              },
              child: Text(locale == 'ar' ? 'إعادة تعيين' : 'Reset',
                style: AppTextStyles.labelMedium.copyWith(color: AppColors.error))),
          ],
        ]),
      ]),
    );
  }

  Widget _chip(String label, IconData icon, bool active, int count, VoidCallback onTap) =>
    GestureDetector(onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: active ? AppColors.primaryContainer : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(10),
          border: active ? Border.all(color: AppColors.primary) : null),
        child: Row(children: [
          Icon(icon, size: 14, color: active ? AppColors.primary : AppColors.textSecondary),
          const SizedBox(width: 6),
          Text(label, style: AppTextStyles.labelMedium.copyWith(color: active ? AppColors.primary : AppColors.textSecondary)),
          if (count > 0) ...[
            const SizedBox(width: 4),
            Container(padding: const EdgeInsets.all(3), decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
              child: Text('$count', style: AppTextStyles.labelSmall.copyWith(color: Colors.white, fontSize: 10))),
          ],
        ]),
      ));

  Widget _body(BuildContext ctx, WidgetRef ref, String locale) {
    final placesAsync = ref.watch(placesProvider);
    return placesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.wifi_off, size: 64, color: AppColors.textTertiary), const SizedBox(height: 16),
        Text(locale == 'ar' ? 'لا يوجد اتصال' : 'No internet connection', style: AppTextStyles.headlineMedium),
        const SizedBox(height: 8),
        Text(locale == 'ar' ? 'تعرض البيانات المخزنة' : 'Showing cached data', style: AppTextStyles.bodySmall),
      ])),
      data: (places) {
        if (places.isEmpty) {
          return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.search_off, size: 64, color: AppColors.textTertiary), const SizedBox(height: 16),
          Text(locale == 'ar' ? 'لا توجد أماكن' : 'No places found', style: AppTextStyles.headlineMedium),
          const SizedBox(height: 8),
          Text(locale == 'ar' ? 'جرب تعديل الفلاتر' : 'Try adjusting your filters', style: AppTextStyles.bodySmall),
        ]));
        }
        return RefreshIndicator(
          onRefresh: () => ref.read(syncNotifierProvider.notifier).triggerSync(),
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 24),
            itemCount: places.length,
            itemBuilder: (_, i) {
              final place = places[i];
              final auth = ref.read(authNotifierProvider);
              final userId = auth?.id ?? '';
              final isFav = userId.isNotEmpty
                ? (ref.watch(favoriteIdsProvider(userId)).asData?.value?.contains(place.id) ?? false)
                : false;
              return PlaceListTile(
                place: place, locale: locale, isFavorite: isFav,
                onTap: () => ctx.push(AppRoutes.placeDetailPath(place.id)),
                onFavoriteTap: auth != null && !auth.isGuest ? () async {
                  await ref.read(placeRepositoryProvider).toggleFavorite(place.id, userId);
                  ref.invalidate(favoriteIdsProvider(userId));
                } : null);
            }),
        );
      });
  }

  String _sortLabel(String s, String locale) {
    final m = {'distance': locale=='ar'?'المسافة':'Distance','rating': locale=='ar'?'التقييم':'Rating',
      'name': locale=='ar'?'الاسم':'Name','newest': locale=='ar'?'الأحدث':'Newest'};
    return m[s] ?? 'Sort';
  }
}
