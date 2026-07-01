import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/place.dart';
import '../../domain/entities/category.dart';
import '../../data/repositories/place_repository_impl.dart';
import 'sync_provider.dart';
import 'location_provider.dart';

final placeRepositoryProvider = Provider<PlaceRepositoryImpl>(
  (ref) => PlaceRepositoryImpl(db: ref.watch(appDatabaseProvider)),
);

// ── Filter ────────────────────────────────────────────────────────────────────
class PlaceFilter {
  final int? categoryId;
  final double? maxDistanceKm;
  final double? minRating;
  final bool openNow;
  final int? priceLevel;

  const PlaceFilter({
    this.categoryId,
    this.maxDistanceKm,
    this.minRating,
    this.openNow = false,
    this.priceLevel,
  });

  PlaceFilter copyWith({
    int? categoryId,
    double? maxDistanceKm,
    double? minRating,
    bool? openNow,
    int? priceLevel,
    bool clearCategory = false,
    bool clearDistance = false,
    bool clearRating = false,
    bool clearPrice = false,
  }) =>
      PlaceFilter(
        categoryId: clearCategory ? null : categoryId ?? this.categoryId,
        maxDistanceKm:
            clearDistance ? null : maxDistanceKm ?? this.maxDistanceKm,
        minRating: clearRating ? null : minRating ?? this.minRating,
        openNow: openNow ?? this.openNow,
        priceLevel: clearPrice ? null : priceLevel ?? this.priceLevel,
      );

  bool get hasActiveFilters =>
      categoryId != null ||
      maxDistanceKm != null ||
      minRating != null ||
      openNow ||
      priceLevel != null;

  int get activeFilterCount {
    int c = 0;
    if (categoryId != null) c++;
    if (maxDistanceKm != null) c++;
    if (minRating != null) c++;
    if (openNow) c++;
    if (priceLevel != null) c++;
    return c;
  }
}

class PlaceFilterNotifier extends Notifier<PlaceFilter> {
  @override
  PlaceFilter build() => const PlaceFilter();

  void updateFilter(PlaceFilter f) => state = f;
  void reset() => state = const PlaceFilter();
  void setCategoryId(int? id) =>
      state = state.copyWith(categoryId: id, clearCategory: id == null);
  void setMaxDistance(double? km) =>
      state = state.copyWith(maxDistanceKm: km, clearDistance: km == null);
  void setMinRating(double? r) =>
      state = state.copyWith(minRating: r, clearRating: r == null);
  void setOpenNow(bool v) => state = state.copyWith(openNow: v);
  void setPriceLevel(int? l) =>
      state = state.copyWith(priceLevel: l, clearPrice: l == null);
}

final placeFilterNotifierProvider =
    NotifierProvider<PlaceFilterNotifier, PlaceFilter>(PlaceFilterNotifier.new);

class SortByNotifier extends Notifier<String> {
  @override
  String build() => 'distance';
  void setSort(String s) => state = s;
}

final sortByNotifierProvider =
    NotifierProvider<SortByNotifier, String>(SortByNotifier.new);

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';
  void setQuery(String q) => state = q;
  void clear() => state = '';
}

final searchQueryNotifierProvider =
    NotifierProvider<SearchQueryNotifier, String>(SearchQueryNotifier.new);

// ── Data providers ─────────────────────────────────────────────────────────────
final categoriesProvider = FutureProvider<List<Category>>((ref) {
  return ref.watch(placeRepositoryProvider).getCategories();
});

final placesProvider = FutureProvider<List<Place>>((ref) async {
  final repo = ref.watch(placeRepositoryProvider);
  final filter = ref.watch(placeFilterNotifierProvider);
  final sortBy = ref.watch(sortByNotifierProvider);
  final loc = await ref.watch(userLocationProvider.future);
  return repo.getPlaces(
    categoryId: filter.categoryId?.toString(),
    maxDistanceKm: filter.maxDistanceKm,
    userLat: loc?.latitude,
    userLng: loc?.longitude,
    minRating: filter.minRating,
    openNow: filter.openNow ? true : null,
    priceLevel: filter.priceLevel,
    sortBy: sortBy,
    limit: 50,
  );
});

final searchResultsProvider = FutureProvider<List<Place>>((ref) async {
  final q = ref.watch(searchQueryNotifierProvider);
  if (q.trim().isEmpty) return [];
  final loc = await ref.watch(userLocationProvider.future);
  return ref.watch(placeRepositoryProvider).searchPlaces(
    query: q,
    userLat: loc?.latitude,
    userLng: loc?.longitude,
  );
});

final placeDetailProvider =
    FutureProvider.family<Place?, int>((ref, id) {
  return ref.watch(placeRepositoryProvider).getPlaceById(id);
});

final favoritePlacesProvider =
    FutureProvider.family<List<Place>, String>((ref, userId) {
  return ref.watch(placeRepositoryProvider).getFavoritePlaces(userId);
});

final favoriteIdsProvider =
    FutureProvider.family<List<int>, String>((ref, userId) {
  return ref.watch(placeRepositoryProvider).getFavoriteIds(userId);
});
