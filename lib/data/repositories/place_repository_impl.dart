import 'package:drift/drift.dart';
import '../../domain/entities/place.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/working_hours.dart';
import '../../domain/entities/place_image.dart';
import '../../domain/entities/social_link.dart';
import '../../domain/entities/user_preferences.dart';
import '../../domain/repositories/i_place_repository.dart';
import '../../core/utils/haversine.dart';
import '../../core/constants/app_constants.dart';
import '../datasources/local/database/app_database.dart';
import '../datasources/local/database/daos/places_dao.dart';
import '../datasources/local/database/daos/favorites_dao.dart';
import '../datasources/local/database/daos/categories_dao.dart';

class PlaceRepositoryImpl implements IPlaceRepository {
  final AppDatabase _db;
  final PlacesDao _placesDao;
  final FavoritesDao _favoritesDao;
  final CategoriesDao _categoriesDao;

  PlaceRepositoryImpl({required AppDatabase db})
      : _db = db,
        _placesDao = db.placesDao,
        _favoritesDao = db.favoritesDao,
        _categoriesDao = db.categoriesDao;

  // ── Place queries ─────────────────────────────────────────────────────────

  @override
  Future<List<Place>> getPlaces({
    String? categoryId,
    double? maxDistanceKm,
    double? userLat,
    double? userLng,
    double? minRating,
    bool? openNow,
    int? priceLevel,
    String? sortBy,
    int page = 0,
    int limit = 20,
  }) async {
    List<PlacesTableData> rows;

    if (categoryId != null) {
      rows = await _placesDao.getPlacesByCategory(int.parse(categoryId));
    } else if (minRating != null) {
      rows = await _placesDao.getPlacesByMinRating(minRating);
    } else {
      rows = await _placesDao.getAllActivePlaces();
    }

    var places = await Future.wait(rows.map(_toEntity));

    // Compute distances
    if (userLat != null && userLng != null) {
      places = places.map((p) => p.copyWith(
            distanceKm: Haversine.distanceKm(
              lat1: userLat,
              lon1: userLng,
              lat2: p.latitude,
              lon2: p.longitude,
            ),
          )).toList();
    }

    // Apply filters
    if (maxDistanceKm != null && userLat != null) {
      places = places
          .where((p) => (p.distanceKm ?? double.infinity) <= maxDistanceKm)
          .toList();
    }
    if (priceLevel != null) {
      places = places.where((p) => p.priceLevel == priceLevel).toList();
    }
    if (openNow == true) {
      places = places.where((p) => p.isOpenNow).toList();
    }

    // Sort
    switch (sortBy ?? 'distance') {
      case 'rating':
        places.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'name':
        places.sort((a, b) => a.nameEn.compareTo(b.nameEn));
        break;
      case 'newest':
        places.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case 'distance':
      default:
        places.sort((a, b) =>
            (a.distanceKm ?? double.infinity)
                .compareTo(b.distanceKm ?? double.infinity));
    }

    // Paginate
    final start = page * limit;
    if (start >= places.length) return [];
    return places.sublist(start, (start + limit).clamp(0, places.length));
  }

  @override
  Future<List<Place>> searchPlaces({
    required String query,
    double? userLat,
    double? userLng,
    int limit = 20,
  }) async {
    final rows = await _placesDao.searchPlaces(query);
    var places = await Future.wait(rows.map(_toEntity));

    if (userLat != null && userLng != null) {
      places = places.map((p) => p.copyWith(
            distanceKm: Haversine.distanceKm(
              lat1: userLat, lon1: userLng,
              lat2: p.latitude, lon2: p.longitude,
            ),
          )).toList();
    }

    return places.take(limit).toList();
  }

  @override
  Future<Place?> getPlaceById(int id) async {
    final row = await _placesDao.getPlaceById(id);
    if (row == null) return null;
    return _toEntity(row);
  }

  @override
  Future<List<Category>> getCategories() async {
    final rows = await _categoriesDao.getAllCategories();
    return rows.map((r) => Category(
          id: r.id,
          nameAr: r.nameAr,
          nameEn: r.nameEn,
          icon: r.icon,
        )).toList();
  }

  @override
  Future<List<Place>> getRankedPlaces({
    required UserPreferences preferences,
    double? userLat,
    double? userLng,
    int limit = 10,
  }) async {
    var places = await getPlaces(
      userLat: userLat,
      userLng: userLng,
      maxDistanceKm: preferences.maxDistanceKm ?? AppConstants.defaultSearchRadiusKm,
      openNow: preferences.openNow,
      limit: 200, // fetch wide pool for ranking
    );

    // Exclude unwanted places
    if (preferences.excludedIds.isNotEmpty) {
      places = places.where((p) => !preferences.excludedIds.contains(p.id)).toList();
    }

    // Score each place
    final scored = places.map((p) => p.copyWith(
          matchScore: _scorePlace(p, preferences, userLat, userLng),
        )).toList();

    scored.sort((a, b) => (b.matchScore ?? 0).compareTo(a.matchScore ?? 0));
    return scored.take(limit).toList();
  }

  // ── Favorites ─────────────────────────────────────────────────────────────

  @override
  Future<void> toggleFavorite(int placeId, String userId) async {
    final isFav = await _favoritesDao.isFavorite(userId, placeId);
    if (isFav) {
      await _favoritesDao.removeFavorite(userId, placeId);
    } else {
      await _favoritesDao.addFavorite(userId, placeId);
    }
  }

  @override
  Future<List<int>> getFavoriteIds(String userId) =>
      _favoritesDao.getFavoriteIds(userId);

  @override
  Future<List<Place>> getFavoritePlaces(String userId) async {
    final rows = await _favoritesDao.getFavoritePlaces(userId);
    return Future.wait(rows.map(_toEntity));
  }

  // ── Private helpers ───────────────────────────────────────────────────────

  Future<Place> _toEntity(PlacesTableData row) async {
    final categories = await _placesDao.getCategoriesForPlace(row.id);
    final hours = await _placesDao.getWorkingHoursForPlace(row.id);
    final images = await _placesDao.getImagesForPlace(row.id);
    final links = await _placesDao.getSocialLinksForPlace(row.id);

    return Place(
      id: row.id,
      nameAr: row.nameAr,
      nameEn: row.nameEn,
      descriptionAr: row.descriptionAr,
      descriptionEn: row.descriptionEn,
      addressAr: row.addressAr,
      addressEn: row.addressEn,
      latitude: row.latitude,
      longitude: row.longitude,
      phone: row.phone,
      website: row.website,
      rating: row.rating,
      reviewCount: row.reviewCount,
      priceLevel: row.priceLevel,
      isActive: row.isActive,
      updatedAt: DateTime.parse(row.updatedAt),
      createdAt: DateTime.parse(row.createdAt),
      categories: categories.map((c) => Category(
            id: c.id, nameAr: c.nameAr, nameEn: c.nameEn, icon: c.icon,
          )).toList(),
      workingHours: hours.map((h) => WorkingHours(
            id: h.id, placeId: h.placeId, dayOfWeek: h.dayOfWeek,
            openTime: h.openTime, closeTime: h.closeTime, isClosed: h.isClosed,
          )).toList(),
      images: images.map((i) => PlaceImage(
            id: i.id, placeId: i.placeId, url: i.url,
            isPrimary: i.isPrimary, sortOrder: i.sortOrder,
          )).toList(),
      socialLinks: links.map((s) => SocialLink(
            id: s.id, placeId: s.placeId,
            platform: SocialLink.platformFromString(s.platform), url: s.url,
          )).toList(),
    );
  }

  double _scorePlace(
    Place place,
    UserPreferences prefs,
    double? userLat,
    double? userLng,
  ) {
    double score = 0;

    // Category match (35%)
    if (prefs.cuisineType != null) {
      final cuisineLower = prefs.cuisineType!.toLowerCase();
      final catMatch = place.categories.any((c) =>
          c.nameEn.toLowerCase().contains(cuisineLower) ||
          c.nameAr.contains(cuisineLower) ||
          place.descriptionEn.toLowerCase().contains(cuisineLower));
      score += catMatch ? 35 : 0;
    } else {
      score += 17.5; // neutral when no preference
    }

    // Budget match (20%)
    if (prefs.budgetLevel != null) {
      final diff = (place.priceLevel - prefs.budgetLevel!).abs();
      score += diff == 0 ? 20 : diff == 1 ? 10 : 0;
    } else {
      score += 10;
    }

    // Distance score (20%)
    if (userLat != null && userLng != null && place.distanceKm != null) {
      final maxDist = prefs.maxDistanceKm ?? AppConstants.defaultSearchRadiusKm;
      final distScore = (1 - (place.distanceKm! / maxDist)).clamp(0.0, 1.0);
      score += distScore * 20;
    } else {
      score += 10;
    }

    // Rating score (15%)
    score += (place.rating / 5.0) * 15;

    // Open now bonus (10%)
    if (place.isOpenNow) score += 10;

    // Keyword boost
    for (final kw in prefs.keywords) {
      final kwLower = kw.toLowerCase();
      if (place.nameEn.toLowerCase().contains(kwLower) ||
          place.descriptionEn.toLowerCase().contains(kwLower)) {
        score += 5;
      }
    }

    return score.clamp(0, 100);
  }
}
