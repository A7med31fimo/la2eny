import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/datasources/local/database/app_database.dart';
import '../../data/datasources/remote/api_client.dart';
import '../../data/datasources/remote/services/places_api_service.dart';
import '../../data/repositories/sync_repository_impl.dart';
import '../../domain/repositories/i_sync_repository.dart';

part 'sync_provider.g.dart';

// ── Infrastructure providers ──────────────────────────────────────────────────

@riverpod
AppDatabase appDatabase(AppDatabaseRef ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
}

@riverpod
ApiClient apiClient(ApiClientRef ref) => ApiClient();

@riverpod
PlacesApiService placesApiService(PlacesApiServiceRef ref) =>
    PlacesApiService(ref.watch(apiClientProvider));

@riverpod
SyncRepositoryImpl syncRepository(SyncRepositoryRef ref) {
  final repo = SyncRepositoryImpl(
    db: ref.watch(appDatabaseProvider),
    apiService: ref.watch(placesApiServiceProvider),
  );
  ref.onDispose(repo.dispose);
  return repo;
}

// ── Sync state ────────────────────────────────────────────────────────────────

class SyncState {
  final SyncStatus status;
  final DateTime? lastSyncTime;
  final String? errorMessage;
  final int recordsUpdated;

  const SyncState({
    this.status = SyncStatus.idle,
    this.lastSyncTime,
    this.errorMessage,
    this.recordsUpdated = 0,
  });

  bool get isSyncing =>
      status == SyncStatus.syncing || status == SyncStatus.checking;
  bool get hasError => status == SyncStatus.error;
  bool get isSuccess => status == SyncStatus.success;

  SyncState copyWith({
    SyncStatus? status,
    DateTime? lastSyncTime,
    String? errorMessage,
    int? recordsUpdated,
  }) =>
      SyncState(
        status: status ?? this.status,
        lastSyncTime: lastSyncTime ?? this.lastSyncTime,
        errorMessage: errorMessage ?? this.errorMessage,
        recordsUpdated: recordsUpdated ?? this.recordsUpdated,
      );
}

@riverpod
class SyncNotifier extends _$SyncNotifier {
  @override
  SyncState build() {
    // Listen to sync status stream
    ref.watch(syncRepositoryProvider).syncStatusStream.listen((status) {
      state = state.copyWith(status: status);
    });
    return const SyncState();
  }

  /// Trigger sync — called on app foreground
  Future<void> triggerSync() async {
    if (state.isSyncing) return;
    final repo = ref.read(syncRepositoryProvider);
    final result = await repo.sync();
    state = state.copyWith(
      status: result.status,
      lastSyncTime: result.lastSyncTime,
      errorMessage: result.errorMessage,
      recordsUpdated: result.recordsUpdated,
    );
  }

  Future<void> forceFullSync() async {
    if (state.isSyncing) return;
    final repo = ref.read(syncRepositoryProvider);
    final result = await repo.fullSync();
    state = state.copyWith(
      status: result.status,
      lastSyncTime: result.lastSyncTime,
      errorMessage: result.errorMessage,
      recordsUpdated: result.recordsUpdated,
    );
  }
}

// Last sync time as a simple readable provider
@riverpod
Future<DateTime?> lastSyncTime(LastSyncTimeRef ref) =>
    ref.watch(syncRepositoryProvider).getLastSyncTime();
