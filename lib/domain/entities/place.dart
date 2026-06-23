import 'package:equatable/equatable.dart';
import 'category.dart';
import 'working_hours.dart';
import 'place_image.dart';
import 'social_link.dart';

class Place extends Equatable {
  final int id;
  final String nameAr;
  final String nameEn;
  final String descriptionAr;
  final String descriptionEn;
  final String addressAr;
  final String addressEn;
  final double latitude;
  final double longitude;
  final String? phone;
  final String? website;
  final double rating;
  final int reviewCount;
  final int priceLevel;
  final bool isActive;
  final List<Category> categories;
  final List<WorkingHours> workingHours;
  final List<PlaceImage> images;
  final List<SocialLink> socialLinks;
  final DateTime updatedAt;
  final DateTime createdAt;

  // Computed fields (not stored)
  final double? distanceKm;
  final double? matchScore;
  final String? matchExplanation;
  final bool? isFavorite;

  const Place({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.addressAr,
    required this.addressEn,
    required this.latitude,
    required this.longitude,
    this.phone,
    this.website,
    required this.rating,
    required this.reviewCount,
    required this.priceLevel,
    required this.isActive,
    required this.categories,
    required this.workingHours,
    required this.images,
    required this.socialLinks,
    required this.updatedAt,
    required this.createdAt,
    this.distanceKm,
    this.matchScore,
    this.matchExplanation,
    this.isFavorite,
  });

  /// Returns localized name based on locale code ('ar' or 'en')
  String localizedName(String locale) =>
      locale == 'ar' ? nameAr : nameEn;

  /// Returns localized description based on locale code
  String localizedDescription(String locale) =>
      locale == 'ar' ? descriptionAr : descriptionEn;

  /// Returns localized address based on locale code
  String localizedAddress(String locale) =>
      locale == 'ar' ? addressAr : addressEn;

  /// Primary image URL or null
  String? get primaryImageUrl {
    if (images.isEmpty) return null;
    final primary = images.where((i) => i.isPrimary).firstOrNull;
    return primary?.url ?? images.first.url;
  }

  /// Whether the place is currently open based on device time
  bool get isOpenNow {
    final now = DateTime.now();
    final dayOfWeek = now.weekday % 7; // 0=Sunday ... 6=Saturday
    final todayHours = workingHours.where((h) => h.dayOfWeek == dayOfWeek);
    if (todayHours.isEmpty) return false;
    final hours = todayHours.first;
    if (hours.isClosed) return false;
    final open = _parseTime(hours.openTime);
    final close = _parseTime(hours.closeTime);
    final current = TimeOfDay(hour: now.hour, minute: now.minute);
    return _isTimeInRange(current, open, close);
  }

  /// Today's working hours entry or null
  WorkingHours? get todayHours {
    final dayOfWeek = DateTime.now().weekday % 7;
    return workingHours.where((h) => h.dayOfWeek == dayOfWeek).firstOrNull;
  }

  TimeOfDay _parseTime(String time) {
    final parts = time.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  bool _isTimeInRange(TimeOfDay current, TimeOfDay open, TimeOfDay close) {
    final currentMinutes = current.hour * 60 + current.minute;
    final openMinutes = open.hour * 60 + open.minute;
    final closeMinutes = close.hour * 60 + close.minute;
    if (closeMinutes > openMinutes) {
      return currentMinutes >= openMinutes && currentMinutes <= closeMinutes;
    }
    // Handles overnight (e.g. 22:00 - 02:00)
    return currentMinutes >= openMinutes || currentMinutes <= closeMinutes;
  }

  Place copyWith({
    double? distanceKm,
    double? matchScore,
    String? matchExplanation,
    bool? isFavorite,
  }) {
    return Place(
      id: id,
      nameAr: nameAr,
      nameEn: nameEn,
      descriptionAr: descriptionAr,
      descriptionEn: descriptionEn,
      addressAr: addressAr,
      addressEn: addressEn,
      latitude: latitude,
      longitude: longitude,
      phone: phone,
      website: website,
      rating: rating,
      reviewCount: reviewCount,
      priceLevel: priceLevel,
      isActive: isActive,
      categories: categories,
      workingHours: workingHours,
      images: images,
      socialLinks: socialLinks,
      updatedAt: updatedAt,
      createdAt: createdAt,
      distanceKm: distanceKm ?? this.distanceKm,
      matchScore: matchScore ?? this.matchScore,
      matchExplanation: matchExplanation ?? this.matchExplanation,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [id, nameEn, nameAr, latitude, longitude, updatedAt];
}
