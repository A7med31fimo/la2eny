import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../providers/places_provider.dart';
import '../../providers/locale_provider.dart';
import '../../providers/auth_provider.dart';
import '../../router/app_router.dart';
import '../../widgets/place_list_tile.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});
  @override ConsumerState<SearchScreen> createState() => _State();
}

class _State extends ConsumerState<SearchScreen> {
  final _ctrl = TextEditingController();
  final _focus = FocusNode();
  Timer? _debounce;

  @override void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _focus.requestFocus());
  }

  @override void dispose() { _ctrl.dispose(); _focus.dispose(); _debounce?.cancel(); super.dispose(); }

  void _onChanged(String q) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: AppConstants.searchDebounceMs),
      () => ref.read(searchQueryNotifierProvider.notifier).setQuery(q));
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(localeNotifierProvider).languageCode;
    final query = ref.watch(searchQueryNotifierProvider);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: TextField(
          controller: _ctrl, focusNode: _focus, onChanged: _onChanged,
          textDirection: locale == 'ar' ? TextDirection.rtl : TextDirection.ltr,
          decoration: InputDecoration(
            hintText: locale == 'ar' ? 'ابحث عن مطاعم، مقاهي...' : 'Search restaurants, cafés...',
            border: InputBorder.none, hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textTertiary)),
          style: AppTextStyles.bodyMedium),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {
          ref.read(searchQueryNotifierProvider.notifier).clear(); context.pop(); }),
        actions: [if (_ctrl.text.isNotEmpty) IconButton(icon: const Icon(Icons.clear), onPressed: () {
          _ctrl.clear(); ref.read(searchQueryNotifierProvider.notifier).clear(); })],
      ),
      body: query.isEmpty ? _suggestions(locale) : _results(locale),
    );
  }

  Widget _suggestions(String locale) => Padding(padding: const EdgeInsets.all(20),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(locale == 'ar' ? 'اقتراحات' : 'Suggestions', style: AppTextStyles.headlineSmall),
      const SizedBox(height: 16),
      Wrap(spacing: 8, runSpacing: 8,
        children: (locale == 'ar'
          ? ['مطعم','مقهى','وجبات سريعة','برجر','بيتزا','مخبز']
          : ['restaurant','coffee','burger','pizza','sushi','bakery'])
          .map((s) => GestureDetector(
            onTap: () { _ctrl.text = s; ref.read(searchQueryNotifierProvider.notifier).setQuery(s); },
            child: Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(20)),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                const Icon(Icons.search, size: 14, color: AppColors.textTertiary), const SizedBox(width: 6),
                Text(s, style: AppTextStyles.labelMedium)])))).toList()),
    ]));

  Widget _results(String locale) => ref.watch(searchResultsProvider).when(
    loading: () => const Center(child: CircularProgressIndicator()),
    error: (_, __) => Center(child: Text('Search failed', style: AppTextStyles.bodySmall)),
    data: (places) {
      if (places.isEmpty) {
        return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.search_off, size: 64, color: AppColors.textTertiary), const SizedBox(height: 16),
        Text(locale == 'ar' ? 'لا توجد نتائج' : 'No results found', style: AppTextStyles.headlineMedium),
        const SizedBox(height: 8),
        Text(locale == 'ar' ? 'جرب بحثاً مختلفاً' : 'Try a different search term', style: AppTextStyles.bodySmall),
      ]));
      }
      return ListView.builder(padding: const EdgeInsets.only(top: 8, bottom: 24), itemCount: places.length,
        itemBuilder: (ctx, i) {
          final place = places[i];
          final auth = ref.read(authNotifierProvider);
          final userId = auth?.id ?? '';
          final isFav = userId.isNotEmpty
            ? ref.watch(favoriteIdsProvider(userId)).when(
                data: (ids) => ids.contains(place.id),
                loading: () => false,
                error: (_, __) => false,
              ) : false;
          return PlaceListTile(place: place, locale: locale, isFavorite: isFav,
            onTap: () => ctx.push(AppRoutes.placeDetailPath(place.id)),
            onFavoriteTap: auth != null && !auth.isGuest ? () async {
              await ref.read(placeRepositoryProvider).toggleFavorite(place.id, userId);
              ref.invalidate(favoriteIdsProvider(userId));
            } : null);
        });
    });
}
