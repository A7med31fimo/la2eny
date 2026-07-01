import '../entities/place.dart';
import '../entities/category.dart';
import '../entities/user_preferences.dart';
abstract class IPlaceRepository {
  Future<List<Place>> getPlaces({String? categoryId, double? maxDistanceKm,
    double? userLat, double? userLng, double? minRating, bool? openNow,
    int? priceLevel, String? sortBy, int page, int limit});
  Future<List<Place>> searchPlaces({required String query, double? userLat, double? userLng, int limit});
  Future<Place?> getPlaceById(int id);
  Future<List<Category>> getCategories();
  Future<List<Place>> getRankedPlaces({required UserPreferences preferences, double? userLat, double? userLng, int limit});
  Future<void> toggleFavorite(int placeId, String userId);
  Future<List<int>> getFavoriteIds(String userId);
  Future<List<Place>> getFavoritePlaces(String userId);
}
