enum SyncStatus { idle, checking, syncing, success, error }
class SyncResult {
  final SyncStatus status;
  final int recordsUpdated;
  final DateTime? lastSyncTime;
  final String? errorMessage;
  const SyncResult({required this.status, this.recordsUpdated = 0, this.lastSyncTime, this.errorMessage});
  bool get isSuccess => status == SyncStatus.success;
  bool get isError => status == SyncStatus.error;
}
abstract class ISyncRepository {
  Future<SyncResult> fullSync();
  Future<SyncResult> deltaSync();
  Future<SyncResult> sync();
  Future<DateTime?> getLastSyncTime();
  Stream<SyncStatus> get syncStatusStream;
}
