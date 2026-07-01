import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/local/database/app_database.dart';
import '../../data/datasources/remote/api_client.dart';
import '../../data/datasources/remote/services/places_api_service.dart';
import '../../data/repositories/sync_repository_impl.dart';
import '../../domain/repositories/i_sync_repository.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

final placesApiServiceProvider = Provider<PlacesApiService>(
  (ref) => PlacesApiService(ref.watch(apiClientProvider)),
);

final syncRepositoryProvider = Provider<SyncRepositoryImpl>((ref) {
  final repo = SyncRepositoryImpl(
    db: ref.watch(appDatabaseProvider),
    apiService: ref.watch(placesApiServiceProvider),
  );
  ref.onDispose(repo.dispose);
  return repo;
});

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

class SyncNotifier extends Notifier<SyncState> {
  @override
  SyncState build() {
    ref.watch(syncRepositoryProvider).syncStatusStream.listen(
      (s) => state = state.copyWith(status: s),
    );
    return const SyncState();
  }

  Future<void> triggerSync() async {
    if (state.isSyncing) return;
    final r = await ref.read(syncRepositoryProvider).sync();
    state = state.copyWith(
      status: r.status,
      lastSyncTime: r.lastSyncTime,
      errorMessage: r.errorMessage,
      recordsUpdated: r.recordsUpdated,
    );
  }

  Future<void> forceFullSync() async {
    if (state.isSyncing) return;
    final r = await ref.read(syncRepositoryProvider).fullSync();
    state = state.copyWith(
      status: r.status,
      lastSyncTime: r.lastSyncTime,
      errorMessage: r.errorMessage,
      recordsUpdated: r.recordsUpdated,
    );
  }
}

final syncNotifierProvider = NotifierProvider<SyncNotifier, SyncState>(SyncNotifier.new);

final lastSyncTimeProvider = FutureProvider<DateTime?>(
  (ref) => ref.watch(syncRepositoryProvider).getLastSyncTime(),
);
