import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../providers/locale_provider.dart';
import '../../router/app_router.dart';
import '../../widgets/sync_status_bar.dart';
import 'widgets/category_grid.dart';
import 'widgets/featured_places_section.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeNotifierProvider).languageCode;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(children: [
        const SyncStatusBar(),
        Expanded(child: CustomScrollView(slivers: [
          _appBar(context, locale),
          _searchBar(context, locale),
          _aiBanner(context, locale),
          _catSection(ref, locale),
          _featuredSection(ref, locale),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ])),
      ]),
    );
  }

  SliverAppBar _appBar(BuildContext context, String locale) => SliverAppBar(
    floating: true, backgroundColor: AppColors.surface, elevation: 0, expandedHeight: 80,
    flexibleSpace: FlexibleSpaceBar(
      titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      title: Column(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(locale == 'ar' ? 'مرحباً!' : 'Good ${_greet()}!', style: AppTextStyles.bodySmall),
        Text(locale == 'ar' ? 'اعثر على المكان المثالي' : 'Find the perfect place', style: AppTextStyles.headlineMedium),
      ]),
    ),
  );

  SliverToBoxAdapter _searchBar(BuildContext context, String locale) => SliverToBoxAdapter(
    child: Padding(padding: const EdgeInsets.fromLTRB(16,12,16,0),
      child: GestureDetector(onTap: () => context.push(AppRoutes.search),
        child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(14)),
          child: Row(children: [
            const Icon(Icons.search, color: AppColors.textTertiary, size: 20), const SizedBox(width: 10),
            Text(locale == 'ar' ? 'ابحث عن أماكن...' : 'Search restaurants, cafés, stores...',
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textTertiary)),
          ])))));

  SliverToBoxAdapter _aiBanner(BuildContext context, String locale) => SliverToBoxAdapter(
    child: Padding(padding: const EdgeInsets.fromLTRB(16,16,16,0),
      child: GestureDetector(onTap: () => context.go(AppRoutes.chat),
        child: Container(padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.primaryLight], begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(16)),
          child: Row(children: [
            Container(width: 44, height: 44, decoration: BoxDecoration(
              color: Colors.white24, borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.smart_toy_outlined, color: Colors.white, size: 24)),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(locale == 'ar' ? 'اطلب توصيات من الذكاء الاصطناعي' : 'Ask AI for Recommendations',
                style: AppTextStyles.headlineSmall.copyWith(color: Colors.white)),
              const SizedBox(height: 2),
              Text(locale == 'ar' ? 'أخبرني بما تبحث عنه' : "Tell me what you're looking for",
                style: AppTextStyles.bodySmall.copyWith(color: Colors.white70)),
            ])),
            const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
          ])))));

  SliverToBoxAdapter _catSection(WidgetRef ref, String locale) => SliverToBoxAdapter(
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(padding: const EdgeInsets.fromLTRB(20,24,20,12),
        child: Text(locale == 'ar' ? 'تصفح حسب الفئة' : 'Browse by Category', style: AppTextStyles.headlineMedium)),
      CategoryGrid(locale: locale),
    ]));

  SliverToBoxAdapter _featuredSection(WidgetRef ref, String locale) => SliverToBoxAdapter(
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(padding: const EdgeInsets.fromLTRB(20,24,20,12),
        child: Text(locale == 'ar' ? 'الأماكن الشهيرة قربك' : 'Popular Near You', style: AppTextStyles.headlineMedium)),
      FeaturedPlacesSection(locale: locale),
    ]));

  String _greet() {
    final h = DateTime.now().hour;
    if (h < 12) return 'morning';
    if (h < 17) return 'afternoon';
    if (h < 21) return 'evening';
    return 'night';
  }
}
