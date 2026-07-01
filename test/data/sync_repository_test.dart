import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:localai_app/data/datasources/local/database/app_database.dart';
import 'package:localai_app/data/datasources/remote/services/places_api_service.dart';
import 'package:localai_app/data/models/place_dto.dart';
import 'package:localai_app/data/repositories/sync_repository_impl.dart';
import 'package:localai_app/domain/repositories/i_sync_repository.dart';

class MockPlacesApiService extends Mock implements PlacesApiService {}

void main() {
  late AppDatabase db;
  late MockPlacesApiService mockApi;
  late SyncRepositoryImpl repo;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    mockApi = MockPlacesApiService();
    repo = SyncRepositoryImpl(db: db, apiService: mockApi);
  });

  tearDown(() async {
    await db.close();
    repo.dispose();
  });

  group('SyncRepository', () {
    test('fullSync returns success with empty response', () async {
      when(() => mockApi.getCategories()).thenAnswer((_) async => []);
      when(() => mockApi.getPlaces(page: any(named: 'page'), limit: any(named: 'limit')))
          .thenAnswer((_) async => PlacesResponse(
                data: [],
                total: 0,
                page: 0,
                limit: 100,
              ));

      final result = await repo.fullSync();

      expect(result.status, SyncStatus.success);
      expect(result.recordsUpdated, 0);
    });

    test('deltaSync falls back to fullSync when no timestamp exists', () async {
      when(() => mockApi.getCategories()).thenAnswer((_) async => []);
      when(() => mockApi.getPlaces(page: any(named: 'page'), limit: any(named: 'limit')))
          .thenAnswer((_) async => PlacesResponse(
                data: [],
                total: 0,
                page: 0,
                limit: 100,
              ));

      final result = await repo.deltaSync();

      // Should have called fullSync (no timestamp in DB)
      expect(result.status, SyncStatus.success);
    });

    test('getLastSyncTime returns null before first sync', () async {
      final time = await repo.getLastSyncTime();
      expect(time, isNull);
    });

    test('getLastSyncTime returns time after sync', () async {
      when(() => mockApi.getCategories()).thenAnswer((_) async => []);
      when(() => mockApi.getPlaces(page: any(named: 'page'), limit: any(named: 'limit')))
          .thenAnswer((_) async => PlacesResponse(
                data: [], total: 0, page: 0, limit: 100));

      await repo.fullSync();

      final time = await repo.getLastSyncTime();
      expect(time, isNotNull);
      expect(time!.isBefore(DateTime.now().add(const Duration(seconds: 5))),
          isTrue);
    });
  });
}
