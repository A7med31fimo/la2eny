import '../entities/place.dart';
import '../entities/category.dart';
import '../entities/user_preferences.dart';

abstract class IPlaceRepository {
  /// Get all places with optional filtering and sorting
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
  });

  /// Full-text search in Arabic and English
  Future<List<Place>> searchPlaces({
    required String query,
    double? userLat,
    double? userLng,
    int limit = 20,
  });

  /// Get single place by ID
  Future<Place?> getPlaceById(int id);

  /// Get all categories
  Future<List<Category>> getCategories();

  /// Get places ranked by AI preferences
  Future<List<Place>> getRankedPlaces({
    required UserPreferences preferences,
    double? userLat,
    double? userLng,
    int limit = 10,
  });

  /// Toggle favorite status for a place
  Future<void> toggleFavorite(int placeId, String userId);

  /// Get user's favorite place IDs
  Future<List<int>> getFavoriteIds(String userId);

  /// Get user's favorite places
  Future<List<Place>> getFavoritePlaces(String userId);
}
