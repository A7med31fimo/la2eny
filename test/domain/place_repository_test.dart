import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localai_app/data/datasources/local/database/app_database.dart';
import 'package:localai_app/data/repositories/place_repository_impl.dart';
import 'package:localai_app/domain/entities/user_preferences.dart';

void main() {
  late AppDatabase db;
  late PlaceRepositoryImpl repo;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = PlaceRepositoryImpl(db: db);
  });

  tearDown(() async => db.close());

  group('PlaceRepository', () {
    test('getPlaces returns empty list when no data', () async {
      final places = await repo.getPlaces();
      expect(places, isEmpty);
    });

    test('searchPlaces returns empty list for empty DB', () async {
      final results = await repo.searchPlaces(query: 'burger');
      expect(results, isEmpty);
    });

    test('getCategories returns empty list when no categories', () async {
      final cats = await repo.getCategories();
      expect(cats, isEmpty);
    });

    test('getRankedPlaces returns empty list when no places', () async {
      final ranked = await repo.getRankedPlaces(
        preferences: const UserPreferences(cuisineType: 'italian'),
        userLat: 24.7, userLng: 46.6,
      );
      expect(ranked, isEmpty);
    });

    test('getFavoriteIds returns empty list for new user', () async {
      final ids = await repo.getFavoriteIds('user_123');
      expect(ids, isEmpty);
    });
  });
}
