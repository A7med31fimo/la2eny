import '../../domain/entities/place.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/working_hours.dart';
import '../../domain/entities/place_image.dart';
import '../../domain/entities/social_link.dart';

class PlaceDto {
  final int id;
  final String nameAr, nameEn, descriptionAr, descriptionEn, addressAr, addressEn;
  final double latitude, longitude, rating;
  final String? phone, website;
  final int reviewCount, priceLevel;
  final bool isActive;
  final String updatedAt, createdAt;
  final List<CategoryDto> categories;
  final List<WorkingHoursDto> workingHours;
  final List<PlaceImageDto> images;
  final List<SocialLinkDto> socialLinks;

  const PlaceDto({
    required this.id, required this.nameAr, required this.nameEn,
    this.descriptionAr = '', this.descriptionEn = '', this.addressAr = '', this.addressEn = '',
    required this.latitude, required this.longitude, this.phone, this.website,
    this.rating = 0.0, this.reviewCount = 0, this.priceLevel = 1, this.isActive = true,
    required this.updatedAt, required this.createdAt,
    this.categories = const [], this.workingHours = const [],
    this.images = const [], this.socialLinks = const [],
  });

  factory PlaceDto.fromJson(Map<String, dynamic> j) => PlaceDto(
    id: j['id'] as int,
    nameAr: j['name_ar'] as String? ?? '',
    nameEn: j['name_en'] as String? ?? '',
    descriptionAr: j['description_ar'] as String? ?? '',
    descriptionEn: j['description_en'] as String? ?? '',
    addressAr: j['address_ar'] as String? ?? '',
    addressEn: j['address_en'] as String? ?? '',
    latitude: (j['latitude'] as num).toDouble(),
    longitude: (j['longitude'] as num).toDouble(),
    phone: j['phone'] as String?,
    website: j['website'] as String?,
    rating: (j['rating'] as num?)?.toDouble() ?? 0.0,
    reviewCount: j['review_count'] as int? ?? 0,
    priceLevel: j['price_level'] as int? ?? 1,
    isActive: j['is_active'] as bool? ?? true,
    updatedAt: j['updated_at'] as String,
    createdAt: j['created_at'] as String,
    categories: (j['categories'] as List<dynamic>? ?? []).map((e) => CategoryDto.fromJson(e as Map<String, dynamic>)).toList(),
    workingHours: (j['working_hours'] as List<dynamic>? ?? []).map((e) => WorkingHoursDto.fromJson(e as Map<String, dynamic>)).toList(),
    images: (j['images'] as List<dynamic>? ?? []).map((e) => PlaceImageDto.fromJson(e as Map<String, dynamic>)).toList(),
    socialLinks: (j['social_links'] as List<dynamic>? ?? []).map((e) => SocialLinkDto.fromJson(e as Map<String, dynamic>)).toList(),
  );

  Place toEntity() => Place(
    id: id, nameAr: nameAr, nameEn: nameEn,
    descriptionAr: descriptionAr, descriptionEn: descriptionEn,
    addressAr: addressAr, addressEn: addressEn,
    latitude: latitude, longitude: longitude, phone: phone, website: website,
    rating: rating, reviewCount: reviewCount, priceLevel: priceLevel, isActive: isActive,
    categories: categories.map((c) => c.toEntity()).toList(),
    workingHours: workingHours.map((h) => h.toEntity(id)).toList(),
    images: images.map((i) => i.toEntity(id)).toList(),
    socialLinks: socialLinks.map((s) => s.toEntity(id)).toList(),
    updatedAt: DateTime.parse(updatedAt), createdAt: DateTime.parse(createdAt),
  );
}

class CategoryDto {
  final int id;
  final String nameAr, nameEn;
  final String? icon, updatedAt;
  const CategoryDto({required this.id, required this.nameAr, required this.nameEn, this.icon, this.updatedAt});
  factory CategoryDto.fromJson(Map<String, dynamic> j) => CategoryDto(
    id: j['id'] as int, nameAr: j['name_ar'] as String? ?? '', nameEn: j['name_en'] as String? ?? '',
    icon: j['icon'] as String?, updatedAt: j['updated_at'] as String?);
  Category toEntity() => Category(id: id, nameAr: nameAr, nameEn: nameEn, icon: icon);
}

class WorkingHoursDto {
  final int id, dayOfWeek;
  final String openTime, closeTime;
  final bool isClosed;
  const WorkingHoursDto({required this.id, required this.dayOfWeek, this.openTime = '00:00', this.closeTime = '00:00', this.isClosed = false});
  factory WorkingHoursDto.fromJson(Map<String, dynamic> j) => WorkingHoursDto(
    id: j['id'] as int, dayOfWeek: j['day_of_week'] as int,
    openTime: j['open_time'] as String? ?? '00:00', closeTime: j['close_time'] as String? ?? '00:00',
    isClosed: j['is_closed'] as bool? ?? false);
  WorkingHours toEntity(int placeId) => WorkingHours(
    id: id, placeId: placeId, dayOfWeek: dayOfWeek,
    openTime: openTime, closeTime: closeTime, isClosed: isClosed);
}

class PlaceImageDto {
  final int id, sortOrder;
  final String url;
  final bool isPrimary;
  const PlaceImageDto({required this.id, required this.url, this.isPrimary = false, this.sortOrder = 0});
  factory PlaceImageDto.fromJson(Map<String, dynamic> j) => PlaceImageDto(
    id: j['id'] as int, url: j['url'] as String,
    isPrimary: j['is_primary'] as bool? ?? false, sortOrder: j['sort_order'] as int? ?? 0);
  PlaceImage toEntity(int placeId) => PlaceImage(id: id, placeId: placeId, url: url, isPrimary: isPrimary, sortOrder: sortOrder);
}

class SocialLinkDto {
  final int id;
  final String platform, url;
  const SocialLinkDto({required this.id, required this.platform, required this.url});
  factory SocialLinkDto.fromJson(Map<String, dynamic> j) =>
      SocialLinkDto(id: j['id'] as int, platform: j['platform'] as String, url: j['url'] as String);
  SocialLink toEntity(int placeId) => SocialLink(
    id: id, placeId: placeId, platform: SocialLink.platformFromString(platform), url: url);
}

class PlacesResponse {
  final List<PlaceDto> data;
  final int total, page, limit;
  const PlacesResponse({required this.data, required this.total, required this.page, required this.limit});
  factory PlacesResponse.fromJson(Map<String, dynamic> j) {
    final raw = j['data'] as List<dynamic>? ?? (j is List ? j as List<dynamic> : []);
    return PlacesResponse(
      data: raw.map((e) => PlaceDto.fromJson(e as Map<String, dynamic>)).toList(),
      total: j['total'] as int? ?? raw.length, page: j['page'] as int? ?? 0,
      limit: j['limit'] as int? ?? raw.length);
  }
  bool get hasMore => (page + 1) * limit < total;
}
