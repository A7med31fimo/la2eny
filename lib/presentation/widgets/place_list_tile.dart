import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/haversine.dart';
import '../../domain/entities/place.dart';

class PlaceListTile extends StatelessWidget {
  final Place place;
  final String locale;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback? onFavoriteTap;
  const PlaceListTile({super.key, required this.place, required this.locale,
    this.isFavorite = false, required this.onTap, this.onFavoriteTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.outline)),
      child: Row(children: [_thumb(), Expanded(child: _info()), _actions()]),
    ),
  );

  Widget _thumb() => ClipRRect(
    borderRadius: const BorderRadius.horizontal(left: Radius.circular(14)),
    child: SizedBox(width: 90, height: 90,
      child: place.primaryImageUrl != null
        ? CachedNetworkImage(imageUrl: place.primaryImageUrl!, fit: BoxFit.cover,
            placeholder: (_, __) => _ph(), errorWidget: (_, __, ___) => _ph())
        : _ph()));

  Widget _ph() => Container(color: AppColors.surfaceVariant,
    child: const Icon(Icons.place, color: AppColors.textTertiary));

  Widget _info() => Padding(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(place.localizedName(locale), style: AppTextStyles.headlineSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
      if (place.categories.isNotEmpty) ...[
        const SizedBox(height: 2),
        Text(place.categories.map((c) => c.localizedName(locale)).join(' · '),
          style: AppTextStyles.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
      ],
      const SizedBox(height: 6),
      Row(children: [
        const Icon(Icons.star_rounded, size: 13, color: AppColors.ratingGold),
        const SizedBox(width: 2),
        Text(place.rating.toStringAsFixed(1), style: AppTextStyles.rating.copyWith(fontSize: 12)),
        const SizedBox(width: 8),
        Container(padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
          decoration: BoxDecoration(
            color: place.isOpenNow ? AppColors.successContainer : AppColors.errorContainer,
            borderRadius: BorderRadius.circular(4)),
          child: Text(place.isOpenNow ? 'Open' : 'Closed',
            style: AppTextStyles.labelSmall.copyWith(
              color: place.isOpenNow ? AppColors.openGreen : AppColors.closedRed, fontSize: 10))),
        if (place.distanceKm != null) ...[
          const SizedBox(width: 8),
          Text(Haversine.formatDistance(place.distanceKm!), style: AppTextStyles.labelSmall),
        ],
      ]),
    ]));

  Widget _actions() => Padding(padding: const EdgeInsets.only(right: 12),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      if (onFavoriteTap != null) GestureDetector(onTap: onFavoriteTap,
        child: Icon(isFavorite ? Icons.favorite : Icons.favorite_outline,
          color: isFavorite ? AppColors.error : AppColors.textTertiary, size: 20)),
      const SizedBox(height: 8),
      const Icon(Icons.chevron_right, color: AppColors.textTertiary, size: 18),
    ]));
}
