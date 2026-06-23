import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../domain/entities/place.dart';
import '../../../providers/places_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../router/app_router.dart';
import '../../../widgets/place_card.dart';

class FeaturedPlacesSection extends ConsumerWidget {
  final String locale;
  const FeaturedPlacesSection({super.key, required this.locale});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placesAsync = ref.watch(placesProvider);

    return placesAsync.when(
      loading: () => _skeleton(),
      error: (e, _) => _error(e.toString()),
      data: (places) {
        if (places.isEmpty) return _empty(locale);
        final featured = places.take(5).toList();
        return SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: featured.length,
            itemBuilder: (context, i) {
              final place = featured[i];
              return SizedBox(
                width: 220,
                child: Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: PlaceCard(
                    place: place,
                    locale: locale,
                    onTap: () => context.push(AppRoutes.placeDetailPath(place.id)),
                    onFavoriteTap: () => _toggleFavorite(ref, place),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _toggleFavorite(WidgetRef ref, Place place) async {
    final auth = ref.read(authNotifierProvider);
    if (auth == null || auth.isGuest) return;
    await ref.read(placeRepositoryProvider).toggleFavorite(place.id, auth.id);
    ref.invalidate(favoriteIdsProvider(auth.id));
  }

  Widget _skeleton() => SizedBox(
        height: 280,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: 3,
          itemBuilder: (_, __) => Container(
            width: 220,
            margin: const EdgeInsets.only(right: 14),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      );

  Widget _error(String message) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text('Could not load places', style: AppTextStyles.bodySmall),
      );

  Widget _empty(String locale) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          locale == 'ar' ? 'لا توجد أماكن بعد' : 'No places yet. Sync to load data.',
          style: AppTextStyles.bodySmall,
        ),
      );
}
