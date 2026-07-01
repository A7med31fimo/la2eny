import 'package:drift/drift.dart';
import '../app_database.dart';
part 'sync_dao.g.dart';

@DriftAccessor(tables: [SyncMetadataTable])
class SyncDao extends DatabaseAccessor<AppDatabase> with _$SyncDaoMixin {
  SyncDao(super.db);
  static const String _lastSyncKey = 'last_sync_timestamp';

  Future<String?> getValue(String key) async =>
      (await (select(syncMetadataTable)..where((s) => s.key.equals(key))).getSingleOrNull())?.value;

  Future<void> setValue(String key, String value) =>
      into(syncMetadataTable).insertOnConflictUpdate(SyncMetadataTableCompanion.insert(key: key, value: value));

  Future<DateTime?> getLastSyncTime() async {
    final v = await getValue(_lastSyncKey);
    return v == null ? null : DateTime.tryParse(v);
  }

  Future<void> setLastSyncTime(DateTime t) => setValue(_lastSyncKey, t.toIso8601String());
}
