import 'dart:async';
import 'package:drift/drift.dart';
import '../../domain/repositories/i_sync_repository.dart';
import '../../core/constants/app_constants.dart';
import '../../core/errors/exceptions.dart';
import '../datasources/local/database/app_database.dart';
import '../datasources/remote/services/places_api_service.dart';
import '../models/place_dto.dart';

class SyncRepositoryImpl implements ISyncRepository {
  final AppDatabase _db;
  final PlacesApiService _api;
  final _statusCtrl = StreamController<SyncStatus>.broadcast();

  SyncRepositoryImpl({required AppDatabase db, required PlacesApiService apiService})
      : _db = db, _api = apiService;

  @override Stream<SyncStatus> get syncStatusStream => _statusCtrl.stream;
  @override Future<DateTime?> getLastSyncTime() => _db.syncDao.getLastSyncTime();

  @override Future<SyncResult> sync() async {
    final last = await getLastSyncTime();
    return last == null ? fullSync() : deltaSync();
  }

  @override Future<SyncResult> fullSync() async {
    _emit(SyncStatus.syncing);
    try {
      await _syncCategories();
      int page = 0, total = 0;
      while (true) {
        final res = await _api.getPlaces(page: page, limit: AppConstants.syncPageSize);
        await _upsertPlaces(res.data);
        total += res.data.length;
        if (!res.hasMore || res.data.isEmpty) break;
        page++;
      }
      final now = DateTime.now();
      await _db.syncDao.setLastSyncTime(now);
      _emit(SyncStatus.success);
      return SyncResult(status: SyncStatus.success, recordsUpdated: total, lastSyncTime: now);
    } on NetworkException catch (e) {
      _emit(SyncStatus.error);
      return SyncResult(status: SyncStatus.error, errorMessage: e.message);
    } catch (e) {
      _emit(SyncStatus.error);
      return SyncResult(status: SyncStatus.error, errorMessage: e.toString());
    }
  }

  @override Future<SyncResult> deltaSync() async {
    _emit(SyncStatus.checking);
    final last = await getLastSyncTime();
    if (last == null) return fullSync();
    _emit(SyncStatus.syncing);
    try {
      await _syncCategories();
      final updated = await _api.getPlacesUpdatedSince(last);
      if (updated.isEmpty) {
        _emit(SyncStatus.success);
        return SyncResult(status: SyncStatus.success, recordsUpdated: 0, lastSyncTime: last);
      }
      await _upsertPlaces(updated);
      final now = DateTime.now();
      await _db.syncDao.setLastSyncTime(now);
      _emit(SyncStatus.success);
      return SyncResult(status: SyncStatus.success, recordsUpdated: updated.length, lastSyncTime: now);
    } on NetworkException catch (e) {
      _emit(SyncStatus.error);
      return SyncResult(status: SyncStatus.error, errorMessage: e.message);
    } catch (e) {
      _emit(SyncStatus.error);
      return SyncResult(status: SyncStatus.error, errorMessage: e.toString());
    }
  }

  Future<void> _syncCategories() async {
    try {
      final cats = await _api.getCategories();
      await _db.categoriesDao.batchUpsertCategories(cats.map((c) => CategoriesTableCompanion.insert(
        id: Value(c.id), nameAr: c.nameAr, nameEn: c.nameEn,
        icon: Value(c.icon), updatedAt: c.updatedAt ?? DateTime.now().toIso8601String())).toList());
    } catch (_) {}
  }

  Future<void> _upsertPlaces(List<PlaceDto> places) async {
    await _db.transaction(() async {
      for (final dto in places) {
        await _db.placesDao.upsertPlace(PlacesTableCompanion.insert(
          id: Value(dto.id), nameAr: dto.nameAr, nameEn: dto.nameEn,
          descriptionAr: Value(dto.descriptionAr), descriptionEn: Value(dto.descriptionEn),
          addressAr: Value(dto.addressAr), addressEn: Value(dto.addressEn),
          latitude: dto.latitude, longitude: dto.longitude,
          phone: Value(dto.phone), website: Value(dto.website),
          rating: Value(dto.rating), reviewCount: Value(dto.reviewCount),
          priceLevel: Value(dto.priceLevel), isActive: Value(dto.isActive),
          updatedAt: dto.updatedAt, createdAt: dto.createdAt));
        await _db.placesDao.clearPlaceRelations(dto.id);
        for (final c in dto.categories) {
          await _db.placesDao.upsertCategory(CategoriesTableCompanion.insert(
            id: Value(c.id), nameAr: c.nameAr, nameEn: c.nameEn,
            icon: Value(c.icon), updatedAt: c.updatedAt ?? DateTime.now().toIso8601String()));
          await _db.placesDao.upsertPlaceCategory(PlaceCategoriesTableCompanion.insert(placeId: dto.id, categoryId: c.id));
        }
        for (final h in dto.workingHours) {
          await _db.placesDao.upsertWorkingHours(WorkingHoursTableCompanion.insert(
            placeId: dto.id, dayOfWeek: h.dayOfWeek,
            openTime: Value(h.openTime), closeTime: Value(h.closeTime), isClosed: Value(h.isClosed)));
        }
        for (final img in dto.images) {
          await _db.placesDao.upsertImage(PlaceImagesTableCompanion.insert(
            id: Value(img.id), placeId: dto.id, url: img.url,
            isPrimary: Value(img.isPrimary), sortOrder: Value(img.sortOrder)));
        }
        for (final s in dto.socialLinks) {
          await _db.placesDao.upsertSocialLink(SocialLinksTableCompanion.insert(
            id: Value(s.id), placeId: dto.id, platform: s.platform, url: s.url));
        }
      }
    });
  }

  void _emit(SyncStatus s) { if (!_statusCtrl.isClosed) _statusCtrl.add(s); }
  void dispose() => _statusCtrl.close();
}
