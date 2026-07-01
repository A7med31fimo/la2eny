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

class PlaceRepositoryImpl implements IPlaceRepository {
  final AppDatabase _db;
  PlaceRepositoryImpl({required AppDatabase db}) : _db = db;

  @override
  Future<List<Place>> getPlaces({String? categoryId, double? maxDistanceKm,
    double? userLat, double? userLng, double? minRating, bool? openNow,
    int? priceLevel, String? sortBy, int page = 0, int limit = 20}) async {
    List<PlacesTableData> rows = categoryId != null
        ? await _db.placesDao.getPlacesByCategory(int.parse(categoryId))
        : await _db.placesDao.getAllActivePlaces();

    var places = await Future.wait(rows.map(_toEntity));

    if (userLat != null && userLng != null) {
      places = places.map((p) => p.copyWith(distanceKm: Haversine.distanceKm(
        lat1: userLat, lon1: userLng, lat2: p.latitude, lon2: p.longitude))).toList();
    }
    if (maxDistanceKm != null && userLat != null) {
      places = places.where((p) => (p.distanceKm ?? double.infinity) <= maxDistanceKm).toList();
    }
    if (minRating != null) places = places.where((p) => p.rating >= minRating).toList();
    if (priceLevel != null) places = places.where((p) => p.priceLevel == priceLevel).toList();
    if (openNow == true) places = places.where((p) => p.isOpenNow).toList();

    switch (sortBy ?? 'distance') {
      case 'rating': places.sort((a, b) => b.rating.compareTo(a.rating)); break;
      case 'name': places.sort((a, b) => a.nameEn.compareTo(b.nameEn)); break;
      case 'newest': places.sort((a, b) => b.createdAt.compareTo(a.createdAt)); break;
      default: places.sort((a, b) => (a.distanceKm ?? 999).compareTo(b.distanceKm ?? 999));
    }

    final start = page * limit;
    if (start >= places.length) return [];
    return places.sublist(start, (start + limit).clamp(0, places.length));
  }

  @override
  Future<List<Place>> searchPlaces({required String query, double? userLat, double? userLng, int limit = 20}) async {
    final rows = await _db.placesDao.searchPlaces(query);
    var places = await Future.wait(rows.map(_toEntity));
    if (userLat != null && userLng != null) {
      places = places.map((p) => p.copyWith(distanceKm: Haversine.distanceKm(
        lat1: userLat, lon1: userLng, lat2: p.latitude, lon2: p.longitude))).toList();
    }
    return places.take(limit).toList();
  }

  @override
  Future<Place?> getPlaceById(int id) async {
    final row = await _db.placesDao.getPlaceById(id);
    return row == null ? null : _toEntity(row);
  }

  @override
  Future<List<Category>> getCategories() async {
    final rows = await _db.categoriesDao.getAllCategories();
    return rows.map((r) => Category(id: r.id, nameAr: r.nameAr, nameEn: r.nameEn, icon: r.icon)).toList();
  }

  @override
  Future<List<Place>> getRankedPlaces({required UserPreferences preferences,
    double? userLat, double? userLng, int limit = 10}) async {
    var places = await getPlaces(
      userLat: userLat, userLng: userLng,
      maxDistanceKm: preferences.maxDistanceKm ?? AppConstants.defaultSearchRadiusKm,
      openNow: preferences.openNow, limit: 200);
    if (preferences.excludedIds.isNotEmpty) {
      places = places.where((p) => !preferences.excludedIds.contains(p.id)).toList();
    }
    final scored = places.map((p) => p.copyWith(
      matchScore: _score(p, preferences, userLat, userLng))).toList();
    scored.sort((a, b) => (b.matchScore ?? 0).compareTo(a.matchScore ?? 0));
    return scored.take(limit).toList();
  }

  @override Future<void> toggleFavorite(int placeId, String userId) async {
    final isFav = await _db.favoritesDao.isFavorite(userId, placeId);
    isFav ? await _db.favoritesDao.removeFavorite(userId, placeId)
           : await _db.favoritesDao.addFavorite(userId, placeId);
  }

  @override Future<List<int>> getFavoriteIds(String userId) => _db.favoritesDao.getFavoriteIds(userId);

  @override Future<List<Place>> getFavoritePlaces(String userId) async {
    final rows = await _db.favoritesDao.getFavoritePlaces(userId);
    return Future.wait(rows.map(_toEntity));
  }

  Future<Place> _toEntity(PlacesTableData row) async {
    final cats = await _db.placesDao.getCategoriesForPlace(row.id);
    final hrs = await _db.placesDao.getWorkingHoursForPlace(row.id);
    final imgs = await _db.placesDao.getImagesForPlace(row.id);
    final links = await _db.placesDao.getSocialLinksForPlace(row.id);
    return Place(
      id: row.id, nameAr: row.nameAr, nameEn: row.nameEn,
      descriptionAr: row.descriptionAr, descriptionEn: row.descriptionEn,
      addressAr: row.addressAr, addressEn: row.addressEn,
      latitude: row.latitude, longitude: row.longitude,
      phone: row.phone, website: row.website, rating: row.rating,
      reviewCount: row.reviewCount, priceLevel: row.priceLevel, isActive: row.isActive,
      updatedAt: DateTime.parse(row.updatedAt), createdAt: DateTime.parse(row.createdAt),
      categories: cats.map((c) => Category(id: c.id, nameAr: c.nameAr, nameEn: c.nameEn, icon: c.icon)).toList(),
      workingHours: hrs.map((h) => WorkingHours(id: h.id, placeId: h.placeId, dayOfWeek: h.dayOfWeek,
        openTime: h.openTime, closeTime: h.closeTime, isClosed: h.isClosed)).toList(),
      images: imgs.map((i) => PlaceImage(id: i.id, placeId: i.placeId, url: i.url,
        isPrimary: i.isPrimary, sortOrder: i.sortOrder)).toList(),
      socialLinks: links.map((s) => SocialLink(id: s.id, placeId: s.placeId,
        platform: SocialLink.platformFromString(s.platform), url: s.url)).toList(),
    );
  }

  double _score(Place p, UserPreferences prefs, double? lat, double? lng) {
    double s = 0;
    if (prefs.cuisineType != null) {
      final cl = prefs.cuisineType!.toLowerCase();
      s += p.categories.any((c) => c.nameEn.toLowerCase().contains(cl)) ? 35 : 0;
    } else { s += 17.5; }
    if (prefs.budgetLevel != null) {
      final diff = (p.priceLevel - prefs.budgetLevel!).abs();
      s += diff == 0 ? 20 : diff == 1 ? 10 : 0;
    } else { s += 10; }
    if (lat != null && lng != null && p.distanceKm != null) {
      final max = prefs.maxDistanceKm ?? AppConstants.defaultSearchRadiusKm;
      s += (1 - (p.distanceKm! / max)).clamp(0.0, 1.0) * 20;
    } else { s += 10; }
    s += (p.rating / 5.0) * 15;
    if (p.isOpenNow) s += 10;
    return s.clamp(0, 100);
  }
}
