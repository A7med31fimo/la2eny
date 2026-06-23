import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../domain/entities/place.dart';
import '../../providers/places_provider.dart';
import '../../providers/locale_provider.dart';
import '../../providers/auth_provider.dart';
import '../../router/app_router.dart';
import '../../widgets/place_list_tile.dart';
import '../../widgets/sync_status_bar.dart';
import 'widgets/filter_bottom_sheet.dart';
import 'widgets/sort_bottom_sheet.dart';

class DiscoveryScreen extends ConsumerStatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  ConsumerState<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends ConsumerState<DiscoveryScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(localeNotifierProvider).languageCode;
    final filter = ref.watch(placeFilterNotifierProvider);
    final sortBy = ref.watch(sortByNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const SyncStatusBar(),
          _buildHeader(locale, filter, sortBy),
          Expanded(child: _buildBody(locale)),
        ],
      ),
    );
  }

  Widget _buildHeader(String locale, PlaceFilter filter, String sortBy) {
    return Container(
      color: AppColors.surface,
      padding: EdgeInsets.fromLTRB(
        16, MediaQuery.of(context).padding.top + 12, 16, 12),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                locale == 'ar' ? 'اكتشف' : 'Discover',
                style: AppTextStyles.headlineLarge,
              ),
              const Spacer(),
              Text(
                locale == 'ar' ? 'الكل' : 'All',
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Search bar
          GestureDetector(
            onTap: () => context.push(AppRoutes.search),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: AppColors.textTertiary, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    locale == 'ar' ? 'ابحث عن أماكن...' : 'Search places...',
                    style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textTertiary),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Filter & Sort row
          Row(
            children: [
              _FilterChip(
                label: locale == 'ar' ? 'تصفية' : 'Filter',
                icon: Icons.tune,
                hasActive: filter.hasActiveFilters,
                count: filter.activeFilterCount,
                onTap: () => _showFilterSheet(context),
              ),
              const SizedBox(width: 8),
              _FilterChip(
                label: _sortLabel(sortBy, locale),
                icon: Icons.sort,
                hasActive: sortBy != 'distance',
                onTap: () => _showSortSheet(context),
              ),
              if (filter.hasActiveFilters) ...[
                const Spacer(),
                TextButton(
                  onPressed: () {
                    ref.read(placeFilterNotifierProvider.notifier).reset();
                    ref.read(sortByNotifierProvider.notifier).setSort('distance');
                  },
                  child: Text(
                    locale == 'ar' ? 'إعادة تعيين' : 'Reset',
                    style: AppTextStyles.labelMedium.copyWith(color: AppColors.error),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBody(String locale) {
    final placesAsync = ref.watch(placesProvider);

    return placesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => _errorState(e.toString(), locale),
      data: (places) {
        if (places.isEmpty) return _emptyState(locale);
        return RefreshIndicator(
          onRefresh: () =>
              ref.read(syncNotifierProvider.notifier).triggerSync(),
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 24),
            itemCount: places.length,
            itemBuilder: (context, i) => _buildTile(places[i], locale),
          ),
        );
      },
    );
  }

  Widget _buildTile(Place place, String locale) {
    final auth = ref.read(authNotifierProvider);
    final userId = auth?.id ?? '';
    final favAsync = userId.isNotEmpty
        ? ref.watch(favoriteIdsProvider(userId))
        : const AsyncData<List<int>>([]);
    final isFav = favAsync.valueOrNull?.contains(place.id) ?? false;

    return PlaceListTile(
      place: place,
      locale: locale,
      isFavorite: isFav,
      onTap: () => context.push(AppRoutes.placeDetailPath(place.id)),
      onFavoriteTap: auth != null && !auth.isGuest
          ? () async {
              await ref.read(placeRepositoryProvider).toggleFavorite(place.id, userId);
              ref.invalidate(favoriteIdsProvider(userId));
            }
          : null,
    );
  }

  Widget _emptyState(String locale) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, size: 64, color: AppColors.textTertiary),
            const SizedBox(height: 16),
            Text(
              locale == 'ar' ? 'لا توجد أماكن' : 'No places found',
              style: AppTextStyles.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              locale == 'ar' ? 'جرب تعديل الفلاتر' : 'Try adjusting your filters',
              style: AppTextStyles.bodySmall,
            ),
          ],
        ),
      );

  Widget _errorState(String message, String locale) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off, size: 64, color: AppColors.textTertiary),
            const SizedBox(height: 16),
            Text(
              locale == 'ar' ? 'لا يوجد اتصال' : 'No internet connection',
              style: AppTextStyles.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              locale == 'ar' ? 'تعرض البيانات المخزنة' : 'Showing cached data',
              style: AppTextStyles.bodySmall,
            ),
          ],
        ),
      );

  String _sortLabel(String sortBy, String locale) {
    final labels = {
      'distance': locale == 'ar' ? 'المسافة' : 'Distance',
      'rating': locale == 'ar' ? 'التقييم' : 'Rating',
      'name': locale == 'ar' ? 'الاسم' : 'Name',
      'newest': locale == 'ar' ? 'الأحدث' : 'Newest',
    };
    return labels[sortBy] ?? 'Sort';
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const FilterBottomSheet(),
    );
  }

  void _showSortSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => const SortBottomSheet(),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool hasActive;
  final int count;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.icon,
    required this.hasActive,
    this.count = 0,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: hasActive ? AppColors.primaryContainer : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(10),
          border: hasActive ? Border.all(color: AppColors.primary, width: 1) : null,
        ),
        child: Row(
          children: [
            Icon(icon, size: 14,
                color: hasActive ? AppColors.primary : AppColors.textSecondary),
            const SizedBox(width: 6),
            Text(label,
                style: AppTextStyles.labelMedium.copyWith(
                  color: hasActive ? AppColors.primary : AppColors.textSecondary,
                )),
            if (count > 0) ...[
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Text('$count',
                    style: AppTextStyles.labelSmall.copyWith(
                        color: Colors.white, fontSize: 10)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
