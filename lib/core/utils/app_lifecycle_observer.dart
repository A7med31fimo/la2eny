import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../presentation/providers/sync_provider.dart';
import '../../presentation/providers/connectivity_provider.dart';

class AppLifecycleObserver extends WidgetsBindingObserver {
  final WidgetRef ref;
  AppLifecycleObserver(this.ref);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _sync();
  }

  Future<void> _sync() async {
    final online = await ref.read(isOnlineProvider.future);
    if (online) ref.read(syncNotifierProvider.notifier).triggerSync();
  }
}
