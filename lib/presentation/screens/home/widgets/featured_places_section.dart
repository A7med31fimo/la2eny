import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../providers/places_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../router/app_router.dart';
import '../../../widgets/place_card.dart';

class FeaturedPlacesSection extends ConsumerWidget {
  final String locale;
  const FeaturedPlacesSection({super.key, required this.locale});
  @override
  Widget build(BuildContext context, WidgetRef ref) => ref.watch(placesProvider).when(
    loading: () => SizedBox(height: 280, child: ListView.builder(scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: 3,
      itemBuilder: (_, __) => Container(width: 220, margin: const EdgeInsets.only(right: 14),
        decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(16))))),
    error: (_, __) => Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text('Could not load places', style: AppTextStyles.bodySmall)),
    data: (places) {
      if (places.isEmpty) {
        return Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(locale == 'ar' ? 'لا توجد أماكن بعد' : 'No places yet. Sync to load data.',
          style: AppTextStyles.bodySmall));
      }
      return SizedBox(height: 280, child: ListView.builder(
        scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: places.take(5).length,
        itemBuilder: (ctx, i) => SizedBox(width: 220, child: Padding(
          padding: const EdgeInsets.only(right: 14),
          child: PlaceCard(place: places[i], locale: locale,
            onTap: () => ctx.push(AppRoutes.placeDetailPath(places[i].id)),
            onFavoriteTap: () async {
              final auth = ref.read(authNotifierProvider);
              if (auth == null || auth.isGuest) return;
              await ref.read(placeRepositoryProvider).toggleFavorite(places[i].id, auth.id);
              ref.invalidate(favoriteIdsProvider(auth.id));
            })))));
    });
}
