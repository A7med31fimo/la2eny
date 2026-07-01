import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../domain/repositories/i_sync_repository.dart';
import '../providers/sync_provider.dart';

class SyncStatusBar extends ConsumerWidget {
  const SyncStatusBar({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sync = ref.watch(syncNotifierProvider);
    if (sync.status == SyncStatus.idle || sync.status == SyncStatus.success) return const SizedBox.shrink();
    return Container(
      color: sync.hasError ? AppColors.error : AppColors.primary,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(children: [
        if (sync.isSyncing)
          const SizedBox(width: 12, height: 12, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
        else const Icon(Icons.warning_amber_rounded, size: 14, color: Colors.white),
        const SizedBox(width: 8),
        Expanded(child: Text(_msg(sync), style: AppTextStyles.labelSmall.copyWith(color: Colors.white))),
        if (sync.hasError) GestureDetector(
          onTap: () => ref.read(syncNotifierProvider.notifier).triggerSync(),
          child: Text('Retry', style: AppTextStyles.labelSmall.copyWith(color: Colors.white, decoration: TextDecoration.underline))),
      ]),
    );
  }
  String _msg(SyncState s) {
    switch (s.status) {
      case SyncStatus.checking: return 'Checking for updates...';
      case SyncStatus.syncing: return 'Syncing places...';
      case SyncStatus.error: return s.errorMessage ?? 'Sync failed. Showing cached data.';
      default: return '';
    }
  }
}
