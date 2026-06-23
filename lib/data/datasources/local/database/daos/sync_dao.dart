import 'package:drift/drift.dart';
import '../app_database.dart';

part 'sync_dao.g.dart';

@DriftAccessor(tables: [SyncMetadataTable])
class SyncDao extends DatabaseAccessor<AppDatabase> with _$SyncDaoMixin {
  SyncDao(super.db);

  static const String _lastSyncKey = 'last_sync_timestamp';
  static const String _syncVersionKey = 'sync_schema_version';

  Future<String?> getValue(String key) async {
    final row = await (select(syncMetadataTable)
          ..where((s) => s.key.equals(key)))
        .getSingleOrNull();
    return row?.value;
  }

  Future<void> setValue(String key, String value) =>
      into(syncMetadataTable).insertOnConflictUpdate(
        SyncMetadataTableCompanion.insert(key: key, value: value),
      );

  Future<DateTime?> getLastSyncTime() async {
    final value = await getValue(_lastSyncKey);
    if (value == null) return null;
    return DateTime.tryParse(value);
  }

  Future<void> setLastSyncTime(DateTime time) =>
      setValue(_lastSyncKey, time.toIso8601String());

  Future<void> clearSyncState() =>
      (delete(syncMetadataTable)..where((s) => s.key.equals(_lastSyncKey)))
          .go();
}
