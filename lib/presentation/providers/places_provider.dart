import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/place.dart';
import '../../domain/entities/category.dart';
import '../../data/repositories/place_repository_impl.dart';
import 'sync_provider.dart';
import 'location_provider.dart';

part 'places_provider.g.dart';

// ── Repository provider ───────────────────────────────────────────────────────

@riverpod
PlaceRepositoryImpl placeRepository(PlaceRepositoryRef ref) =>
    PlaceRepositoryImpl(db: ref.watch(appDatabaseProvider));

// ── Filter & Sort state ───────────────────────────────────────────────────────

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
        maxDistanceKm: clearDistance ? null : maxDistanceKm ?? this.maxDistanceKm,
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
    int count = 0;
    if (categoryId != null) count++;
    if (maxDistanceKm != null) count++;
    if (minRating != null) count++;
    if (openNow) count++;
    if (priceLevel != null) count++;
    return count;
  }
}

@riverpod
class PlaceFilterNotifier extends _$PlaceFilterNotifier {
  @override
  PlaceFilter build() => const PlaceFilter();

  void updateFilter(PlaceFilter filter) => state = filter;
  void reset() => state = const PlaceFilter();
  void setCategoryId(int? id) => state = state.copyWith(categoryId: id, clearCategory: id == null);
  void setMaxDistance(double? km) => state = state.copyWith(maxDistanceKm: km, clearDistance: km == null);
  void setMinRating(double? rating) => state = state.copyWith(minRating: rating, clearRating: rating == null);
  void setOpenNow(bool value) => state = state.copyWith(openNow: value);
  void setPriceLevel(int? level) => state = state.copyWith(priceLevel: level, clearPrice: level == null);
}

@riverpod
class SortByNotifier extends _$SortByNotifier {
  @override
  String build() => 'distance';

  void setSort(String sort) => state = sort;
}

// ── Search state ──────────────────────────────────────────────────────────────

@riverpod
class SearchQueryNotifier extends _$SearchQueryNotifier {
  @override
  String build() => '';

  void setQuery(String q) => state = q;
  void clear() => state = '';
}

// ── Data providers ────────────────────────────────────────────────────────────

@riverpod
Future<List<Category>> categories(CategoriesRef ref) async {
  final repo = ref.watch(placeRepositoryProvider);
  return repo.getCategories();
}

@riverpod
Future<List<Place>> places(PlacesRef ref) async {
  final repo = ref.watch(placeRepositoryProvider);
  final filter = ref.watch(placeFilterNotifierProvider);
  final sortBy = ref.watch(sortByNotifierProvider);
  final location = await ref.watch(userLocationProvider.future);

  return repo.getPlaces(
    categoryId: filter.categoryId?.toString(),
    maxDistanceKm: filter.maxDistanceKm,
    userLat: location?.latitude,
    userLng: location?.longitude,
    minRating: filter.minRating,
    openNow: filter.openNow ? true : null,
    priceLevel: filter.priceLevel,
    sortBy: sortBy,
    limit: 50,
  );
}

@riverpod
Future<List<Place>> searchResults(SearchResultsRef ref) async {
  final query = ref.watch(searchQueryNotifierProvider);
  if (query.trim().isEmpty) return [];

  final repo = ref.watch(placeRepositoryProvider);
  final location = await ref.watch(userLocationProvider.future);

  return repo.searchPlaces(
    query: query,
    userLat: location?.latitude,
    userLng: location?.longitude,
  );
}

@riverpod
Future<Place?> placeDetail(PlaceDetailRef ref, int id) async {
  final repo = ref.watch(placeRepositoryProvider);
  return repo.getPlaceById(id);
}

@riverpod
Future<List<Place>> favoritePlaces(FavoritePlacesRef ref, String userId) async {
  final repo = ref.watch(placeRepositoryProvider);
  return repo.getFavoritePlaces(userId);
}

@riverpod
Future<List<int>> favoriteIds(FavoriteIdsRef ref, String userId) async {
  final repo = ref.watch(placeRepositoryProvider);
  return repo.getFavoriteIds(userId);
}
