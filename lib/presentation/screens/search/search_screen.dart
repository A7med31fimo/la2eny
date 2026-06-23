import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../domain/entities/place.dart';
import '../../providers/places_provider.dart';
import '../../providers/locale_provider.dart';
import '../../providers/auth_provider.dart';
import '../../router/app_router.dart';
import '../../widgets/place_list_tile.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _focusNode.requestFocus());
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onQueryChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: AppConstants.searchDebounceMs),
      () => ref.read(searchQueryNotifierProvider.notifier).setQuery(query),
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(localeNotifierProvider).languageCode;
    final query = ref.watch(searchQueryNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          focusNode: _focusNode,
          onChanged: _onQueryChanged,
          textDirection: locale == 'ar' ? TextDirection.rtl : TextDirection.ltr,
          decoration: InputDecoration(
            hintText: locale == 'ar'
                ? 'ابحث عن مطاعم، مقاهي...'
                : 'Search restaurants, cafés...',
            border: InputBorder.none,
            hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textTertiary),
          ),
          style: AppTextStyles.bodyMedium,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            ref.read(searchQueryNotifierProvider.notifier).clear();
            context.pop();
          },
        ),
        actions: [
          if (_controller.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _controller.clear();
                ref.read(searchQueryNotifierProvider.notifier).clear();
              },
            ),
        ],
      ),
      body: query.isEmpty ? _suggestions(locale) : _results(locale),
    );
  }

  Widget _suggestions(String locale) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            locale == 'ar' ? 'اقتراحات' : 'Suggestions',
            style: AppTextStyles.headlineSmall,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _suggestions_list(locale).map((s) => GestureDetector(
                  onTap: () {
                    _controller.text = s;
                    ref.read(searchQueryNotifierProvider.notifier).setQuery(s);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.search, size: 14, color: AppColors.textTertiary),
                        const SizedBox(width: 6),
                        Text(s, style: AppTextStyles.labelMedium),
                      ],
                    ),
                  ),
                )).toList(),
          ),
        ],
      ),
    );
  }

  List<String> _suggestions_list(String locale) => locale == 'ar'
      ? ['مطعم', 'مقهى', 'وجبات سريعة', 'برجر', 'بيتزا', 'مخبز']
      : ['restaurant', 'coffee', 'burger', 'pizza', 'sushi', 'bakery'];

  Widget _results(String locale) {
    final resultsAsync = ref.watch(searchResultsProvider);

    return resultsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(
        child: Text('Search failed', style: AppTextStyles.bodySmall),
      ),
      data: (places) {
        if (places.isEmpty) return _empty(locale);
        return ListView.builder(
          padding: const EdgeInsets.only(top: 8, bottom: 24),
          itemCount: places.length,
          itemBuilder: (context, i) => _buildTile(places[i], locale),
        );
      },
    );
  }

  Widget _buildTile(Place place, String locale) {
    final auth = ref.read(authNotifierProvider);
    final userId = auth?.id ?? '';
    final isFav = userId.isNotEmpty
        ? (ref.watch(favoriteIdsProvider(userId)).valueOrNull?.contains(place.id) ?? false)
        : false;

    return PlaceListTile(
      place: place,
      locale: locale,
      isFavorite: isFav,
      onTap: () => context.push(AppRoutes.placeDetailPath(place.id)),
      onFavoriteTap: auth != null && !auth.isGuest
          ? () async {
              await ref.read(placeRepositoryProvider).toggleFavorite(place.id, userId);
              ref.invalidate(favoriteIdsProvider(userId));
            }
          : null,
    );
  }

  Widget _empty(String locale) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, size: 64, color: AppColors.textTertiary),
            const SizedBox(height: 16),
            Text(
              locale == 'ar' ? 'لا توجد نتائج' : 'No results found',
              style: AppTextStyles.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              locale == 'ar' ? 'جرب بحثاً مختلفاً' : 'Try a different search term',
              style: AppTextStyles.bodySmall,
            ),
          ],
        ),
      );
}
