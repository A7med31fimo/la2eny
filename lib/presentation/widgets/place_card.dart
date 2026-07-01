import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/utils/haversine.dart';
import '../../domain/entities/place.dart';

class PlaceCard extends StatelessWidget {
  final Place place;
  final String locale;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback? onFavoriteTap;
  final String? matchExplanation;
  const PlaceCard({super.key, required this.place, required this.locale,
    this.isFavorite = false, required this.onTap, this.onFavoriteTap, this.matchExplanation});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outline),
        boxShadow: const [BoxShadow(color: AppColors.shadowLight, blurRadius: 8, offset: Offset(0,2))]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_img(), _content()]),
    ),
  );

  Widget _img() => ClipRRect(
    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
    child: AspectRatio(aspectRatio: 16/9,
      child: place.primaryImageUrl != null
        ? CachedNetworkImage(imageUrl: place.primaryImageUrl!, fit: BoxFit.cover,
            placeholder: (_, __) => _ph(), errorWidget: (_, __, ___) => _ph())
        : _ph()));

  Widget _ph() => Container(color: AppColors.surfaceVariant,
    child: const Center(child: Icon(Icons.place, color: AppColors.textTertiary, size: 40)));

  Widget _content() => Padding(padding: const EdgeInsets.all(12),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Expanded(child: Text(place.localizedName(locale), style: AppTextStyles.headlineSmall, maxLines: 1, overflow: TextOverflow.ellipsis)),
        if (onFavoriteTap != null) GestureDetector(onTap: onFavoriteTap,
          child: Icon(isFavorite ? Icons.favorite : Icons.favorite_outline,
            color: isFavorite ? AppColors.error : AppColors.textTertiary, size: 20)),
      ]),
      if (place.categories.isNotEmpty) ...[
        const SizedBox(height: 4),
        Text(place.categories.map((c) => c.localizedName(locale)).join(' · '),
          style: AppTextStyles.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
      ],
      const SizedBox(height: 8),
      Row(children: [
        const Icon(Icons.star_rounded, size: 14, color: AppColors.ratingGold),
        const SizedBox(width: 2),
        Text(place.rating.toStringAsFixed(1), style: AppTextStyles.rating),
        const SizedBox(width: 2),
        Text('(${place.reviewCount})', style: AppTextStyles.caption),
        const Spacer(),
        if (place.distanceKm != null) Text(Haversine.formatDistance(place.distanceKm!), style: AppTextStyles.labelSmall),
        const SizedBox(width: 8),
        Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: place.isOpenNow ? AppColors.successContainer : AppColors.errorContainer,
            borderRadius: BorderRadius.circular(4)),
          child: Text(place.isOpenNow ? 'Open' : 'Closed',
            style: AppTextStyles.labelSmall.copyWith(
              color: place.isOpenNow ? AppColors.openGreen : AppColors.closedRed))),
      ]),
      if (matchExplanation != null) ...[
        const SizedBox(height: 8),
        Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(color: AppColors.primaryContainer, borderRadius: BorderRadius.circular(8)),
          child: Row(children: [
            const Icon(Icons.auto_awesome, size: 12, color: AppColors.primary),
            const SizedBox(width: 6),
            Expanded(child: Text(matchExplanation!,
              style: AppTextStyles.labelSmall.copyWith(color: AppColors.primary),
              maxLines: 2, overflow: TextOverflow.ellipsis)),
          ])),
      ],
    ]));
}
