enum SyncStatus { idle, checking, syncing, success, error }

class SyncResult {
  final SyncStatus status;
  final int recordsUpdated;
  final DateTime? lastSyncTime;
  final String? errorMessage;

  const SyncResult({
    required this.status,
    this.recordsUpdated = 0,
    this.lastSyncTime,
    this.errorMessage,
  });

  bool get isSuccess => status == SyncStatus.success;
  bool get isError => status == SyncStatus.error;
}

abstract class ISyncRepository {
  /// Perform full sync — downloads all places (paginated)
  Future<SyncResult> fullSync();

  /// Perform delta sync — downloads only changed records
  Future<SyncResult> deltaSync();

  /// Smart sync: full if first time, delta otherwise
  Future<SyncResult> sync();

  /// Get last sync timestamp
  Future<DateTime?> getLastSyncTime();

  /// Stream of sync status updates
  Stream<SyncStatus> get syncStatusStream;
}
