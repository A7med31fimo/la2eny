import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
  final double? distanceKm;
  final double? matchScore;
  final String? matchExplanation;
  final bool? isFavorite;

  const Place({
    required this.id, required this.nameAr, required this.nameEn,
    required this.descriptionAr, required this.descriptionEn,
    required this.addressAr, required this.addressEn,
    required this.latitude, required this.longitude,
    this.phone, this.website,
    required this.rating, required this.reviewCount, required this.priceLevel,
    required this.isActive, required this.categories, required this.workingHours,
    required this.images, required this.socialLinks,
    required this.updatedAt, required this.createdAt,
    this.distanceKm, this.matchScore, this.matchExplanation, this.isFavorite,
  });

  String localizedName(String locale) => locale == 'ar' ? nameAr : nameEn;
  String localizedDescription(String locale) => locale == 'ar' ? descriptionAr : descriptionEn;
  String localizedAddress(String locale) => locale == 'ar' ? addressAr : addressEn;

  String? get primaryImageUrl {
    if (images.isEmpty) return null;
    final primary = images.where((i) => i.isPrimary).firstOrNull;
    return primary?.url ?? images.first.url;
  }

  bool get isOpenNow {
    final now = DateTime.now();
    final dayOfWeek = now.weekday % 7;
    final todayH = workingHours.where((h) => h.dayOfWeek == dayOfWeek).firstOrNull;
    if (todayH == null || todayH.isClosed) return false;
    final open = _parseTime(todayH.openTime);
    final close = _parseTime(todayH.closeTime);
    final cur = TimeOfDay(hour: now.hour, minute: now.minute);
    return _inRange(cur, open, close);
  }

  WorkingHours? get todayHours {
    final dayOfWeek = DateTime.now().weekday % 7;
    return workingHours.where((h) => h.dayOfWeek == dayOfWeek).firstOrNull;
  }

  TimeOfDay _parseTime(String t) {
    final p = t.split(':');
    return TimeOfDay(hour: int.parse(p[0]), minute: int.parse(p[1]));
  }

  bool _inRange(TimeOfDay cur, TimeOfDay open, TimeOfDay close) {
    final c = cur.hour * 60 + cur.minute;
    final o = open.hour * 60 + open.minute;
    final cl = close.hour * 60 + close.minute;
    return cl > o ? (c >= o && c <= cl) : (c >= o || c <= cl);
  }

  Place copyWith({double? distanceKm, double? matchScore, String? matchExplanation, bool? isFavorite}) =>
    Place(
      id: id, nameAr: nameAr, nameEn: nameEn,
      descriptionAr: descriptionAr, descriptionEn: descriptionEn,
      addressAr: addressAr, addressEn: addressEn,
      latitude: latitude, longitude: longitude, phone: phone, website: website,
      rating: rating, reviewCount: reviewCount, priceLevel: priceLevel,
      isActive: isActive, categories: categories, workingHours: workingHours,
      images: images, socialLinks: socialLinks, updatedAt: updatedAt, createdAt: createdAt,
      distanceKm: distanceKm ?? this.distanceKm,
      matchScore: matchScore ?? this.matchScore,
      matchExplanation: matchExplanation ?? this.matchExplanation,
      isFavorite: isFavorite ?? this.isFavorite,
    );

  @override List<Object?> get props => [id, nameEn, updatedAt];
}
