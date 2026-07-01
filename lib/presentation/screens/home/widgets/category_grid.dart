import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../providers/places_provider.dart';
import '../../../router/app_router.dart';

class CategoryGrid extends ConsumerWidget {
  final String locale;
  const CategoryGrid({super.key, required this.locale});
  @override
  Widget build(BuildContext context, WidgetRef ref) => ref.watch(categoriesProvider).when(
    loading: () => SizedBox(height: 96, child: ListView.builder(scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: 6,
      itemBuilder: (_, __) => Container(width: 70, margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(14))))),
    error: (_, __) => const SizedBox.shrink(),
    data: (cats) => SizedBox(height: 96,
      child: ListView.builder(scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: cats.take(8).length,
        itemBuilder: (ctx, i) {
          final cat = cats[i];
          return GestureDetector(
            onTap: () { ref.read(placeFilterNotifierProvider.notifier).setCategoryId(cat.id); ctx.go(AppRoutes.discover); },
            child: SizedBox(width: 72, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(width: 56, height: 56, decoration: BoxDecoration(
                color: AppColors.primaryContainer, borderRadius: BorderRadius.circular(16)),
                child: Center(child: Text(_emoji(cat.nameEn), style: const TextStyle(fontSize: 24)))),
              const SizedBox(height: 6),
              Text(cat.localizedName(locale), style: AppTextStyles.labelSmall,
                textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
            ])));
        })),
  );
  String _emoji(String name) {
    final n = name.toLowerCase();
    if (n.contains('restaurant') || n.contains('food')) return '🍽️';
    if (n.contains('cafe') || n.contains('coffee')) return '☕';
    if (n.contains('fast')) return '🍔';
    if (n.contains('bakery')) return '🥐';
    if (n.contains('store') || n.contains('shop')) return '🛍️';
    if (n.contains('gym') || n.contains('sport')) return '💪';
    if (n.contains('pharmacy')) return '💊';
    if (n.contains('hotel')) return '🏨';
    return '📍';
  }
}
