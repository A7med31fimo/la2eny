import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/haversine.dart';
import '../../../../domain/entities/place.dart';

class RecommendationCard extends StatelessWidget {
  final Place place;
  final String locale;
  final VoidCallback onTap;
  const RecommendationCard({super.key, required this.place, required this.locale, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.outline)),
      child: Row(children: [
        ClipRRect(borderRadius: const BorderRadius.horizontal(left: Radius.circular(14)),
          child: SizedBox(width: 80, height: 80,
            child: place.primaryImageUrl != null
              ? CachedNetworkImage(imageUrl: place.primaryImageUrl!, fit: BoxFit.cover,
                  placeholder: (_, __) => Container(color: AppColors.surfaceVariant),
                  errorWidget: (_, __, ___) => _ph())
              : _ph())),
        Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(place.localizedName(locale), style: AppTextStyles.headlineSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 2),
            if (place.categories.isNotEmpty) Text(
              place.categories.map((c) => c.localizedName(locale)).join(' · '),
              style: AppTextStyles.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 6),
            Row(children: [
              const Icon(Icons.star_rounded, size: 12, color: AppColors.ratingGold),
              const SizedBox(width: 2),
              Text(place.rating.toStringAsFixed(1), style: AppTextStyles.rating.copyWith(fontSize: 12)),
              if (place.distanceKm != null) ...[
                const SizedBox(width: 8),
                Text(Haversine.formatDistance(place.distanceKm!), style: AppTextStyles.labelSmall),
              ],
              const Spacer(),
              Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: place.isOpenNow ? AppColors.successContainer : AppColors.errorContainer,
                  borderRadius: BorderRadius.circular(4)),
                child: Text(place.isOpenNow ? 'Open' : 'Closed',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: place.isOpenNow ? AppColors.openGreen : AppColors.closedRed, fontSize: 10))),
            ]),
          ]))),
        const Padding(padding: EdgeInsets.only(right: 12),
          child: Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textTertiary)),
      ]),
    ));

  Widget _ph() => Container(color: AppColors.surfaceVariant,
    child: const Icon(Icons.place, color: AppColors.textTertiary));
}
