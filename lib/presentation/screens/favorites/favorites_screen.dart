import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../providers/places_provider.dart';
import '../../providers/locale_provider.dart';
import '../../providers/auth_provider.dart';
import '../../router/app_router.dart';
import '../../widgets/place_list_tile.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeNotifierProvider).languageCode;
    final auth = ref.watch(authNotifierProvider);
    if (auth == null || auth.isGuest) return _loginPrompt(context, locale);
    final favsAsync = ref.watch(favoritePlacesProvider(auth.id));
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(locale == 'ar' ? 'المفضلة' : 'My Favorites')),
      body: favsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => Center(child: Text('Error loading favorites', style: AppTextStyles.bodySmall)),
        data: (places) {
          if (places.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.favorite_outline, size: 64, color: AppColors.textTertiary), const SizedBox(height: 16),
            Text(locale == 'ar' ? 'لا توجد مفضلات بعد' : 'No favorites yet', style: AppTextStyles.headlineMedium),
            const SizedBox(height: 8),
            Text(locale == 'ar' ? 'اضغط على القلب في أي مكان لحفظه' : 'Tap the heart on any place to save it',
              style: AppTextStyles.bodySmall, textAlign: TextAlign.center),
          ]));
          }
          return ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 24),
            itemCount: places.length,
            itemBuilder: (ctx, i) => PlaceListTile(
              place: places[i], locale: locale, isFavorite: true,
              onTap: () => ctx.push(AppRoutes.placeDetailPath(places[i].id)),
              onFavoriteTap: () async {
                await ref.read(placeRepositoryProvider).toggleFavorite(places[i].id, auth.id);
                ref.invalidate(favoritePlacesProvider(auth.id));
              }));
        }),
    );
  }

  Widget _loginPrompt(BuildContext ctx, String locale) => Scaffold(
    backgroundColor: AppColors.background,
    appBar: AppBar(title: Text(locale == 'ar' ? 'المفضلة' : 'Favorites')),
    body: Center(child: Padding(padding: const EdgeInsets.all(32),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.favorite_outline, size: 80, color: AppColors.textTertiary),
        const SizedBox(height: 24),
        Text(locale == 'ar' ? 'سجّل دخولك لحفظ المفضلة' : 'Sign in to save favorites',
          style: AppTextStyles.headlineMedium, textAlign: TextAlign.center),
        const SizedBox(height: 32),
        ElevatedButton(onPressed: () => ctx.push(AppRoutes.login),
          child: Text(locale == 'ar' ? 'تسجيل الدخول' : 'Sign In')),
      ]))));
}
