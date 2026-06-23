import 'dart:async';
import 'package:drift/drift.dart';
import '../../domain/repositories/i_sync_repository.dart';
import '../../core/constants/app_constants.dart';
import '../../core/errors/exceptions.dart';
import '../datasources/local/database/app_database.dart';
import '../datasources/local/database/daos/places_dao.dart';
import '../datasources/local/database/daos/categories_dao.dart';
import '../datasources/local/database/daos/sync_dao.dart';
import '../datasources/remote/services/places_api_service.dart';
import '../models/place_dto.dart';

class SyncRepositoryImpl implements ISyncRepository {
  final AppDatabase _db;
  final PlacesApiService _apiService;
  final PlacesDao _placesDao;
  final CategoriesDao _categoriesDao;
  final SyncDao _syncDao;

  final _statusController = StreamController<SyncStatus>.broadcast();

  SyncRepositoryImpl({
    required AppDatabase db,
    required PlacesApiService apiService,
  })  : _db = db,
        _apiService = apiService,
        _placesDao = db.placesDao,
        _categoriesDao = db.categoriesDao,
        _syncDao = db.syncDao;

  @override
  Stream<SyncStatus> get syncStatusStream => _statusController.stream;

  @override
  Future<DateTime?> getLastSyncTime() => _syncDao.getLastSyncTime();

  @override
  Future<SyncResult> sync() async {
    final lastSync = await getLastSyncTime();
    if (lastSync == null) {
      return fullSync();
    }
    return deltaSync();
  }

  @override
  Future<SyncResult> fullSync() async {
    _emit(SyncStatus.syncing);
    try {
      // 1. Sync categories first
      await _syncCategories();

      // 2. Full paginated place sync
      int page = 0;
      int totalRecords = 0;

      while (true) {
        final response = await _apiService.getPlaces(
          page: page,
          limit: AppConstants.syncPageSize,
        );

        await _upsertPlaces(response.data);
        totalRecords += response.data.length;

        if (!response.hasMore || response.data.isEmpty) break;
        page++;
      }

      final now = DateTime.now();
      await _syncDao.setLastSyncTime(now);
      _emit(SyncStatus.success);

      return SyncResult(
        status: SyncStatus.success,
        recordsUpdated: totalRecords,
        lastSyncTime: now,
      );
    } on NetworkException catch (e) {
      _emit(SyncStatus.error);
      return SyncResult(
        status: SyncStatus.error,
        errorMessage: e.message,
      );
    } catch (e) {
      _emit(SyncStatus.error);
      return SyncResult(
        status: SyncStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  @override
  Future<SyncResult> deltaSync() async {
    _emit(SyncStatus.checking);
    final lastSync = await getLastSyncTime();
    if (lastSync == null) return fullSync();

    _emit(SyncStatus.syncing);
    try {
      await _syncCategories();

      final updatedPlaces =
          await _apiService.getPlacesUpdatedSince(lastSync);

      if (updatedPlaces.isEmpty) {
        _emit(SyncStatus.success);
        return SyncResult(
          status: SyncStatus.success,
          recordsUpdated: 0,
          lastSyncTime: lastSync,
        );
      }

      await _upsertPlaces(updatedPlaces);

      final now = DateTime.now();
      await _syncDao.setLastSyncTime(now);
      _emit(SyncStatus.success);

      return SyncResult(
        status: SyncStatus.success,
        recordsUpdated: updatedPlaces.length,
        lastSyncTime: now,
      );
    } on NetworkException catch (e) {
      _emit(SyncStatus.error);
      return SyncResult(status: SyncStatus.error, errorMessage: e.message);
    } catch (e) {
      _emit(SyncStatus.error);
      return SyncResult(status: SyncStatus.error, errorMessage: e.toString());
    }
  }

  // ── Private helpers ───────────────────────────────────────────────────────

  Future<void> _syncCategories() async {
    try {
      final categories = await _apiService.getCategories();
      await _categoriesDao.batchUpsertCategories(
        categories.map((c) => CategoriesTableCompanion.insert(
              id: Value(c.id),
              nameAr: c.nameAr,
              nameEn: c.nameEn,
              icon: Value(c.icon),
              updatedAt: c.updatedAt ?? DateTime.now().toIso8601String(),
            )).toList(),
      );
    } catch (_) {
      // Categories sync failure is non-fatal
    }
  }

  Future<void> _upsertPlaces(List<PlaceDto> places) async {
    await _db.transaction(() async {
      for (final dto in places) {
        // Upsert main place record
        await _placesDao.upsertPlace(
          PlacesTableCompanion.insert(
            id: Value(dto.id),
            nameAr: dto.nameAr,
            nameEn: dto.nameEn,
            descriptionAr: Value(dto.descriptionAr),
            descriptionEn: Value(dto.descriptionEn),
            addressAr: Value(dto.addressAr),
            addressEn: Value(dto.addressEn),
            latitude: dto.latitude,
            longitude: dto.longitude,
            phone: Value(dto.phone),
            website: Value(dto.website),
            rating: Value(dto.rating),
            reviewCount: Value(dto.reviewCount),
            priceLevel: Value(dto.priceLevel),
            isActive: Value(dto.isActive),
            updatedAt: dto.updatedAt,
            createdAt: dto.createdAt,
          ),
        );

        // Clear and re-insert relations
        await _placesDao.clearPlaceRelations(dto.id);

        // Categories
        for (final cat in dto.categories) {
          await _placesDao.upsertCategory(
            CategoriesTableCompanion.insert(
              id: Value(cat.id),
              nameAr: cat.nameAr,
              nameEn: cat.nameEn,
              icon: Value(cat.icon),
              updatedAt: cat.updatedAt ?? DateTime.now().toIso8601String(),
            ),
          );
          await _placesDao.upsertPlaceCategory(
            PlaceCategoriesTableCompanion.insert(
              placeId: dto.id,
              categoryId: cat.id,
            ),
          );
        }

        // Working hours
        for (final h in dto.workingHours) {
          await _placesDao.upsertWorkingHours(
            WorkingHoursTableCompanion.insert(
              placeId: dto.id,
              dayOfWeek: h.dayOfWeek,
              openTime: Value(h.openTime),
              closeTime: Value(h.closeTime),
              isClosed: Value(h.isClosed),
            ),
          );
        }

        // Images
        for (final img in dto.images) {
          await _placesDao.upsertImage(
            PlaceImagesTableCompanion.insert(
              id: Value(img.id),
              placeId: img.id,
              url: img.url,
              isPrimary: Value(img.isPrimary),
              sortOrder: Value(img.sortOrder),
            ),
          );
        }

        // Social links
        for (final link in dto.socialLinks) {
          await _placesDao.upsertSocialLink(
            SocialLinksTableCompanion.insert(
              id: Value(link.id),
              placeId: dto.id,
              platform: link.platform,
              url: link.url,
            ),
          );
        }
      }
    });
  }

  void _emit(SyncStatus status) {
    if (!_statusController.isClosed) {
      _statusController.add(status);
    }
  }

  void dispose() {
    _statusController.close();
  }
}
