import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/place.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/working_hours.dart';
import '../../domain/entities/place_image.dart';
import '../../domain/entities/social_link.dart';

part 'place_dto.g.dart';

@JsonSerializable()
class PlaceDto {
  final int id;
  @JsonKey(name: 'name_ar') final String nameAr;
  @JsonKey(name: 'name_en') final String nameEn;
  @JsonKey(name: 'description_ar') final String descriptionAr;
  @JsonKey(name: 'description_en') final String descriptionEn;
  @JsonKey(name: 'address_ar') final String addressAr;
  @JsonKey(name: 'address_en') final String addressEn;
  final double latitude;
  final double longitude;
  final String? phone;
  final String? website;
  final double rating;
  @JsonKey(name: 'review_count') final int reviewCount;
  @JsonKey(name: 'price_level') final int priceLevel;
  @JsonKey(name: 'is_active') final bool isActive;
  @JsonKey(name: 'updated_at') final String updatedAt;
  @JsonKey(name: 'created_at') final String createdAt;
  final List<CategoryDto> categories;
  @JsonKey(name: 'working_hours') final List<WorkingHoursDto> workingHours;
  final List<PlaceImageDto> images;
  @JsonKey(name: 'social_links') final List<SocialLinkDto> socialLinks;

  const PlaceDto({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    this.descriptionAr = '',
    this.descriptionEn = '',
    this.addressAr = '',
    this.addressEn = '',
    required this.latitude,
    required this.longitude,
    this.phone,
    this.website,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.priceLevel = 1,
    this.isActive = true,
    required this.updatedAt,
    required this.createdAt,
    this.categories = const [],
    this.workingHours = const [],
    this.images = const [],
    this.socialLinks = const [],
  });

  factory PlaceDto.fromJson(Map<String, dynamic> json) =>
      _$PlaceDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceDtoToJson(this);

  Place toEntity() => Place(
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
        categories: categories.map((c) => c.toEntity()).toList(),
        workingHours: workingHours.map((h) => h.toEntity(id)).toList(),
        images: images.map((i) => i.toEntity(id)).toList(),
        socialLinks: socialLinks.map((s) => s.toEntity(id)).toList(),
        updatedAt: DateTime.parse(updatedAt),
        createdAt: DateTime.parse(createdAt),
      );
}

@JsonSerializable()
class CategoryDto {
  final int id;
  @JsonKey(name: 'name_ar') final String nameAr;
  @JsonKey(name: 'name_en') final String nameEn;
  final String? icon;
  @JsonKey(name: 'updated_at') final String? updatedAt;

  const CategoryDto({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    this.icon,
    this.updatedAt,
  });

  factory CategoryDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDtoToJson(this);

  Category toEntity() =>
      Category(id: id, nameAr: nameAr, nameEn: nameEn, icon: icon);
}

@JsonSerializable()
class WorkingHoursDto {
  final int id;
  @JsonKey(name: 'day_of_week') final int dayOfWeek;
  @JsonKey(name: 'open_time') final String openTime;
  @JsonKey(name: 'close_time') final String closeTime;
  @JsonKey(name: 'is_closed') final bool isClosed;

  const WorkingHoursDto({
    required this.id,
    required this.dayOfWeek,
    this.openTime = '00:00',
    this.closeTime = '00:00',
    this.isClosed = false,
  });

  factory WorkingHoursDto.fromJson(Map<String, dynamic> json) =>
      _$WorkingHoursDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WorkingHoursDtoToJson(this);

  WorkingHours toEntity(int placeId) => WorkingHours(
        id: id,
        placeId: placeId,
        dayOfWeek: dayOfWeek,
        openTime: openTime,
        closeTime: closeTime,
        isClosed: isClosed,
      );
}

@JsonSerializable()
class PlaceImageDto {
  final int id;
  final String url;
  @JsonKey(name: 'is_primary') final bool isPrimary;
  @JsonKey(name: 'sort_order') final int sortOrder;

  const PlaceImageDto({
    required this.id,
    required this.url,
    this.isPrimary = false,
    this.sortOrder = 0,
  });

  factory PlaceImageDto.fromJson(Map<String, dynamic> json) =>
      _$PlaceImageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceImageDtoToJson(this);

  PlaceImage toEntity(int placeId) => PlaceImage(
        id: id,
        placeId: placeId,
        url: url,
        isPrimary: isPrimary,
        sortOrder: sortOrder,
      );
}

@JsonSerializable()
class SocialLinkDto {
  final int id;
  final String platform;
  final String url;

  const SocialLinkDto({
    required this.id,
    required this.platform,
    required this.url,
  });

  factory SocialLinkDto.fromJson(Map<String, dynamic> json) =>
      _$SocialLinkDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SocialLinkDtoToJson(this);

  SocialLink toEntity(int placeId) => SocialLink(
        id: id,
        placeId: placeId,
        platform: SocialLink.platformFromString(platform),
        url: url,
      );
}

// API list response wrapper
class PlacesResponse {
  final List<PlaceDto> data;
  final int total;
  final int page;
  final int limit;

  const PlacesResponse({
    required this.data,
    required this.total,
    required this.page,
    required this.limit,
  });

  factory PlacesResponse.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'] as List<dynamic>? ?? json as List<dynamic>;
    return PlacesResponse(
      data: (rawData as List).map((e) => PlaceDto.fromJson(e as Map<String, dynamic>)).toList(),
      total: json['total'] as int? ?? rawData.length,
      page: json['page'] as int? ?? 0,
      limit: json['limit'] as int? ?? rawData.length,
    );
  }

  bool get hasMore => (page + 1) * limit < total;
}
