import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../providers/auth_provider.dart';
import '../../providers/locale_provider.dart';
import '../../providers/sync_provider.dart';
import '../../router/app_router.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeNotifierProvider).languageCode;
    final auth = ref.watch(authNotifierProvider);
    final sync = ref.watch(syncNotifierProvider);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(locale == 'ar' ? 'الملف الشخصي' : 'Profile')),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        _avatar(auth?.name, auth?.email),
        const SizedBox(height: 24),
        _card([
          _tile(Icons.language, locale == 'ar' ? 'اللغة' : 'Language',
            locale == 'ar' ? 'العربية' : 'English', () => ref.read(localeNotifierProvider.notifier)
              .setLocale(locale == 'ar' ? 'en' : 'ar')),
          _tile(Icons.sync, locale == 'ar' ? 'المزامنة' : 'Sync',
            sync.isSyncing ? (locale == 'ar' ? 'جارٍ...' : 'Syncing...')
              : sync.lastSyncTime != null ? _formatTime(sync.lastSyncTime!) : (locale == 'ar' ? 'لم تتم بعد' : 'Never'),
            () => ref.read(syncNotifierProvider.notifier).triggerSync()),
        ]),
        const SizedBox(height: 16),
        if (auth == null || auth.isGuest)
          ElevatedButton(onPressed: () => context.push(AppRoutes.login),
            child: Text(locale == 'ar' ? 'تسجيل الدخول' : 'Sign In'))
        else
          OutlinedButton(onPressed: () => ref.read(authNotifierProvider.notifier).clearUser(),
            style: OutlinedButton.styleFrom(foregroundColor: AppColors.error,
              side: const BorderSide(color: AppColors.error)),
            child: Text(locale == 'ar' ? 'تسجيل الخروج' : 'Sign Out')),
      ]),
    );
  }

  Widget _avatar(String? name, String? email) => Column(children: [
    CircleAvatar(radius: 40, backgroundColor: AppColors.primaryContainer,
      child: Text(name != null && name.isNotEmpty ? name[0].toUpperCase() : '?',
        style: const TextStyle(fontSize: 32, color: AppColors.primary, fontWeight: FontWeight.bold))),
    const SizedBox(height: 12),
    if (name != null) Text(name, style: AppTextStyles.headlineMedium),
    if (email != null) Text(email, style: AppTextStyles.bodySmall),
  ]);

  Widget _card(List<Widget> children) => Container(
    decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppColors.outline)),
    child: Column(children: children));

  Widget _tile(IconData icon, String title, String subtitle, VoidCallback onTap) =>
    ListTile(leading: Icon(icon, color: AppColors.primary),
      title: Text(title, style: AppTextStyles.labelLarge),
      subtitle: Text(subtitle, style: AppTextStyles.bodySmall),
      trailing: const Icon(Icons.chevron_right, color: AppColors.textTertiary),
      onTap: onTap);

  String _formatTime(DateTime t) {
    final diff = DateTime.now().difference(t);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
