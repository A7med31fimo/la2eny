import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../domain/entities/category.dart';
import '../../../providers/places_provider.dart';
import '../../../router/app_router.dart';

class CategoryGrid extends ConsumerWidget {
  final String locale;
  const CategoryGrid({super.key, required this.locale});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);

    return categoriesAsync.when(
      loading: () => _buildSkeletonRow(),
      error: (_, __) => const SizedBox.shrink(),
      data: (categories) => _buildRow(context, ref, categories),
    );
  }

  Widget _buildRow(BuildContext context, WidgetRef ref, List<Category> categories) {
    final displayCats = categories.take(8).toList();
    return SizedBox(
      height: 96,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: displayCats.length,
        itemBuilder: (context, i) => _CategoryItem(
          category: displayCats[i],
          locale: locale,
          onTap: () {
            ref.read(placeFilterNotifierProvider.notifier)
                .setCategoryId(displayCats[i].id);
            context.go(AppRoutes.discover);
          },
        ),
      ),
    );
  }

  Widget _buildSkeletonRow() {
    return SizedBox(
      height: 96,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 6,
        itemBuilder: (_, __) => Container(
          width: 70,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final Category category;
  final String locale;
  final VoidCallback onTap;

  const _CategoryItem({
    required this.category,
    required this.locale,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 72,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  _categoryEmoji(category.nameEn),
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              category.localizedName(locale),
              style: AppTextStyles.labelSmall,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  String _categoryEmoji(String name) {
    final n = name.toLowerCase();
    if (n.contains('restaurant') || n.contains('food')) return '🍽️';
    if (n.contains('cafe') || n.contains('coffee')) return '☕';
    if (n.contains('fast')) return '🍔';
    if (n.contains('bakery') || n.contains('bread')) return '🥐';
    if (n.contains('store') || n.contains('shop')) return '🛍️';
    if (n.contains('gym') || n.contains('sport')) return '💪';
    if (n.contains('beauty') || n.contains('salon')) return '💅';
    if (n.contains('pharmacy') || n.contains('health')) return '💊';
    if (n.contains('hotel')) return '🏨';
    if (n.contains('market') || n.contains('super')) return '🛒';
    return '📍';
  }
}
