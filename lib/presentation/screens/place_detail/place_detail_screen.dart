import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart' hide Haversine;
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/haversine.dart';
import '../../../domain/entities/place.dart';
import '../../../domain/entities/social_link.dart';
import '../../providers/auth_provider.dart';
import '../../providers/locale_provider.dart';
import '../../providers/places_provider.dart';

class PlaceDetailScreen extends ConsumerWidget {
  final int placeId;
  const PlaceDetailScreen({super.key, required this.placeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeNotifierProvider).languageCode;
    final placeAsync = ref.watch(placeDetailProvider(placeId));
    return placeAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (_, __) => Scaffold(appBar: AppBar(), body: Center(
        child: Text('Place not found', style: AppTextStyles.bodyMedium))),
      data: (place) => place == null
        ? Scaffold(appBar: AppBar(), body: Center(child: Text('Place not found', style: AppTextStyles.bodyMedium)))
        : _PlaceDetailBody(place: place, locale: locale),
    );
  }
}

class _PlaceDetailBody extends ConsumerStatefulWidget {
  final Place place;
  final String locale;
  const _PlaceDetailBody({required this.place, required this.locale});
  @override ConsumerState<_PlaceDetailBody> createState() => _BodyState();
}

class _BodyState extends ConsumerState<_PlaceDetailBody> {
  bool _isFav = false;

  @override
  void initState() {
    super.initState();
    _loadFavorite();
  }

  Future<void> _loadFavorite() async {
    final auth = ref.read(authNotifierProvider);
    if (auth == null || auth.isGuest) return;
    final ids = await ref.read(placeRepositoryProvider).getFavoriteIds(auth.id);
    if (mounted) setState(() => _isFav = ids.contains(widget.place.id));
  }

  Future<void> _toggleFav() async {
    final auth = ref.read(authNotifierProvider);
    if (auth == null || auth.isGuest) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign in to save favorites')));
      return;
    }
    await ref.read(placeRepositoryProvider).toggleFavorite(widget.place.id, auth.id);
    setState(() => _isFav = !_isFav);
    ref.invalidate(favoriteIdsProvider(auth.id));
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.place;
    final locale = widget.locale;
    return Scaffold(
      body: CustomScrollView(slivers: [
        _buildSliverAppBar(p, locale),
        SliverToBoxAdapter(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _header(p, locale),
          if (p.matchExplanation != null) _aiMatch(p.matchExplanation!),
          _categories(p, locale),
          const Divider(height: 32),
          _aboutSection(p, locale),
          const Divider(height: 32),
          _hoursSection(p, locale),
          const Divider(height: 32),
          _mapSection(p, locale),
          const Divider(height: 32),
          _contactSection(p, locale),
          if (p.socialLinks.isNotEmpty) ...[const Divider(height: 32), _socialSection(p, locale)],
          const SizedBox(height: 40),
        ])),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _toggleFav,
        backgroundColor: _isFav ? AppColors.error : AppColors.primary,
        icon: Icon(_isFav ? Icons.favorite : Icons.favorite_outline, color: Colors.white),
        label: Text(_isFav
          ? (locale == 'ar' ? 'محفوظ' : 'Saved')
          : (locale == 'ar' ? 'حفظ' : 'Save'),
          style: AppTextStyles.button.copyWith(color: Colors.white)),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(Place p, String locale) => SliverAppBar(
    expandedHeight: 260,
    pinned: true,
    backgroundColor: AppColors.surface,
    foregroundColor: AppColors.textPrimary,
    flexibleSpace: FlexibleSpaceBar(
      background: p.images.isNotEmpty
        ? PageView.builder(
            itemCount: p.images.length,
            itemBuilder: (_, i) => CachedNetworkImage(
              imageUrl: p.images[i].url, fit: BoxFit.cover,
              placeholder: (_, __) => Container(color: AppColors.surfaceVariant),
              errorWidget: (_, __, ___) => Container(color: AppColors.surfaceVariant,
                child: const Icon(Icons.place, size: 64, color: AppColors.textTertiary))))
        : Container(color: AppColors.surfaceVariant,
            child: const Icon(Icons.place, size: 80, color: AppColors.textTertiary)),
    ),
  );

  Widget _header(Place p, String locale) => Padding(padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(p.localizedName(locale), style: AppTextStyles.displayLarge),
      const SizedBox(height: 8),
      Row(children: [
        const Icon(Icons.star_rounded, size: 18, color: AppColors.ratingGold),
        const SizedBox(width: 4),
        Text(p.rating.toStringAsFixed(1), style: AppTextStyles.headlineSmall),
        const SizedBox(width: 4),
        Text('(${p.reviewCount} ${locale == 'ar' ? 'تقييم' : 'reviews'})', style: AppTextStyles.bodySmall),
        const Spacer(),
        if (p.distanceKm != null) Row(children: [
          const Icon(Icons.near_me, size: 14, color: AppColors.textTertiary),
          const SizedBox(width: 4),
          Text(Haversine.formatDistance(p.distanceKm!), style: AppTextStyles.bodySmall),
        ]),
      ]),
      const SizedBox(height: 8),
      Row(children: [
        Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: p.isOpenNow ? AppColors.successContainer : AppColors.errorContainer,
            borderRadius: BorderRadius.circular(8)),
          child: Text(p.isOpenNow
            ? (locale == 'ar' ? 'مفتوح الآن' : 'Open Now')
            : (locale == 'ar' ? 'مغلق' : 'Closed'),
            style: AppTextStyles.labelMedium.copyWith(
              color: p.isOpenNow ? AppColors.openGreen : AppColors.closedRed))),
        const SizedBox(width: 12),
        Row(children: List.generate(4, (i) => Text('\$',
          style: AppTextStyles.labelMedium.copyWith(
            color: i < p.priceLevel ? AppColors.priceActive : AppColors.priceInactive)))),
      ]),
    ]));

  Widget _aiMatch(String explanation) => Container(
    margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: AppColors.primaryContainer, borderRadius: BorderRadius.circular(12)),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Icon(Icons.auto_awesome, color: AppColors.primary, size: 18),
      const SizedBox(width: 10),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Why this matches you', style: AppTextStyles.labelLarge.copyWith(color: AppColors.primary)),
        const SizedBox(height: 4),
        Text(explanation, style: AppTextStyles.bodySmall.copyWith(color: AppColors.primaryDark)),
      ])),
    ]));

  Widget _categories(Place p, String locale) => p.categories.isEmpty ? const SizedBox.shrink()
    : Padding(padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
        child: Wrap(spacing: 8, children: p.categories.map((c) => Chip(
          label: Text(c.localizedName(locale), style: AppTextStyles.labelMedium),
          backgroundColor: AppColors.primaryContainer,
          side: BorderSide.none)).toList()));

  Widget _sectionTitle(String title) => Padding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
    child: Text(title, style: AppTextStyles.headlineMedium));

  Widget _aboutSection(Place p, String locale) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    _sectionTitle(locale == 'ar' ? 'عن المكان' : 'About'),
    Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(p.localizedDescription(locale).isNotEmpty
        ? p.localizedDescription(locale)
        : (locale == 'ar' ? 'لا يوجد وصف' : 'No description available'),
        style: AppTextStyles.bodyMedium)),
    const SizedBox(height: 12),
    Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        const Icon(Icons.location_on_outlined, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 6),
        Expanded(child: Text(p.localizedAddress(locale), style: AppTextStyles.bodySmall)),
      ])),
  ]);

  Widget _hoursSection(Place p, String locale) {
    if (p.workingHours.isEmpty) return const SizedBox.shrink();
    final today = DateTime.now().weekday % 7;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _sectionTitle(locale == 'ar' ? 'ساعات العمل' : 'Working Hours'),
      ...p.workingHours.map((h) {
        final isToday = h.dayOfWeek == today;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isToday ? AppColors.primaryContainer : Colors.transparent,
            borderRadius: BorderRadius.circular(8)),
          child: Row(children: [
            Text(h.dayName(locale), style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: isToday ? FontWeight.w600 : FontWeight.w400,
              color: isToday ? AppColors.primary : AppColors.textPrimary)),
            const Spacer(),
            Text(h.isClosed ? (locale == 'ar' ? 'مغلق' : 'Closed') : '${h.openTime} – ${h.closeTime}',
              style: AppTextStyles.bodySmall.copyWith(
                color: h.isClosed ? AppColors.closedRed : isToday ? AppColors.primary : AppColors.textSecondary)),
          ]));
      }),
    ]);
  }

  Widget _mapSection(Place p, String locale) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    _sectionTitle(locale == 'ar' ? 'الموقع' : 'Location'),
    Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(borderRadius: BorderRadius.circular(14),
        child: SizedBox(height: 200,
          child: FlutterMap(
            options: MapOptions(initialCenter: LatLng(p.latitude, p.longitude), initialZoom: 15),
            children: [
              TileLayer(urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.localai.app'),
              MarkerLayer(markers: [
                Marker(point: LatLng(p.latitude, p.longitude), width: 40, height: 40,
                  child: const Icon(Icons.location_pin, color: AppColors.error, size: 40)),
              ]),
            ])))),
    const SizedBox(height: 12),
    Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
      child: OutlinedButton.icon(
        onPressed: () => _launchUrl('https://www.openstreetmap.org/?mlat=${p.latitude}&mlon=${p.longitude}'),
        icon: const Icon(Icons.directions, size: 18),
        label: Text(locale == 'ar' ? 'الحصول على الاتجاهات' : 'Get Directions'),
        style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 48)))),
  ]);

  Widget _contactSection(Place p, String locale) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    _sectionTitle(locale == 'ar' ? 'التواصل' : 'Contact'),
    if (p.phone != null) _contactTile(Icons.phone, locale == 'ar' ? 'اتصال' : 'Call', p.phone!, 'tel:${p.phone}'),
    if (p.website != null) _contactTile(Icons.language, locale == 'ar' ? 'الموقع الإلكتروني' : 'Website', p.website!, p.website!),
  ]);

  Widget _contactTile(IconData icon, String label, String value, String url) =>
    ListTile(leading: Container(width: 40, height: 40, decoration: BoxDecoration(
      color: AppColors.primaryContainer, borderRadius: BorderRadius.circular(10)),
      child: Icon(icon, color: AppColors.primary, size: 20)),
      title: Text(label, style: AppTextStyles.labelLarge),
      subtitle: Text(value, style: AppTextStyles.bodySmall),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textTertiary),
      onTap: () => _launchUrl(url));

  Widget _socialSection(Place p, String locale) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    _sectionTitle(locale == 'ar' ? 'التواصل الاجتماعي' : 'Social Media'),
    Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Wrap(spacing: 12, children: p.socialLinks.map((s) => GestureDetector(
        onTap: () => _launchUrl(s.url),
        child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(10)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(_socialIcon(s.platform), size: 18, color: AppColors.textSecondary),
            const SizedBox(width: 6),
            Text(s.platform.name.capitalize(), style: AppTextStyles.labelMedium),
          ])))).toList())),
  ]);

  IconData _socialIcon(SocialPlatform p) {
    switch (p) {
      case SocialPlatform.instagram: return Icons.camera_alt_outlined;
      case SocialPlatform.twitter: return Icons.tag;
      case SocialPlatform.facebook: return Icons.facebook;
      case SocialPlatform.snapchat: return Icons.snapchat;
      case SocialPlatform.tiktok: return Icons.music_note;
      case SocialPlatform.youtube: return Icons.play_circle_outline;
      default: return Icons.link;
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) await launchUrl(uri);
  }
}

extension _StrExt on String {
  String capitalize() => isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}
