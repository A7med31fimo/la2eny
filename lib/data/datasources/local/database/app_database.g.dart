// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PlacesTableTable extends PlacesTable
    with TableInfo<$PlacesTableTable, PlacesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlacesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameArMeta = const VerificationMeta('nameAr');
  @override
  late final GeneratedColumn<String> nameAr = GeneratedColumn<String>(
      'name_ar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
      'name_en', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionArMeta =
      const VerificationMeta('descriptionAr');
  @override
  late final GeneratedColumn<String> descriptionAr = GeneratedColumn<String>(
      'description_ar', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _descriptionEnMeta =
      const VerificationMeta('descriptionEn');
  @override
  late final GeneratedColumn<String> descriptionEn = GeneratedColumn<String>(
      'description_en', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _addressArMeta =
      const VerificationMeta('addressAr');
  @override
  late final GeneratedColumn<String> addressAr = GeneratedColumn<String>(
      'address_ar', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _addressEnMeta =
      const VerificationMeta('addressEn');
  @override
  late final GeneratedColumn<String> addressEn = GeneratedColumn<String>(
      'address_en', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
      'latitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _longitudeMeta =
      const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
      'longitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _websiteMeta =
      const VerificationMeta('website');
  @override
  late final GeneratedColumn<String> website = GeneratedColumn<String>(
      'website', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<double> rating = GeneratedColumn<double>(
      'rating', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _reviewCountMeta =
      const VerificationMeta('reviewCount');
  @override
  late final GeneratedColumn<int> reviewCount = GeneratedColumn<int>(
      'review_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _priceLevelMeta =
      const VerificationMeta('priceLevel');
  @override
  late final GeneratedColumn<int> priceLevel = GeneratedColumn<int>(
      'price_level', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        nameAr,
        nameEn,
        descriptionAr,
        descriptionEn,
        addressAr,
        addressEn,
        latitude,
        longitude,
        phone,
        website,
        rating,
        reviewCount,
        priceLevel,
        isActive,
        updatedAt,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'places';
  @override
  VerificationContext validateIntegrity(Insertable<PlacesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name_ar')) {
      context.handle(_nameArMeta,
          nameAr.isAcceptableOrUnknown(data['name_ar']!, _nameArMeta));
    } else if (isInserting) {
      context.missing(_nameArMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(_nameEnMeta,
          nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta));
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('description_ar')) {
      context.handle(
          _descriptionArMeta,
          descriptionAr.isAcceptableOrUnknown(
              data['description_ar']!, _descriptionArMeta));
    }
    if (data.containsKey('description_en')) {
      context.handle(
          _descriptionEnMeta,
          descriptionEn.isAcceptableOrUnknown(
              data['description_en']!, _descriptionEnMeta));
    }
    if (data.containsKey('address_ar')) {
      context.handle(_addressArMeta,
          addressAr.isAcceptableOrUnknown(data['address_ar']!, _addressArMeta));
    }
    if (data.containsKey('address_en')) {
      context.handle(_addressEnMeta,
          addressEn.isAcceptableOrUnknown(data['address_en']!, _addressEnMeta));
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('website')) {
      context.handle(_websiteMeta,
          website.isAcceptableOrUnknown(data['website']!, _websiteMeta));
    }
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta));
    }
    if (data.containsKey('review_count')) {
      context.handle(
          _reviewCountMeta,
          reviewCount.isAcceptableOrUnknown(
              data['review_count']!, _reviewCountMeta));
    }
    if (data.containsKey('price_level')) {
      context.handle(
          _priceLevelMeta,
          priceLevel.isAcceptableOrUnknown(
              data['price_level']!, _priceLevelMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlacesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlacesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nameAr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_ar'])!,
      nameEn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_en'])!,
      descriptionAr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description_ar'])!,
      descriptionEn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description_en'])!,
      addressAr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address_ar'])!,
      addressEn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address_en'])!,
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitude'])!,
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitude'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      website: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}website']),
      rating: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}rating'])!,
      reviewCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}review_count'])!,
      priceLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}price_level'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_at'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $PlacesTableTable createAlias(String alias) {
    return $PlacesTableTable(attachedDatabase, alias);
  }
}

class PlacesTableData extends DataClass implements Insertable<PlacesTableData> {
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
  final String updatedAt;
  final String createdAt;
  const PlacesTableData(
      {required this.id,
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
      required this.updatedAt,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name_ar'] = Variable<String>(nameAr);
    map['name_en'] = Variable<String>(nameEn);
    map['description_ar'] = Variable<String>(descriptionAr);
    map['description_en'] = Variable<String>(descriptionEn);
    map['address_ar'] = Variable<String>(addressAr);
    map['address_en'] = Variable<String>(addressEn);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || website != null) {
      map['website'] = Variable<String>(website);
    }
    map['rating'] = Variable<double>(rating);
    map['review_count'] = Variable<int>(reviewCount);
    map['price_level'] = Variable<int>(priceLevel);
    map['is_active'] = Variable<bool>(isActive);
    map['updated_at'] = Variable<String>(updatedAt);
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  PlacesTableCompanion toCompanion(bool nullToAbsent) {
    return PlacesTableCompanion(
      id: Value(id),
      nameAr: Value(nameAr),
      nameEn: Value(nameEn),
      descriptionAr: Value(descriptionAr),
      descriptionEn: Value(descriptionEn),
      addressAr: Value(addressAr),
      addressEn: Value(addressEn),
      latitude: Value(latitude),
      longitude: Value(longitude),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      website: website == null && nullToAbsent
          ? const Value.absent()
          : Value(website),
      rating: Value(rating),
      reviewCount: Value(reviewCount),
      priceLevel: Value(priceLevel),
      isActive: Value(isActive),
      updatedAt: Value(updatedAt),
      createdAt: Value(createdAt),
    );
  }

  factory PlacesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlacesTableData(
      id: serializer.fromJson<int>(json['id']),
      nameAr: serializer.fromJson<String>(json['nameAr']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      descriptionAr: serializer.fromJson<String>(json['descriptionAr']),
      descriptionEn: serializer.fromJson<String>(json['descriptionEn']),
      addressAr: serializer.fromJson<String>(json['addressAr']),
      addressEn: serializer.fromJson<String>(json['addressEn']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      phone: serializer.fromJson<String?>(json['phone']),
      website: serializer.fromJson<String?>(json['website']),
      rating: serializer.fromJson<double>(json['rating']),
      reviewCount: serializer.fromJson<int>(json['reviewCount']),
      priceLevel: serializer.fromJson<int>(json['priceLevel']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nameAr': serializer.toJson<String>(nameAr),
      'nameEn': serializer.toJson<String>(nameEn),
      'descriptionAr': serializer.toJson<String>(descriptionAr),
      'descriptionEn': serializer.toJson<String>(descriptionEn),
      'addressAr': serializer.toJson<String>(addressAr),
      'addressEn': serializer.toJson<String>(addressEn),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'phone': serializer.toJson<String?>(phone),
      'website': serializer.toJson<String?>(website),
      'rating': serializer.toJson<double>(rating),
      'reviewCount': serializer.toJson<int>(reviewCount),
      'priceLevel': serializer.toJson<int>(priceLevel),
      'isActive': serializer.toJson<bool>(isActive),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  PlacesTableData copyWith(
          {int? id,
          String? nameAr,
          String? nameEn,
          String? descriptionAr,
          String? descriptionEn,
          String? addressAr,
          String? addressEn,
          double? latitude,
          double? longitude,
          Value<String?> phone = const Value.absent(),
          Value<String?> website = const Value.absent(),
          double? rating,
          int? reviewCount,
          int? priceLevel,
          bool? isActive,
          String? updatedAt,
          String? createdAt}) =>
      PlacesTableData(
        id: id ?? this.id,
        nameAr: nameAr ?? this.nameAr,
        nameEn: nameEn ?? this.nameEn,
        descriptionAr: descriptionAr ?? this.descriptionAr,
        descriptionEn: descriptionEn ?? this.descriptionEn,
        addressAr: addressAr ?? this.addressAr,
        addressEn: addressEn ?? this.addressEn,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        phone: phone.present ? phone.value : this.phone,
        website: website.present ? website.value : this.website,
        rating: rating ?? this.rating,
        reviewCount: reviewCount ?? this.reviewCount,
        priceLevel: priceLevel ?? this.priceLevel,
        isActive: isActive ?? this.isActive,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
      );
  PlacesTableData copyWithCompanion(PlacesTableCompanion data) {
    return PlacesTableData(
      id: data.id.present ? data.id.value : this.id,
      nameAr: data.nameAr.present ? data.nameAr.value : this.nameAr,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      descriptionAr: data.descriptionAr.present
          ? data.descriptionAr.value
          : this.descriptionAr,
      descriptionEn: data.descriptionEn.present
          ? data.descriptionEn.value
          : this.descriptionEn,
      addressAr: data.addressAr.present ? data.addressAr.value : this.addressAr,
      addressEn: data.addressEn.present ? data.addressEn.value : this.addressEn,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      phone: data.phone.present ? data.phone.value : this.phone,
      website: data.website.present ? data.website.value : this.website,
      rating: data.rating.present ? data.rating.value : this.rating,
      reviewCount:
          data.reviewCount.present ? data.reviewCount.value : this.reviewCount,
      priceLevel:
          data.priceLevel.present ? data.priceLevel.value : this.priceLevel,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlacesTableData(')
          ..write('id: $id, ')
          ..write('nameAr: $nameAr, ')
          ..write('nameEn: $nameEn, ')
          ..write('descriptionAr: $descriptionAr, ')
          ..write('descriptionEn: $descriptionEn, ')
          ..write('addressAr: $addressAr, ')
          ..write('addressEn: $addressEn, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('phone: $phone, ')
          ..write('website: $website, ')
          ..write('rating: $rating, ')
          ..write('reviewCount: $reviewCount, ')
          ..write('priceLevel: $priceLevel, ')
          ..write('isActive: $isActive, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      nameAr,
      nameEn,
      descriptionAr,
      descriptionEn,
      addressAr,
      addressEn,
      latitude,
      longitude,
      phone,
      website,
      rating,
      reviewCount,
      priceLevel,
      isActive,
      updatedAt,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlacesTableData &&
          other.id == this.id &&
          other.nameAr == this.nameAr &&
          other.nameEn == this.nameEn &&
          other.descriptionAr == this.descriptionAr &&
          other.descriptionEn == this.descriptionEn &&
          other.addressAr == this.addressAr &&
          other.addressEn == this.addressEn &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.phone == this.phone &&
          other.website == this.website &&
          other.rating == this.rating &&
          other.reviewCount == this.reviewCount &&
          other.priceLevel == this.priceLevel &&
          other.isActive == this.isActive &&
          other.updatedAt == this.updatedAt &&
          other.createdAt == this.createdAt);
}

class PlacesTableCompanion extends UpdateCompanion<PlacesTableData> {
  final Value<int> id;
  final Value<String> nameAr;
  final Value<String> nameEn;
  final Value<String> descriptionAr;
  final Value<String> descriptionEn;
  final Value<String> addressAr;
  final Value<String> addressEn;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<String?> phone;
  final Value<String?> website;
  final Value<double> rating;
  final Value<int> reviewCount;
  final Value<int> priceLevel;
  final Value<bool> isActive;
  final Value<String> updatedAt;
  final Value<String> createdAt;
  const PlacesTableCompanion({
    this.id = const Value.absent(),
    this.nameAr = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.descriptionAr = const Value.absent(),
    this.descriptionEn = const Value.absent(),
    this.addressAr = const Value.absent(),
    this.addressEn = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.phone = const Value.absent(),
    this.website = const Value.absent(),
    this.rating = const Value.absent(),
    this.reviewCount = const Value.absent(),
    this.priceLevel = const Value.absent(),
    this.isActive = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PlacesTableCompanion.insert({
    this.id = const Value.absent(),
    required String nameAr,
    required String nameEn,
    this.descriptionAr = const Value.absent(),
    this.descriptionEn = const Value.absent(),
    this.addressAr = const Value.absent(),
    this.addressEn = const Value.absent(),
    required double latitude,
    required double longitude,
    this.phone = const Value.absent(),
    this.website = const Value.absent(),
    this.rating = const Value.absent(),
    this.reviewCount = const Value.absent(),
    this.priceLevel = const Value.absent(),
    this.isActive = const Value.absent(),
    required String updatedAt,
    required String createdAt,
  })  : nameAr = Value(nameAr),
        nameEn = Value(nameEn),
        latitude = Value(latitude),
        longitude = Value(longitude),
        updatedAt = Value(updatedAt),
        createdAt = Value(createdAt);
  static Insertable<PlacesTableData> custom({
    Expression<int>? id,
    Expression<String>? nameAr,
    Expression<String>? nameEn,
    Expression<String>? descriptionAr,
    Expression<String>? descriptionEn,
    Expression<String>? addressAr,
    Expression<String>? addressEn,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? phone,
    Expression<String>? website,
    Expression<double>? rating,
    Expression<int>? reviewCount,
    Expression<int>? priceLevel,
    Expression<bool>? isActive,
    Expression<String>? updatedAt,
    Expression<String>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameAr != null) 'name_ar': nameAr,
      if (nameEn != null) 'name_en': nameEn,
      if (descriptionAr != null) 'description_ar': descriptionAr,
      if (descriptionEn != null) 'description_en': descriptionEn,
      if (addressAr != null) 'address_ar': addressAr,
      if (addressEn != null) 'address_en': addressEn,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (phone != null) 'phone': phone,
      if (website != null) 'website': website,
      if (rating != null) 'rating': rating,
      if (reviewCount != null) 'review_count': reviewCount,
      if (priceLevel != null) 'price_level': priceLevel,
      if (isActive != null) 'is_active': isActive,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PlacesTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? nameAr,
      Value<String>? nameEn,
      Value<String>? descriptionAr,
      Value<String>? descriptionEn,
      Value<String>? addressAr,
      Value<String>? addressEn,
      Value<double>? latitude,
      Value<double>? longitude,
      Value<String?>? phone,
      Value<String?>? website,
      Value<double>? rating,
      Value<int>? reviewCount,
      Value<int>? priceLevel,
      Value<bool>? isActive,
      Value<String>? updatedAt,
      Value<String>? createdAt}) {
    return PlacesTableCompanion(
      id: id ?? this.id,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      addressAr: addressAr ?? this.addressAr,
      addressEn: addressEn ?? this.addressEn,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      phone: phone ?? this.phone,
      website: website ?? this.website,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      priceLevel: priceLevel ?? this.priceLevel,
      isActive: isActive ?? this.isActive,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nameAr.present) {
      map['name_ar'] = Variable<String>(nameAr.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (descriptionAr.present) {
      map['description_ar'] = Variable<String>(descriptionAr.value);
    }
    if (descriptionEn.present) {
      map['description_en'] = Variable<String>(descriptionEn.value);
    }
    if (addressAr.present) {
      map['address_ar'] = Variable<String>(addressAr.value);
    }
    if (addressEn.present) {
      map['address_en'] = Variable<String>(addressEn.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (website.present) {
      map['website'] = Variable<String>(website.value);
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    if (reviewCount.present) {
      map['review_count'] = Variable<int>(reviewCount.value);
    }
    if (priceLevel.present) {
      map['price_level'] = Variable<int>(priceLevel.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlacesTableCompanion(')
          ..write('id: $id, ')
          ..write('nameAr: $nameAr, ')
          ..write('nameEn: $nameEn, ')
          ..write('descriptionAr: $descriptionAr, ')
          ..write('descriptionEn: $descriptionEn, ')
          ..write('addressAr: $addressAr, ')
          ..write('addressEn: $addressEn, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('phone: $phone, ')
          ..write('website: $website, ')
          ..write('rating: $rating, ')
          ..write('reviewCount: $reviewCount, ')
          ..write('priceLevel: $priceLevel, ')
          ..write('isActive: $isActive, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTableTable extends CategoriesTable
    with TableInfo<$CategoriesTableTable, CategoriesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameArMeta = const VerificationMeta('nameAr');
  @override
  late final GeneratedColumn<String> nameAr = GeneratedColumn<String>(
      'name_ar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
      'name_en', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, nameAr, nameEn, icon, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
      Insertable<CategoriesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name_ar')) {
      context.handle(_nameArMeta,
          nameAr.isAcceptableOrUnknown(data['name_ar']!, _nameArMeta));
    } else if (isInserting) {
      context.missing(_nameArMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(_nameEnMeta,
          nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta));
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoriesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoriesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nameAr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_ar'])!,
      nameEn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_en'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $CategoriesTableTable createAlias(String alias) {
    return $CategoriesTableTable(attachedDatabase, alias);
  }
}

class CategoriesTableData extends DataClass
    implements Insertable<CategoriesTableData> {
  final int id;
  final String nameAr;
  final String nameEn;
  final String? icon;
  final String updatedAt;
  const CategoriesTableData(
      {required this.id,
      required this.nameAr,
      required this.nameEn,
      this.icon,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name_ar'] = Variable<String>(nameAr);
    map['name_en'] = Variable<String>(nameEn);
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  CategoriesTableCompanion toCompanion(bool nullToAbsent) {
    return CategoriesTableCompanion(
      id: Value(id),
      nameAr: Value(nameAr),
      nameEn: Value(nameEn),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      updatedAt: Value(updatedAt),
    );
  }

  factory CategoriesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoriesTableData(
      id: serializer.fromJson<int>(json['id']),
      nameAr: serializer.fromJson<String>(json['nameAr']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      icon: serializer.fromJson<String?>(json['icon']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nameAr': serializer.toJson<String>(nameAr),
      'nameEn': serializer.toJson<String>(nameEn),
      'icon': serializer.toJson<String?>(icon),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  CategoriesTableData copyWith(
          {int? id,
          String? nameAr,
          String? nameEn,
          Value<String?> icon = const Value.absent(),
          String? updatedAt}) =>
      CategoriesTableData(
        id: id ?? this.id,
        nameAr: nameAr ?? this.nameAr,
        nameEn: nameEn ?? this.nameEn,
        icon: icon.present ? icon.value : this.icon,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  CategoriesTableData copyWithCompanion(CategoriesTableCompanion data) {
    return CategoriesTableData(
      id: data.id.present ? data.id.value : this.id,
      nameAr: data.nameAr.present ? data.nameAr.value : this.nameAr,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      icon: data.icon.present ? data.icon.value : this.icon,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesTableData(')
          ..write('id: $id, ')
          ..write('nameAr: $nameAr, ')
          ..write('nameEn: $nameEn, ')
          ..write('icon: $icon, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nameAr, nameEn, icon, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoriesTableData &&
          other.id == this.id &&
          other.nameAr == this.nameAr &&
          other.nameEn == this.nameEn &&
          other.icon == this.icon &&
          other.updatedAt == this.updatedAt);
}

class CategoriesTableCompanion extends UpdateCompanion<CategoriesTableData> {
  final Value<int> id;
  final Value<String> nameAr;
  final Value<String> nameEn;
  final Value<String?> icon;
  final Value<String> updatedAt;
  const CategoriesTableCompanion({
    this.id = const Value.absent(),
    this.nameAr = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.icon = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CategoriesTableCompanion.insert({
    this.id = const Value.absent(),
    required String nameAr,
    required String nameEn,
    this.icon = const Value.absent(),
    required String updatedAt,
  })  : nameAr = Value(nameAr),
        nameEn = Value(nameEn),
        updatedAt = Value(updatedAt);
  static Insertable<CategoriesTableData> custom({
    Expression<int>? id,
    Expression<String>? nameAr,
    Expression<String>? nameEn,
    Expression<String>? icon,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameAr != null) 'name_ar': nameAr,
      if (nameEn != null) 'name_en': nameEn,
      if (icon != null) 'icon': icon,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CategoriesTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? nameAr,
      Value<String>? nameEn,
      Value<String?>? icon,
      Value<String>? updatedAt}) {
    return CategoriesTableCompanion(
      id: id ?? this.id,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
      icon: icon ?? this.icon,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nameAr.present) {
      map['name_ar'] = Variable<String>(nameAr.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesTableCompanion(')
          ..write('id: $id, ')
          ..write('nameAr: $nameAr, ')
          ..write('nameEn: $nameEn, ')
          ..write('icon: $icon, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PlaceCategoriesTableTable extends PlaceCategoriesTable
    with TableInfo<$PlaceCategoriesTableTable, PlaceCategoriesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaceCategoriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _placeIdMeta =
      const VerificationMeta('placeId');
  @override
  late final GeneratedColumn<int> placeId = GeneratedColumn<int>(
      'place_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES places (id)'));
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES categories (id)'));
  @override
  List<GeneratedColumn> get $columns => [placeId, categoryId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'place_categories';
  @override
  VerificationContext validateIntegrity(
      Insertable<PlaceCategoriesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('place_id')) {
      context.handle(_placeIdMeta,
          placeId.isAcceptableOrUnknown(data['place_id']!, _placeIdMeta));
    } else if (isInserting) {
      context.missing(_placeIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {placeId, categoryId};
  @override
  PlaceCategoriesTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaceCategoriesTableData(
      placeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}place_id'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id'])!,
    );
  }

  @override
  $PlaceCategoriesTableTable createAlias(String alias) {
    return $PlaceCategoriesTableTable(attachedDatabase, alias);
  }
}

class PlaceCategoriesTableData extends DataClass
    implements Insertable<PlaceCategoriesTableData> {
  final int placeId;
  final int categoryId;
  const PlaceCategoriesTableData(
      {required this.placeId, required this.categoryId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['place_id'] = Variable<int>(placeId);
    map['category_id'] = Variable<int>(categoryId);
    return map;
  }

  PlaceCategoriesTableCompanion toCompanion(bool nullToAbsent) {
    return PlaceCategoriesTableCompanion(
      placeId: Value(placeId),
      categoryId: Value(categoryId),
    );
  }

  factory PlaceCategoriesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaceCategoriesTableData(
      placeId: serializer.fromJson<int>(json['placeId']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'placeId': serializer.toJson<int>(placeId),
      'categoryId': serializer.toJson<int>(categoryId),
    };
  }

  PlaceCategoriesTableData copyWith({int? placeId, int? categoryId}) =>
      PlaceCategoriesTableData(
        placeId: placeId ?? this.placeId,
        categoryId: categoryId ?? this.categoryId,
      );
  PlaceCategoriesTableData copyWithCompanion(
      PlaceCategoriesTableCompanion data) {
    return PlaceCategoriesTableData(
      placeId: data.placeId.present ? data.placeId.value : this.placeId,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlaceCategoriesTableData(')
          ..write('placeId: $placeId, ')
          ..write('categoryId: $categoryId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(placeId, categoryId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaceCategoriesTableData &&
          other.placeId == this.placeId &&
          other.categoryId == this.categoryId);
}

class PlaceCategoriesTableCompanion
    extends UpdateCompanion<PlaceCategoriesTableData> {
  final Value<int> placeId;
  final Value<int> categoryId;
  final Value<int> rowid;
  const PlaceCategoriesTableCompanion({
    this.placeId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlaceCategoriesTableCompanion.insert({
    required int placeId,
    required int categoryId,
    this.rowid = const Value.absent(),
  })  : placeId = Value(placeId),
        categoryId = Value(categoryId);
  static Insertable<PlaceCategoriesTableData> custom({
    Expression<int>? placeId,
    Expression<int>? categoryId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (placeId != null) 'place_id': placeId,
      if (categoryId != null) 'category_id': categoryId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlaceCategoriesTableCompanion copyWith(
      {Value<int>? placeId, Value<int>? categoryId, Value<int>? rowid}) {
    return PlaceCategoriesTableCompanion(
      placeId: placeId ?? this.placeId,
      categoryId: categoryId ?? this.categoryId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (placeId.present) {
      map['place_id'] = Variable<int>(placeId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaceCategoriesTableCompanion(')
          ..write('placeId: $placeId, ')
          ..write('categoryId: $categoryId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkingHoursTableTable extends WorkingHoursTable
    with TableInfo<$WorkingHoursTableTable, WorkingHoursTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkingHoursTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _placeIdMeta =
      const VerificationMeta('placeId');
  @override
  late final GeneratedColumn<int> placeId = GeneratedColumn<int>(
      'place_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES places (id)'));
  static const VerificationMeta _dayOfWeekMeta =
      const VerificationMeta('dayOfWeek');
  @override
  late final GeneratedColumn<int> dayOfWeek = GeneratedColumn<int>(
      'day_of_week', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _openTimeMeta =
      const VerificationMeta('openTime');
  @override
  late final GeneratedColumn<String> openTime = GeneratedColumn<String>(
      'open_time', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('00:00'));
  static const VerificationMeta _closeTimeMeta =
      const VerificationMeta('closeTime');
  @override
  late final GeneratedColumn<String> closeTime = GeneratedColumn<String>(
      'close_time', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('00:00'));
  static const VerificationMeta _isClosedMeta =
      const VerificationMeta('isClosed');
  @override
  late final GeneratedColumn<bool> isClosed = GeneratedColumn<bool>(
      'is_closed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_closed" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, placeId, dayOfWeek, openTime, closeTime, isClosed];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'working_hours';
  @override
  VerificationContext validateIntegrity(
      Insertable<WorkingHoursTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('place_id')) {
      context.handle(_placeIdMeta,
          placeId.isAcceptableOrUnknown(data['place_id']!, _placeIdMeta));
    } else if (isInserting) {
      context.missing(_placeIdMeta);
    }
    if (data.containsKey('day_of_week')) {
      context.handle(
          _dayOfWeekMeta,
          dayOfWeek.isAcceptableOrUnknown(
              data['day_of_week']!, _dayOfWeekMeta));
    } else if (isInserting) {
      context.missing(_dayOfWeekMeta);
    }
    if (data.containsKey('open_time')) {
      context.handle(_openTimeMeta,
          openTime.isAcceptableOrUnknown(data['open_time']!, _openTimeMeta));
    }
    if (data.containsKey('close_time')) {
      context.handle(_closeTimeMeta,
          closeTime.isAcceptableOrUnknown(data['close_time']!, _closeTimeMeta));
    }
    if (data.containsKey('is_closed')) {
      context.handle(_isClosedMeta,
          isClosed.isAcceptableOrUnknown(data['is_closed']!, _isClosedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkingHoursTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkingHoursTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      placeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}place_id'])!,
      dayOfWeek: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}day_of_week'])!,
      openTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}open_time'])!,
      closeTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}close_time'])!,
      isClosed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_closed'])!,
    );
  }

  @override
  $WorkingHoursTableTable createAlias(String alias) {
    return $WorkingHoursTableTable(attachedDatabase, alias);
  }
}

class WorkingHoursTableData extends DataClass
    implements Insertable<WorkingHoursTableData> {
  final int id;
  final int placeId;
  final int dayOfWeek;
  final String openTime;
  final String closeTime;
  final bool isClosed;
  const WorkingHoursTableData(
      {required this.id,
      required this.placeId,
      required this.dayOfWeek,
      required this.openTime,
      required this.closeTime,
      required this.isClosed});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['place_id'] = Variable<int>(placeId);
    map['day_of_week'] = Variable<int>(dayOfWeek);
    map['open_time'] = Variable<String>(openTime);
    map['close_time'] = Variable<String>(closeTime);
    map['is_closed'] = Variable<bool>(isClosed);
    return map;
  }

  WorkingHoursTableCompanion toCompanion(bool nullToAbsent) {
    return WorkingHoursTableCompanion(
      id: Value(id),
      placeId: Value(placeId),
      dayOfWeek: Value(dayOfWeek),
      openTime: Value(openTime),
      closeTime: Value(closeTime),
      isClosed: Value(isClosed),
    );
  }

  factory WorkingHoursTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkingHoursTableData(
      id: serializer.fromJson<int>(json['id']),
      placeId: serializer.fromJson<int>(json['placeId']),
      dayOfWeek: serializer.fromJson<int>(json['dayOfWeek']),
      openTime: serializer.fromJson<String>(json['openTime']),
      closeTime: serializer.fromJson<String>(json['closeTime']),
      isClosed: serializer.fromJson<bool>(json['isClosed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'placeId': serializer.toJson<int>(placeId),
      'dayOfWeek': serializer.toJson<int>(dayOfWeek),
      'openTime': serializer.toJson<String>(openTime),
      'closeTime': serializer.toJson<String>(closeTime),
      'isClosed': serializer.toJson<bool>(isClosed),
    };
  }

  WorkingHoursTableData copyWith(
          {int? id,
          int? placeId,
          int? dayOfWeek,
          String? openTime,
          String? closeTime,
          bool? isClosed}) =>
      WorkingHoursTableData(
        id: id ?? this.id,
        placeId: placeId ?? this.placeId,
        dayOfWeek: dayOfWeek ?? this.dayOfWeek,
        openTime: openTime ?? this.openTime,
        closeTime: closeTime ?? this.closeTime,
        isClosed: isClosed ?? this.isClosed,
      );
  WorkingHoursTableData copyWithCompanion(WorkingHoursTableCompanion data) {
    return WorkingHoursTableData(
      id: data.id.present ? data.id.value : this.id,
      placeId: data.placeId.present ? data.placeId.value : this.placeId,
      dayOfWeek: data.dayOfWeek.present ? data.dayOfWeek.value : this.dayOfWeek,
      openTime: data.openTime.present ? data.openTime.value : this.openTime,
      closeTime: data.closeTime.present ? data.closeTime.value : this.closeTime,
      isClosed: data.isClosed.present ? data.isClosed.value : this.isClosed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkingHoursTableData(')
          ..write('id: $id, ')
          ..write('placeId: $placeId, ')
          ..write('dayOfWeek: $dayOfWeek, ')
          ..write('openTime: $openTime, ')
          ..write('closeTime: $closeTime, ')
          ..write('isClosed: $isClosed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, placeId, dayOfWeek, openTime, closeTime, isClosed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkingHoursTableData &&
          other.id == this.id &&
          other.placeId == this.placeId &&
          other.dayOfWeek == this.dayOfWeek &&
          other.openTime == this.openTime &&
          other.closeTime == this.closeTime &&
          other.isClosed == this.isClosed);
}

class WorkingHoursTableCompanion
    extends UpdateCompanion<WorkingHoursTableData> {
  final Value<int> id;
  final Value<int> placeId;
  final Value<int> dayOfWeek;
  final Value<String> openTime;
  final Value<String> closeTime;
  final Value<bool> isClosed;
  const WorkingHoursTableCompanion({
    this.id = const Value.absent(),
    this.placeId = const Value.absent(),
    this.dayOfWeek = const Value.absent(),
    this.openTime = const Value.absent(),
    this.closeTime = const Value.absent(),
    this.isClosed = const Value.absent(),
  });
  WorkingHoursTableCompanion.insert({
    this.id = const Value.absent(),
    required int placeId,
    required int dayOfWeek,
    this.openTime = const Value.absent(),
    this.closeTime = const Value.absent(),
    this.isClosed = const Value.absent(),
  })  : placeId = Value(placeId),
        dayOfWeek = Value(dayOfWeek);
  static Insertable<WorkingHoursTableData> custom({
    Expression<int>? id,
    Expression<int>? placeId,
    Expression<int>? dayOfWeek,
    Expression<String>? openTime,
    Expression<String>? closeTime,
    Expression<bool>? isClosed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (placeId != null) 'place_id': placeId,
      if (dayOfWeek != null) 'day_of_week': dayOfWeek,
      if (openTime != null) 'open_time': openTime,
      if (closeTime != null) 'close_time': closeTime,
      if (isClosed != null) 'is_closed': isClosed,
    });
  }

  WorkingHoursTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? placeId,
      Value<int>? dayOfWeek,
      Value<String>? openTime,
      Value<String>? closeTime,
      Value<bool>? isClosed}) {
    return WorkingHoursTableCompanion(
      id: id ?? this.id,
      placeId: placeId ?? this.placeId,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      openTime: openTime ?? this.openTime,
      closeTime: closeTime ?? this.closeTime,
      isClosed: isClosed ?? this.isClosed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (placeId.present) {
      map['place_id'] = Variable<int>(placeId.value);
    }
    if (dayOfWeek.present) {
      map['day_of_week'] = Variable<int>(dayOfWeek.value);
    }
    if (openTime.present) {
      map['open_time'] = Variable<String>(openTime.value);
    }
    if (closeTime.present) {
      map['close_time'] = Variable<String>(closeTime.value);
    }
    if (isClosed.present) {
      map['is_closed'] = Variable<bool>(isClosed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkingHoursTableCompanion(')
          ..write('id: $id, ')
          ..write('placeId: $placeId, ')
          ..write('dayOfWeek: $dayOfWeek, ')
          ..write('openTime: $openTime, ')
          ..write('closeTime: $closeTime, ')
          ..write('isClosed: $isClosed')
          ..write(')'))
        .toString();
  }
}

class $PlaceImagesTableTable extends PlaceImagesTable
    with TableInfo<$PlaceImagesTableTable, PlaceImagesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaceImagesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _placeIdMeta =
      const VerificationMeta('placeId');
  @override
  late final GeneratedColumn<int> placeId = GeneratedColumn<int>(
      'place_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES places (id)'));
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isPrimaryMeta =
      const VerificationMeta('isPrimary');
  @override
  late final GeneratedColumn<bool> isPrimary = GeneratedColumn<bool>(
      'is_primary', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_primary" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, placeId, url, isPrimary, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'place_images';
  @override
  VerificationContext validateIntegrity(
      Insertable<PlaceImagesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('place_id')) {
      context.handle(_placeIdMeta,
          placeId.isAcceptableOrUnknown(data['place_id']!, _placeIdMeta));
    } else if (isInserting) {
      context.missing(_placeIdMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('is_primary')) {
      context.handle(_isPrimaryMeta,
          isPrimary.isAcceptableOrUnknown(data['is_primary']!, _isPrimaryMeta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlaceImagesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaceImagesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      placeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}place_id'])!,
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url'])!,
      isPrimary: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_primary'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
    );
  }

  @override
  $PlaceImagesTableTable createAlias(String alias) {
    return $PlaceImagesTableTable(attachedDatabase, alias);
  }
}

class PlaceImagesTableData extends DataClass
    implements Insertable<PlaceImagesTableData> {
  final int id;
  final int placeId;
  final String url;
  final bool isPrimary;
  final int sortOrder;
  const PlaceImagesTableData(
      {required this.id,
      required this.placeId,
      required this.url,
      required this.isPrimary,
      required this.sortOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['place_id'] = Variable<int>(placeId);
    map['url'] = Variable<String>(url);
    map['is_primary'] = Variable<bool>(isPrimary);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  PlaceImagesTableCompanion toCompanion(bool nullToAbsent) {
    return PlaceImagesTableCompanion(
      id: Value(id),
      placeId: Value(placeId),
      url: Value(url),
      isPrimary: Value(isPrimary),
      sortOrder: Value(sortOrder),
    );
  }

  factory PlaceImagesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaceImagesTableData(
      id: serializer.fromJson<int>(json['id']),
      placeId: serializer.fromJson<int>(json['placeId']),
      url: serializer.fromJson<String>(json['url']),
      isPrimary: serializer.fromJson<bool>(json['isPrimary']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'placeId': serializer.toJson<int>(placeId),
      'url': serializer.toJson<String>(url),
      'isPrimary': serializer.toJson<bool>(isPrimary),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  PlaceImagesTableData copyWith(
          {int? id,
          int? placeId,
          String? url,
          bool? isPrimary,
          int? sortOrder}) =>
      PlaceImagesTableData(
        id: id ?? this.id,
        placeId: placeId ?? this.placeId,
        url: url ?? this.url,
        isPrimary: isPrimary ?? this.isPrimary,
        sortOrder: sortOrder ?? this.sortOrder,
      );
  PlaceImagesTableData copyWithCompanion(PlaceImagesTableCompanion data) {
    return PlaceImagesTableData(
      id: data.id.present ? data.id.value : this.id,
      placeId: data.placeId.present ? data.placeId.value : this.placeId,
      url: data.url.present ? data.url.value : this.url,
      isPrimary: data.isPrimary.present ? data.isPrimary.value : this.isPrimary,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlaceImagesTableData(')
          ..write('id: $id, ')
          ..write('placeId: $placeId, ')
          ..write('url: $url, ')
          ..write('isPrimary: $isPrimary, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, placeId, url, isPrimary, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaceImagesTableData &&
          other.id == this.id &&
          other.placeId == this.placeId &&
          other.url == this.url &&
          other.isPrimary == this.isPrimary &&
          other.sortOrder == this.sortOrder);
}

class PlaceImagesTableCompanion extends UpdateCompanion<PlaceImagesTableData> {
  final Value<int> id;
  final Value<int> placeId;
  final Value<String> url;
  final Value<bool> isPrimary;
  final Value<int> sortOrder;
  const PlaceImagesTableCompanion({
    this.id = const Value.absent(),
    this.placeId = const Value.absent(),
    this.url = const Value.absent(),
    this.isPrimary = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  PlaceImagesTableCompanion.insert({
    this.id = const Value.absent(),
    required int placeId,
    required String url,
    this.isPrimary = const Value.absent(),
    this.sortOrder = const Value.absent(),
  })  : placeId = Value(placeId),
        url = Value(url);
  static Insertable<PlaceImagesTableData> custom({
    Expression<int>? id,
    Expression<int>? placeId,
    Expression<String>? url,
    Expression<bool>? isPrimary,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (placeId != null) 'place_id': placeId,
      if (url != null) 'url': url,
      if (isPrimary != null) 'is_primary': isPrimary,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  PlaceImagesTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? placeId,
      Value<String>? url,
      Value<bool>? isPrimary,
      Value<int>? sortOrder}) {
    return PlaceImagesTableCompanion(
      id: id ?? this.id,
      placeId: placeId ?? this.placeId,
      url: url ?? this.url,
      isPrimary: isPrimary ?? this.isPrimary,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (placeId.present) {
      map['place_id'] = Variable<int>(placeId.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (isPrimary.present) {
      map['is_primary'] = Variable<bool>(isPrimary.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaceImagesTableCompanion(')
          ..write('id: $id, ')
          ..write('placeId: $placeId, ')
          ..write('url: $url, ')
          ..write('isPrimary: $isPrimary, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $SocialLinksTableTable extends SocialLinksTable
    with TableInfo<$SocialLinksTableTable, SocialLinksTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SocialLinksTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _placeIdMeta =
      const VerificationMeta('placeId');
  @override
  late final GeneratedColumn<int> placeId = GeneratedColumn<int>(
      'place_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES places (id)'));
  static const VerificationMeta _platformMeta =
      const VerificationMeta('platform');
  @override
  late final GeneratedColumn<String> platform = GeneratedColumn<String>(
      'platform', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, placeId, platform, url];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'social_links';
  @override
  VerificationContext validateIntegrity(
      Insertable<SocialLinksTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('place_id')) {
      context.handle(_placeIdMeta,
          placeId.isAcceptableOrUnknown(data['place_id']!, _placeIdMeta));
    } else if (isInserting) {
      context.missing(_placeIdMeta);
    }
    if (data.containsKey('platform')) {
      context.handle(_platformMeta,
          platform.isAcceptableOrUnknown(data['platform']!, _platformMeta));
    } else if (isInserting) {
      context.missing(_platformMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SocialLinksTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SocialLinksTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      placeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}place_id'])!,
      platform: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}platform'])!,
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url'])!,
    );
  }

  @override
  $SocialLinksTableTable createAlias(String alias) {
    return $SocialLinksTableTable(attachedDatabase, alias);
  }
}

class SocialLinksTableData extends DataClass
    implements Insertable<SocialLinksTableData> {
  final int id;
  final int placeId;
  final String platform;
  final String url;
  const SocialLinksTableData(
      {required this.id,
      required this.placeId,
      required this.platform,
      required this.url});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['place_id'] = Variable<int>(placeId);
    map['platform'] = Variable<String>(platform);
    map['url'] = Variable<String>(url);
    return map;
  }

  SocialLinksTableCompanion toCompanion(bool nullToAbsent) {
    return SocialLinksTableCompanion(
      id: Value(id),
      placeId: Value(placeId),
      platform: Value(platform),
      url: Value(url),
    );
  }

  factory SocialLinksTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SocialLinksTableData(
      id: serializer.fromJson<int>(json['id']),
      placeId: serializer.fromJson<int>(json['placeId']),
      platform: serializer.fromJson<String>(json['platform']),
      url: serializer.fromJson<String>(json['url']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'placeId': serializer.toJson<int>(placeId),
      'platform': serializer.toJson<String>(platform),
      'url': serializer.toJson<String>(url),
    };
  }

  SocialLinksTableData copyWith(
          {int? id, int? placeId, String? platform, String? url}) =>
      SocialLinksTableData(
        id: id ?? this.id,
        placeId: placeId ?? this.placeId,
        platform: platform ?? this.platform,
        url: url ?? this.url,
      );
  SocialLinksTableData copyWithCompanion(SocialLinksTableCompanion data) {
    return SocialLinksTableData(
      id: data.id.present ? data.id.value : this.id,
      placeId: data.placeId.present ? data.placeId.value : this.placeId,
      platform: data.platform.present ? data.platform.value : this.platform,
      url: data.url.present ? data.url.value : this.url,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SocialLinksTableData(')
          ..write('id: $id, ')
          ..write('placeId: $placeId, ')
          ..write('platform: $platform, ')
          ..write('url: $url')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, placeId, platform, url);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SocialLinksTableData &&
          other.id == this.id &&
          other.placeId == this.placeId &&
          other.platform == this.platform &&
          other.url == this.url);
}

class SocialLinksTableCompanion extends UpdateCompanion<SocialLinksTableData> {
  final Value<int> id;
  final Value<int> placeId;
  final Value<String> platform;
  final Value<String> url;
  const SocialLinksTableCompanion({
    this.id = const Value.absent(),
    this.placeId = const Value.absent(),
    this.platform = const Value.absent(),
    this.url = const Value.absent(),
  });
  SocialLinksTableCompanion.insert({
    this.id = const Value.absent(),
    required int placeId,
    required String platform,
    required String url,
  })  : placeId = Value(placeId),
        platform = Value(platform),
        url = Value(url);
  static Insertable<SocialLinksTableData> custom({
    Expression<int>? id,
    Expression<int>? placeId,
    Expression<String>? platform,
    Expression<String>? url,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (placeId != null) 'place_id': placeId,
      if (platform != null) 'platform': platform,
      if (url != null) 'url': url,
    });
  }

  SocialLinksTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? placeId,
      Value<String>? platform,
      Value<String>? url}) {
    return SocialLinksTableCompanion(
      id: id ?? this.id,
      placeId: placeId ?? this.placeId,
      platform: platform ?? this.platform,
      url: url ?? this.url,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (placeId.present) {
      map['place_id'] = Variable<int>(placeId.value);
    }
    if (platform.present) {
      map['platform'] = Variable<String>(platform.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SocialLinksTableCompanion(')
          ..write('id: $id, ')
          ..write('placeId: $placeId, ')
          ..write('platform: $platform, ')
          ..write('url: $url')
          ..write(')'))
        .toString();
  }
}

class $UserFavoritesTableTable extends UserFavoritesTable
    with TableInfo<$UserFavoritesTableTable, UserFavoritesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserFavoritesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _placeIdMeta =
      const VerificationMeta('placeId');
  @override
  late final GeneratedColumn<int> placeId = GeneratedColumn<int>(
      'place_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES places (id)'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, userId, placeId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_favorites';
  @override
  VerificationContext validateIntegrity(
      Insertable<UserFavoritesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('place_id')) {
      context.handle(_placeIdMeta,
          placeId.isAcceptableOrUnknown(data['place_id']!, _placeIdMeta));
    } else if (isInserting) {
      context.missing(_placeIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserFavoritesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserFavoritesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      placeId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}place_id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $UserFavoritesTableTable createAlias(String alias) {
    return $UserFavoritesTableTable(attachedDatabase, alias);
  }
}

class UserFavoritesTableData extends DataClass
    implements Insertable<UserFavoritesTableData> {
  final int id;
  final String userId;
  final int placeId;
  final String createdAt;
  const UserFavoritesTableData(
      {required this.id,
      required this.userId,
      required this.placeId,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['place_id'] = Variable<int>(placeId);
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  UserFavoritesTableCompanion toCompanion(bool nullToAbsent) {
    return UserFavoritesTableCompanion(
      id: Value(id),
      userId: Value(userId),
      placeId: Value(placeId),
      createdAt: Value(createdAt),
    );
  }

  factory UserFavoritesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserFavoritesTableData(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      placeId: serializer.fromJson<int>(json['placeId']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'placeId': serializer.toJson<int>(placeId),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  UserFavoritesTableData copyWith(
          {int? id, String? userId, int? placeId, String? createdAt}) =>
      UserFavoritesTableData(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        placeId: placeId ?? this.placeId,
        createdAt: createdAt ?? this.createdAt,
      );
  UserFavoritesTableData copyWithCompanion(UserFavoritesTableCompanion data) {
    return UserFavoritesTableData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      placeId: data.placeId.present ? data.placeId.value : this.placeId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserFavoritesTableData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('placeId: $placeId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, placeId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserFavoritesTableData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.placeId == this.placeId &&
          other.createdAt == this.createdAt);
}

class UserFavoritesTableCompanion
    extends UpdateCompanion<UserFavoritesTableData> {
  final Value<int> id;
  final Value<String> userId;
  final Value<int> placeId;
  final Value<String> createdAt;
  const UserFavoritesTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.placeId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  UserFavoritesTableCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required int placeId,
    required String createdAt,
  })  : userId = Value(userId),
        placeId = Value(placeId),
        createdAt = Value(createdAt);
  static Insertable<UserFavoritesTableData> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<int>? placeId,
    Expression<String>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (placeId != null) 'place_id': placeId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  UserFavoritesTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? userId,
      Value<int>? placeId,
      Value<String>? createdAt}) {
    return UserFavoritesTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      placeId: placeId ?? this.placeId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (placeId.present) {
      map['place_id'] = Variable<int>(placeId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserFavoritesTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('placeId: $placeId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ChatSessionsTableTable extends ChatSessionsTable
    with TableInfo<$ChatSessionsTableTable, ChatSessionsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatSessionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _startedAtMeta =
      const VerificationMeta('startedAt');
  @override
  late final GeneratedColumn<String> startedAt = GeneratedColumn<String>(
      'started_at', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _languageMeta =
      const VerificationMeta('language');
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
      'language', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('en'));
  @override
  List<GeneratedColumn> get $columns => [id, userId, startedAt, language];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_sessions';
  @override
  VerificationContext validateIntegrity(
      Insertable<ChatSessionsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('started_at')) {
      context.handle(_startedAtMeta,
          startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta));
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('language')) {
      context.handle(_languageMeta,
          language.isAcceptableOrUnknown(data['language']!, _languageMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatSessionsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatSessionsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id']),
      startedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}started_at'])!,
      language: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language'])!,
    );
  }

  @override
  $ChatSessionsTableTable createAlias(String alias) {
    return $ChatSessionsTableTable(attachedDatabase, alias);
  }
}

class ChatSessionsTableData extends DataClass
    implements Insertable<ChatSessionsTableData> {
  final int id;
  final String? userId;
  final String startedAt;
  final String language;
  const ChatSessionsTableData(
      {required this.id,
      this.userId,
      required this.startedAt,
      required this.language});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['started_at'] = Variable<String>(startedAt);
    map['language'] = Variable<String>(language);
    return map;
  }

  ChatSessionsTableCompanion toCompanion(bool nullToAbsent) {
    return ChatSessionsTableCompanion(
      id: Value(id),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      startedAt: Value(startedAt),
      language: Value(language),
    );
  }

  factory ChatSessionsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatSessionsTableData(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String?>(json['userId']),
      startedAt: serializer.fromJson<String>(json['startedAt']),
      language: serializer.fromJson<String>(json['language']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String?>(userId),
      'startedAt': serializer.toJson<String>(startedAt),
      'language': serializer.toJson<String>(language),
    };
  }

  ChatSessionsTableData copyWith(
          {int? id,
          Value<String?> userId = const Value.absent(),
          String? startedAt,
          String? language}) =>
      ChatSessionsTableData(
        id: id ?? this.id,
        userId: userId.present ? userId.value : this.userId,
        startedAt: startedAt ?? this.startedAt,
        language: language ?? this.language,
      );
  ChatSessionsTableData copyWithCompanion(ChatSessionsTableCompanion data) {
    return ChatSessionsTableData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      language: data.language.present ? data.language.value : this.language,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatSessionsTableData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('startedAt: $startedAt, ')
          ..write('language: $language')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, startedAt, language);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatSessionsTableData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.startedAt == this.startedAt &&
          other.language == this.language);
}

class ChatSessionsTableCompanion
    extends UpdateCompanion<ChatSessionsTableData> {
  final Value<int> id;
  final Value<String?> userId;
  final Value<String> startedAt;
  final Value<String> language;
  const ChatSessionsTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.language = const Value.absent(),
  });
  ChatSessionsTableCompanion.insert({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    required String startedAt,
    this.language = const Value.absent(),
  }) : startedAt = Value(startedAt);
  static Insertable<ChatSessionsTableData> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? startedAt,
    Expression<String>? language,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (startedAt != null) 'started_at': startedAt,
      if (language != null) 'language': language,
    });
  }

  ChatSessionsTableCompanion copyWith(
      {Value<int>? id,
      Value<String?>? userId,
      Value<String>? startedAt,
      Value<String>? language}) {
    return ChatSessionsTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      startedAt: startedAt ?? this.startedAt,
      language: language ?? this.language,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<String>(startedAt.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatSessionsTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('startedAt: $startedAt, ')
          ..write('language: $language')
          ..write(')'))
        .toString();
  }
}

class $ChatMessagesTableTable extends ChatMessagesTable
    with TableInfo<$ChatMessagesTableTable, ChatMessagesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatMessagesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _sessionIdMeta =
      const VerificationMeta('sessionId');
  @override
  late final GeneratedColumn<int> sessionId = GeneratedColumn<int>(
      'session_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES chat_sessions (id)'));
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<String> timestamp = GeneratedColumn<String>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, sessionId, role, content, timestamp];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_messages';
  @override
  VerificationContext validateIntegrity(
      Insertable<ChatMessagesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(_sessionIdMeta,
          sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta));
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatMessagesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatMessagesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sessionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}session_id'])!,
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}timestamp'])!,
    );
  }

  @override
  $ChatMessagesTableTable createAlias(String alias) {
    return $ChatMessagesTableTable(attachedDatabase, alias);
  }
}

class ChatMessagesTableData extends DataClass
    implements Insertable<ChatMessagesTableData> {
  final int id;
  final int sessionId;
  final String role;
  final String content;
  final String timestamp;
  const ChatMessagesTableData(
      {required this.id,
      required this.sessionId,
      required this.role,
      required this.content,
      required this.timestamp});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<int>(sessionId);
    map['role'] = Variable<String>(role);
    map['content'] = Variable<String>(content);
    map['timestamp'] = Variable<String>(timestamp);
    return map;
  }

  ChatMessagesTableCompanion toCompanion(bool nullToAbsent) {
    return ChatMessagesTableCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      role: Value(role),
      content: Value(content),
      timestamp: Value(timestamp),
    );
  }

  factory ChatMessagesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatMessagesTableData(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<int>(json['sessionId']),
      role: serializer.fromJson<String>(json['role']),
      content: serializer.fromJson<String>(json['content']),
      timestamp: serializer.fromJson<String>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<int>(sessionId),
      'role': serializer.toJson<String>(role),
      'content': serializer.toJson<String>(content),
      'timestamp': serializer.toJson<String>(timestamp),
    };
  }

  ChatMessagesTableData copyWith(
          {int? id,
          int? sessionId,
          String? role,
          String? content,
          String? timestamp}) =>
      ChatMessagesTableData(
        id: id ?? this.id,
        sessionId: sessionId ?? this.sessionId,
        role: role ?? this.role,
        content: content ?? this.content,
        timestamp: timestamp ?? this.timestamp,
      );
  ChatMessagesTableData copyWithCompanion(ChatMessagesTableCompanion data) {
    return ChatMessagesTableData(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      role: data.role.present ? data.role.value : this.role,
      content: data.content.present ? data.content.value : this.content,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatMessagesTableData(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('role: $role, ')
          ..write('content: $content, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sessionId, role, content, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatMessagesTableData &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.role == this.role &&
          other.content == this.content &&
          other.timestamp == this.timestamp);
}

class ChatMessagesTableCompanion
    extends UpdateCompanion<ChatMessagesTableData> {
  final Value<int> id;
  final Value<int> sessionId;
  final Value<String> role;
  final Value<String> content;
  final Value<String> timestamp;
  const ChatMessagesTableCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.role = const Value.absent(),
    this.content = const Value.absent(),
    this.timestamp = const Value.absent(),
  });
  ChatMessagesTableCompanion.insert({
    this.id = const Value.absent(),
    required int sessionId,
    required String role,
    required String content,
    required String timestamp,
  })  : sessionId = Value(sessionId),
        role = Value(role),
        content = Value(content),
        timestamp = Value(timestamp);
  static Insertable<ChatMessagesTableData> custom({
    Expression<int>? id,
    Expression<int>? sessionId,
    Expression<String>? role,
    Expression<String>? content,
    Expression<String>? timestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (role != null) 'role': role,
      if (content != null) 'content': content,
      if (timestamp != null) 'timestamp': timestamp,
    });
  }

  ChatMessagesTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? sessionId,
      Value<String>? role,
      Value<String>? content,
      Value<String>? timestamp}) {
    return ChatMessagesTableCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      role: role ?? this.role,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<int>(sessionId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<String>(timestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatMessagesTableCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('role: $role, ')
          ..write('content: $content, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }
}

class $SyncMetadataTableTable extends SyncMetadataTable
    with TableInfo<$SyncMetadataTableTable, SyncMetadataTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncMetadataTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_metadata';
  @override
  VerificationContext validateIntegrity(
      Insertable<SyncMetadataTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SyncMetadataTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncMetadataTableData(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $SyncMetadataTableTable createAlias(String alias) {
    return $SyncMetadataTableTable(attachedDatabase, alias);
  }
}

class SyncMetadataTableData extends DataClass
    implements Insertable<SyncMetadataTableData> {
  final String key;
  final String value;
  const SyncMetadataTableData({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  SyncMetadataTableCompanion toCompanion(bool nullToAbsent) {
    return SyncMetadataTableCompanion(
      key: Value(key),
      value: Value(value),
    );
  }

  factory SyncMetadataTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncMetadataTableData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  SyncMetadataTableData copyWith({String? key, String? value}) =>
      SyncMetadataTableData(
        key: key ?? this.key,
        value: value ?? this.value,
      );
  SyncMetadataTableData copyWithCompanion(SyncMetadataTableCompanion data) {
    return SyncMetadataTableData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetadataTableData(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncMetadataTableData &&
          other.key == this.key &&
          other.value == this.value);
}

class SyncMetadataTableCompanion
    extends UpdateCompanion<SyncMetadataTableData> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const SyncMetadataTableCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncMetadataTableCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value);
  static Insertable<SyncMetadataTableData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncMetadataTableCompanion copyWith(
      {Value<String>? key, Value<String>? value, Value<int>? rowid}) {
    return SyncMetadataTableCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetadataTableCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PlacesTableTable placesTable = $PlacesTableTable(this);
  late final $CategoriesTableTable categoriesTable =
      $CategoriesTableTable(this);
  late final $PlaceCategoriesTableTable placeCategoriesTable =
      $PlaceCategoriesTableTable(this);
  late final $WorkingHoursTableTable workingHoursTable =
      $WorkingHoursTableTable(this);
  late final $PlaceImagesTableTable placeImagesTable =
      $PlaceImagesTableTable(this);
  late final $SocialLinksTableTable socialLinksTable =
      $SocialLinksTableTable(this);
  late final $UserFavoritesTableTable userFavoritesTable =
      $UserFavoritesTableTable(this);
  late final $ChatSessionsTableTable chatSessionsTable =
      $ChatSessionsTableTable(this);
  late final $ChatMessagesTableTable chatMessagesTable =
      $ChatMessagesTableTable(this);
  late final $SyncMetadataTableTable syncMetadataTable =
      $SyncMetadataTableTable(this);
  late final PlacesDao placesDao = PlacesDao(this as AppDatabase);
  late final CategoriesDao categoriesDao = CategoriesDao(this as AppDatabase);
  late final FavoritesDao favoritesDao = FavoritesDao(this as AppDatabase);
  late final ChatDao chatDao = ChatDao(this as AppDatabase);
  late final SyncDao syncDao = SyncDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        placesTable,
        categoriesTable,
        placeCategoriesTable,
        workingHoursTable,
        placeImagesTable,
        socialLinksTable,
        userFavoritesTable,
        chatSessionsTable,
        chatMessagesTable,
        syncMetadataTable
      ];
}

typedef $$PlacesTableTableCreateCompanionBuilder = PlacesTableCompanion
    Function({
  Value<int> id,
  required String nameAr,
  required String nameEn,
  Value<String> descriptionAr,
  Value<String> descriptionEn,
  Value<String> addressAr,
  Value<String> addressEn,
  required double latitude,
  required double longitude,
  Value<String?> phone,
  Value<String?> website,
  Value<double> rating,
  Value<int> reviewCount,
  Value<int> priceLevel,
  Value<bool> isActive,
  required String updatedAt,
  required String createdAt,
});
typedef $$PlacesTableTableUpdateCompanionBuilder = PlacesTableCompanion
    Function({
  Value<int> id,
  Value<String> nameAr,
  Value<String> nameEn,
  Value<String> descriptionAr,
  Value<String> descriptionEn,
  Value<String> addressAr,
  Value<String> addressEn,
  Value<double> latitude,
  Value<double> longitude,
  Value<String?> phone,
  Value<String?> website,
  Value<double> rating,
  Value<int> reviewCount,
  Value<int> priceLevel,
  Value<bool> isActive,
  Value<String> updatedAt,
  Value<String> createdAt,
});

final class $$PlacesTableTableReferences
    extends BaseReferences<_$AppDatabase, $PlacesTableTable, PlacesTableData> {
  $$PlacesTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PlaceCategoriesTableTable,
      List<PlaceCategoriesTableData>> _placeCategoriesTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.placeCategoriesTable,
          aliasName: $_aliasNameGenerator(
              db.placesTable.id, db.placeCategoriesTable.placeId));

  $$PlaceCategoriesTableTableProcessedTableManager
      get placeCategoriesTableRefs {
    final manager =
        $$PlaceCategoriesTableTableTableManager($_db, $_db.placeCategoriesTable)
            .filter((f) => f.placeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_placeCategoriesTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$WorkingHoursTableTable,
      List<WorkingHoursTableData>> _workingHoursTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.workingHoursTable,
          aliasName: $_aliasNameGenerator(
              db.placesTable.id, db.workingHoursTable.placeId));

  $$WorkingHoursTableTableProcessedTableManager get workingHoursTableRefs {
    final manager =
        $$WorkingHoursTableTableTableManager($_db, $_db.workingHoursTable)
            .filter((f) => f.placeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_workingHoursTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PlaceImagesTableTable, List<PlaceImagesTableData>>
      _placeImagesTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.placeImagesTable,
              aliasName: $_aliasNameGenerator(
                  db.placesTable.id, db.placeImagesTable.placeId));

  $$PlaceImagesTableTableProcessedTableManager get placeImagesTableRefs {
    final manager =
        $$PlaceImagesTableTableTableManager($_db, $_db.placeImagesTable)
            .filter((f) => f.placeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_placeImagesTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SocialLinksTableTable, List<SocialLinksTableData>>
      _socialLinksTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.socialLinksTable,
              aliasName: $_aliasNameGenerator(
                  db.placesTable.id, db.socialLinksTable.placeId));

  $$SocialLinksTableTableProcessedTableManager get socialLinksTableRefs {
    final manager =
        $$SocialLinksTableTableTableManager($_db, $_db.socialLinksTable)
            .filter((f) => f.placeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_socialLinksTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$UserFavoritesTableTable,
      List<UserFavoritesTableData>> _userFavoritesTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.userFavoritesTable,
          aliasName: $_aliasNameGenerator(
              db.placesTable.id, db.userFavoritesTable.placeId));

  $$UserFavoritesTableTableProcessedTableManager get userFavoritesTableRefs {
    final manager =
        $$UserFavoritesTableTableTableManager($_db, $_db.userFavoritesTable)
            .filter((f) => f.placeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_userFavoritesTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PlacesTableTableFilterComposer
    extends Composer<_$AppDatabase, $PlacesTableTable> {
  $$PlacesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameAr => $composableBuilder(
      column: $table.nameAr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameEn => $composableBuilder(
      column: $table.nameEn, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descriptionAr => $composableBuilder(
      column: $table.descriptionAr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descriptionEn => $composableBuilder(
      column: $table.descriptionEn, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get addressAr => $composableBuilder(
      column: $table.addressAr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get addressEn => $composableBuilder(
      column: $table.addressEn, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get website => $composableBuilder(
      column: $table.website, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get rating => $composableBuilder(
      column: $table.rating, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get reviewCount => $composableBuilder(
      column: $table.reviewCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get priceLevel => $composableBuilder(
      column: $table.priceLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> placeCategoriesTableRefs(
      Expression<bool> Function($$PlaceCategoriesTableTableFilterComposer f)
          f) {
    final $$PlaceCategoriesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.placeCategoriesTable,
        getReferencedColumn: (t) => t.placeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlaceCategoriesTableTableFilterComposer(
              $db: $db,
              $table: $db.placeCategoriesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> workingHoursTableRefs(
      Expression<bool> Function($$WorkingHoursTableTableFilterComposer f) f) {
    final $$WorkingHoursTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.workingHoursTable,
        getReferencedColumn: (t) => t.placeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkingHoursTableTableFilterComposer(
              $db: $db,
              $table: $db.workingHoursTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> placeImagesTableRefs(
      Expression<bool> Function($$PlaceImagesTableTableFilterComposer f) f) {
    final $$PlaceImagesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.placeImagesTable,
        getReferencedColumn: (t) => t.placeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlaceImagesTableTableFilterComposer(
              $db: $db,
              $table: $db.placeImagesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> socialLinksTableRefs(
      Expression<bool> Function($$SocialLinksTableTableFilterComposer f) f) {
    final $$SocialLinksTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.socialLinksTable,
        getReferencedColumn: (t) => t.placeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SocialLinksTableTableFilterComposer(
              $db: $db,
              $table: $db.socialLinksTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> userFavoritesTableRefs(
      Expression<bool> Function($$UserFavoritesTableTableFilterComposer f) f) {
    final $$UserFavoritesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.userFavoritesTable,
        getReferencedColumn: (t) => t.placeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserFavoritesTableTableFilterComposer(
              $db: $db,
              $table: $db.userFavoritesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PlacesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PlacesTableTable> {
  $$PlacesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameAr => $composableBuilder(
      column: $table.nameAr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameEn => $composableBuilder(
      column: $table.nameEn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descriptionAr => $composableBuilder(
      column: $table.descriptionAr,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descriptionEn => $composableBuilder(
      column: $table.descriptionEn,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get addressAr => $composableBuilder(
      column: $table.addressAr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get addressEn => $composableBuilder(
      column: $table.addressEn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get website => $composableBuilder(
      column: $table.website, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get rating => $composableBuilder(
      column: $table.rating, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get reviewCount => $composableBuilder(
      column: $table.reviewCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get priceLevel => $composableBuilder(
      column: $table.priceLevel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$PlacesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlacesTableTable> {
  $$PlacesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameAr =>
      $composableBuilder(column: $table.nameAr, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get descriptionAr => $composableBuilder(
      column: $table.descriptionAr, builder: (column) => column);

  GeneratedColumn<String> get descriptionEn => $composableBuilder(
      column: $table.descriptionEn, builder: (column) => column);

  GeneratedColumn<String> get addressAr =>
      $composableBuilder(column: $table.addressAr, builder: (column) => column);

  GeneratedColumn<String> get addressEn =>
      $composableBuilder(column: $table.addressEn, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get website =>
      $composableBuilder(column: $table.website, builder: (column) => column);

  GeneratedColumn<double> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<int> get reviewCount => $composableBuilder(
      column: $table.reviewCount, builder: (column) => column);

  GeneratedColumn<int> get priceLevel => $composableBuilder(
      column: $table.priceLevel, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> placeCategoriesTableRefs<T extends Object>(
      Expression<T> Function($$PlaceCategoriesTableTableAnnotationComposer a)
          f) {
    final $$PlaceCategoriesTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.placeCategoriesTable,
            getReferencedColumn: (t) => t.placeId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$PlaceCategoriesTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.placeCategoriesTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> workingHoursTableRefs<T extends Object>(
      Expression<T> Function($$WorkingHoursTableTableAnnotationComposer a) f) {
    final $$WorkingHoursTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.workingHoursTable,
            getReferencedColumn: (t) => t.placeId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$WorkingHoursTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.workingHoursTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> placeImagesTableRefs<T extends Object>(
      Expression<T> Function($$PlaceImagesTableTableAnnotationComposer a) f) {
    final $$PlaceImagesTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.placeImagesTable,
        getReferencedColumn: (t) => t.placeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlaceImagesTableTableAnnotationComposer(
              $db: $db,
              $table: $db.placeImagesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> socialLinksTableRefs<T extends Object>(
      Expression<T> Function($$SocialLinksTableTableAnnotationComposer a) f) {
    final $$SocialLinksTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.socialLinksTable,
        getReferencedColumn: (t) => t.placeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SocialLinksTableTableAnnotationComposer(
              $db: $db,
              $table: $db.socialLinksTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> userFavoritesTableRefs<T extends Object>(
      Expression<T> Function($$UserFavoritesTableTableAnnotationComposer a) f) {
    final $$UserFavoritesTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.userFavoritesTable,
            getReferencedColumn: (t) => t.placeId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$UserFavoritesTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.userFavoritesTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$PlacesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PlacesTableTable,
    PlacesTableData,
    $$PlacesTableTableFilterComposer,
    $$PlacesTableTableOrderingComposer,
    $$PlacesTableTableAnnotationComposer,
    $$PlacesTableTableCreateCompanionBuilder,
    $$PlacesTableTableUpdateCompanionBuilder,
    (PlacesTableData, $$PlacesTableTableReferences),
    PlacesTableData,
    PrefetchHooks Function(
        {bool placeCategoriesTableRefs,
        bool workingHoursTableRefs,
        bool placeImagesTableRefs,
        bool socialLinksTableRefs,
        bool userFavoritesTableRefs})> {
  $$PlacesTableTableTableManager(_$AppDatabase db, $PlacesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlacesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlacesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlacesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nameAr = const Value.absent(),
            Value<String> nameEn = const Value.absent(),
            Value<String> descriptionAr = const Value.absent(),
            Value<String> descriptionEn = const Value.absent(),
            Value<String> addressAr = const Value.absent(),
            Value<String> addressEn = const Value.absent(),
            Value<double> latitude = const Value.absent(),
            Value<double> longitude = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> website = const Value.absent(),
            Value<double> rating = const Value.absent(),
            Value<int> reviewCount = const Value.absent(),
            Value<int> priceLevel = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<String> updatedAt = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
          }) =>
              PlacesTableCompanion(
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
            updatedAt: updatedAt,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nameAr,
            required String nameEn,
            Value<String> descriptionAr = const Value.absent(),
            Value<String> descriptionEn = const Value.absent(),
            Value<String> addressAr = const Value.absent(),
            Value<String> addressEn = const Value.absent(),
            required double latitude,
            required double longitude,
            Value<String?> phone = const Value.absent(),
            Value<String?> website = const Value.absent(),
            Value<double> rating = const Value.absent(),
            Value<int> reviewCount = const Value.absent(),
            Value<int> priceLevel = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            required String updatedAt,
            required String createdAt,
          }) =>
              PlacesTableCompanion.insert(
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
            updatedAt: updatedAt,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PlacesTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {placeCategoriesTableRefs = false,
              workingHoursTableRefs = false,
              placeImagesTableRefs = false,
              socialLinksTableRefs = false,
              userFavoritesTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (placeCategoriesTableRefs) db.placeCategoriesTable,
                if (workingHoursTableRefs) db.workingHoursTable,
                if (placeImagesTableRefs) db.placeImagesTable,
                if (socialLinksTableRefs) db.socialLinksTable,
                if (userFavoritesTableRefs) db.userFavoritesTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (placeCategoriesTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$PlacesTableTableReferences
                            ._placeCategoriesTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PlacesTableTableReferences(db, table, p0)
                                .placeCategoriesTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.placeId == item.id),
                        typedResults: items),
                  if (workingHoursTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$PlacesTableTableReferences
                            ._workingHoursTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PlacesTableTableReferences(db, table, p0)
                                .workingHoursTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.placeId == item.id),
                        typedResults: items),
                  if (placeImagesTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$PlacesTableTableReferences
                            ._placeImagesTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PlacesTableTableReferences(db, table, p0)
                                .placeImagesTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.placeId == item.id),
                        typedResults: items),
                  if (socialLinksTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$PlacesTableTableReferences
                            ._socialLinksTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PlacesTableTableReferences(db, table, p0)
                                .socialLinksTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.placeId == item.id),
                        typedResults: items),
                  if (userFavoritesTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$PlacesTableTableReferences
                            ._userFavoritesTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PlacesTableTableReferences(db, table, p0)
                                .userFavoritesTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.placeId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PlacesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PlacesTableTable,
    PlacesTableData,
    $$PlacesTableTableFilterComposer,
    $$PlacesTableTableOrderingComposer,
    $$PlacesTableTableAnnotationComposer,
    $$PlacesTableTableCreateCompanionBuilder,
    $$PlacesTableTableUpdateCompanionBuilder,
    (PlacesTableData, $$PlacesTableTableReferences),
    PlacesTableData,
    PrefetchHooks Function(
        {bool placeCategoriesTableRefs,
        bool workingHoursTableRefs,
        bool placeImagesTableRefs,
        bool socialLinksTableRefs,
        bool userFavoritesTableRefs})>;
typedef $$CategoriesTableTableCreateCompanionBuilder = CategoriesTableCompanion
    Function({
  Value<int> id,
  required String nameAr,
  required String nameEn,
  Value<String?> icon,
  required String updatedAt,
});
typedef $$CategoriesTableTableUpdateCompanionBuilder = CategoriesTableCompanion
    Function({
  Value<int> id,
  Value<String> nameAr,
  Value<String> nameEn,
  Value<String?> icon,
  Value<String> updatedAt,
});

final class $$CategoriesTableTableReferences extends BaseReferences<
    _$AppDatabase, $CategoriesTableTable, CategoriesTableData> {
  $$CategoriesTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PlaceCategoriesTableTable,
      List<PlaceCategoriesTableData>> _placeCategoriesTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.placeCategoriesTable,
          aliasName: $_aliasNameGenerator(
              db.categoriesTable.id, db.placeCategoriesTable.categoryId));

  $$PlaceCategoriesTableTableProcessedTableManager
      get placeCategoriesTableRefs {
    final manager =
        $$PlaceCategoriesTableTableTableManager($_db, $_db.placeCategoriesTable)
            .filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_placeCategoriesTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CategoriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTableTable> {
  $$CategoriesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameAr => $composableBuilder(
      column: $table.nameAr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameEn => $composableBuilder(
      column: $table.nameEn, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> placeCategoriesTableRefs(
      Expression<bool> Function($$PlaceCategoriesTableTableFilterComposer f)
          f) {
    final $$PlaceCategoriesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.placeCategoriesTable,
        getReferencedColumn: (t) => t.categoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlaceCategoriesTableTableFilterComposer(
              $db: $db,
              $table: $db.placeCategoriesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CategoriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTableTable> {
  $$CategoriesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameAr => $composableBuilder(
      column: $table.nameAr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameEn => $composableBuilder(
      column: $table.nameEn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$CategoriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTableTable> {
  $$CategoriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameAr =>
      $composableBuilder(column: $table.nameAr, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> placeCategoriesTableRefs<T extends Object>(
      Expression<T> Function($$PlaceCategoriesTableTableAnnotationComposer a)
          f) {
    final $$PlaceCategoriesTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.placeCategoriesTable,
            getReferencedColumn: (t) => t.categoryId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$PlaceCategoriesTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.placeCategoriesTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$CategoriesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CategoriesTableTable,
    CategoriesTableData,
    $$CategoriesTableTableFilterComposer,
    $$CategoriesTableTableOrderingComposer,
    $$CategoriesTableTableAnnotationComposer,
    $$CategoriesTableTableCreateCompanionBuilder,
    $$CategoriesTableTableUpdateCompanionBuilder,
    (CategoriesTableData, $$CategoriesTableTableReferences),
    CategoriesTableData,
    PrefetchHooks Function({bool placeCategoriesTableRefs})> {
  $$CategoriesTableTableTableManager(
      _$AppDatabase db, $CategoriesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nameAr = const Value.absent(),
            Value<String> nameEn = const Value.absent(),
            Value<String?> icon = const Value.absent(),
            Value<String> updatedAt = const Value.absent(),
          }) =>
              CategoriesTableCompanion(
            id: id,
            nameAr: nameAr,
            nameEn: nameEn,
            icon: icon,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nameAr,
            required String nameEn,
            Value<String?> icon = const Value.absent(),
            required String updatedAt,
          }) =>
              CategoriesTableCompanion.insert(
            id: id,
            nameAr: nameAr,
            nameEn: nameEn,
            icon: icon,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CategoriesTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({placeCategoriesTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (placeCategoriesTableRefs) db.placeCategoriesTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (placeCategoriesTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$CategoriesTableTableReferences
                            ._placeCategoriesTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CategoriesTableTableReferences(db, table, p0)
                                .placeCategoriesTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.categoryId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CategoriesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CategoriesTableTable,
    CategoriesTableData,
    $$CategoriesTableTableFilterComposer,
    $$CategoriesTableTableOrderingComposer,
    $$CategoriesTableTableAnnotationComposer,
    $$CategoriesTableTableCreateCompanionBuilder,
    $$CategoriesTableTableUpdateCompanionBuilder,
    (CategoriesTableData, $$CategoriesTableTableReferences),
    CategoriesTableData,
    PrefetchHooks Function({bool placeCategoriesTableRefs})>;
typedef $$PlaceCategoriesTableTableCreateCompanionBuilder
    = PlaceCategoriesTableCompanion Function({
  required int placeId,
  required int categoryId,
  Value<int> rowid,
});
typedef $$PlaceCategoriesTableTableUpdateCompanionBuilder
    = PlaceCategoriesTableCompanion Function({
  Value<int> placeId,
  Value<int> categoryId,
  Value<int> rowid,
});

final class $$PlaceCategoriesTableTableReferences extends BaseReferences<
    _$AppDatabase, $PlaceCategoriesTableTable, PlaceCategoriesTableData> {
  $$PlaceCategoriesTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PlacesTableTable _placeIdTable(_$AppDatabase db) =>
      db.placesTable.createAlias($_aliasNameGenerator(
          db.placeCategoriesTable.placeId, db.placesTable.id));

  $$PlacesTableTableProcessedTableManager get placeId {
    final $_column = $_itemColumn<int>('place_id')!;

    final manager = $$PlacesTableTableTableManager($_db, $_db.placesTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_placeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $CategoriesTableTable _categoryIdTable(_$AppDatabase db) =>
      db.categoriesTable.createAlias($_aliasNameGenerator(
          db.placeCategoriesTable.categoryId, db.categoriesTable.id));

  $$CategoriesTableTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<int>('category_id')!;

    final manager =
        $$CategoriesTableTableTableManager($_db, $_db.categoriesTable)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PlaceCategoriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $PlaceCategoriesTableTable> {
  $$PlaceCategoriesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PlacesTableTableFilterComposer get placeId {
    final $$PlacesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.placeId,
        referencedTable: $db.placesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlacesTableTableFilterComposer(
              $db: $db,
              $table: $db.placesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CategoriesTableTableFilterComposer get categoryId {
    final $$CategoriesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categoriesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableTableFilterComposer(
              $db: $db,
              $table: $db.categoriesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PlaceCategoriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PlaceCategoriesTableTable> {
  $$PlaceCategoriesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PlacesTableTableOrderingComposer get placeId {
    final $$PlacesTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.placeId,
        referencedTable: $db.placesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlacesTableTableOrderingComposer(
              $db: $db,
              $table: $db.placesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CategoriesTableTableOrderingComposer get categoryId {
    final $$CategoriesTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categoriesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableTableOrderingComposer(
              $db: $db,
              $table: $db.categoriesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PlaceCategoriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlaceCategoriesTableTable> {
  $$PlaceCategoriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PlacesTableTableAnnotationComposer get placeId {
    final $$PlacesTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.placeId,
        referencedTable: $db.placesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlacesTableTableAnnotationComposer(
              $db: $db,
              $table: $db.placesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CategoriesTableTableAnnotationComposer get categoryId {
    final $$CategoriesTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categoriesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableTableAnnotationComposer(
              $db: $db,
              $table: $db.categoriesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PlaceCategoriesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PlaceCategoriesTableTable,
    PlaceCategoriesTableData,
    $$PlaceCategoriesTableTableFilterComposer,
    $$PlaceCategoriesTableTableOrderingComposer,
    $$PlaceCategoriesTableTableAnnotationComposer,
    $$PlaceCategoriesTableTableCreateCompanionBuilder,
    $$PlaceCategoriesTableTableUpdateCompanionBuilder,
    (PlaceCategoriesTableData, $$PlaceCategoriesTableTableReferences),
    PlaceCategoriesTableData,
    PrefetchHooks Function({bool placeId, bool categoryId})> {
  $$PlaceCategoriesTableTableTableManager(
      _$AppDatabase db, $PlaceCategoriesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlaceCategoriesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlaceCategoriesTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlaceCategoriesTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> placeId = const Value.absent(),
            Value<int> categoryId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PlaceCategoriesTableCompanion(
            placeId: placeId,
            categoryId: categoryId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int placeId,
            required int categoryId,
            Value<int> rowid = const Value.absent(),
          }) =>
              PlaceCategoriesTableCompanion.insert(
            placeId: placeId,
            categoryId: categoryId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PlaceCategoriesTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({placeId = false, categoryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (placeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.placeId,
                    referencedTable:
                        $$PlaceCategoriesTableTableReferences._placeIdTable(db),
                    referencedColumn: $$PlaceCategoriesTableTableReferences
                        ._placeIdTable(db)
                        .id,
                  ) as T;
                }
                if (categoryId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.categoryId,
                    referencedTable: $$PlaceCategoriesTableTableReferences
                        ._categoryIdTable(db),
                    referencedColumn: $$PlaceCategoriesTableTableReferences
                        ._categoryIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PlaceCategoriesTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $PlaceCategoriesTableTable,
        PlaceCategoriesTableData,
        $$PlaceCategoriesTableTableFilterComposer,
        $$PlaceCategoriesTableTableOrderingComposer,
        $$PlaceCategoriesTableTableAnnotationComposer,
        $$PlaceCategoriesTableTableCreateCompanionBuilder,
        $$PlaceCategoriesTableTableUpdateCompanionBuilder,
        (PlaceCategoriesTableData, $$PlaceCategoriesTableTableReferences),
        PlaceCategoriesTableData,
        PrefetchHooks Function({bool placeId, bool categoryId})>;
typedef $$WorkingHoursTableTableCreateCompanionBuilder
    = WorkingHoursTableCompanion Function({
  Value<int> id,
  required int placeId,
  required int dayOfWeek,
  Value<String> openTime,
  Value<String> closeTime,
  Value<bool> isClosed,
});
typedef $$WorkingHoursTableTableUpdateCompanionBuilder
    = WorkingHoursTableCompanion Function({
  Value<int> id,
  Value<int> placeId,
  Value<int> dayOfWeek,
  Value<String> openTime,
  Value<String> closeTime,
  Value<bool> isClosed,
});

final class $$WorkingHoursTableTableReferences extends BaseReferences<
    _$AppDatabase, $WorkingHoursTableTable, WorkingHoursTableData> {
  $$WorkingHoursTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PlacesTableTable _placeIdTable(_$AppDatabase db) =>
      db.placesTable.createAlias($_aliasNameGenerator(
          db.workingHoursTable.placeId, db.placesTable.id));

  $$PlacesTableTableProcessedTableManager get placeId {
    final $_column = $_itemColumn<int>('place_id')!;

    final manager = $$PlacesTableTableTableManager($_db, $_db.placesTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_placeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$WorkingHoursTableTableFilterComposer
    extends Composer<_$AppDatabase, $WorkingHoursTableTable> {
  $$WorkingHoursTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dayOfWeek => $composableBuilder(
      column: $table.dayOfWeek, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get openTime => $composableBuilder(
      column: $table.openTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get closeTime => $composableBuilder(
      column: $table.closeTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isClosed => $composableBuilder(
      column: $table.isClosed, builder: (column) => ColumnFilters(column));

  $$PlacesTableTableFilterComposer get placeId {
    final $$PlacesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.placeId,
        referencedTable: $db.placesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlacesTableTableFilterComposer(
              $db: $db,
              $table: $db.placesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WorkingHoursTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkingHoursTableTable> {
  $$WorkingHoursTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dayOfWeek => $composableBuilder(
      column: $table.dayOfWeek, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get openTime => $composableBuilder(
      column: $table.openTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get closeTime => $composableBuilder(
      column: $table.closeTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isClosed => $composableBuilder(
      column: $table.isClosed, builder: (column) => ColumnOrderings(column));

  $$PlacesTableTableOrderingComposer get placeId {
    final $$PlacesTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.placeId,
        referencedTable: $db.placesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlacesTableTableOrderingComposer(
              $db: $db,
              $table: $db.placesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WorkingHoursTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkingHoursTableTable> {
  $$WorkingHoursTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get dayOfWeek =>
      $composableBuilder(column: $table.dayOfWeek, builder: (column) => column);

  GeneratedColumn<String> get openTime =>
      $composableBuilder(column: $table.openTime, builder: (column) => column);

  GeneratedColumn<String> get closeTime =>
      $composableBuilder(column: $table.closeTime, builder: (column) => column);

  GeneratedColumn<bool> get isClosed =>
      $composableBuilder(column: $table.isClosed, builder: (column) => column);

  $$PlacesTableTableAnnotationComposer get placeId {
    final $$PlacesTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.placeId,
        referencedTable: $db.placesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlacesTableTableAnnotationComposer(
              $db: $db,
              $table: $db.placesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WorkingHoursTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkingHoursTableTable,
    WorkingHoursTableData,
    $$WorkingHoursTableTableFilterComposer,
    $$WorkingHoursTableTableOrderingComposer,
    $$WorkingHoursTableTableAnnotationComposer,
    $$WorkingHoursTableTableCreateCompanionBuilder,
    $$WorkingHoursTableTableUpdateCompanionBuilder,
    (WorkingHoursTableData, $$WorkingHoursTableTableReferences),
    WorkingHoursTableData,
    PrefetchHooks Function({bool placeId})> {
  $$WorkingHoursTableTableTableManager(
      _$AppDatabase db, $WorkingHoursTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkingHoursTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkingHoursTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkingHoursTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> placeId = const Value.absent(),
            Value<int> dayOfWeek = const Value.absent(),
            Value<String> openTime = const Value.absent(),
            Value<String> closeTime = const Value.absent(),
            Value<bool> isClosed = const Value.absent(),
          }) =>
              WorkingHoursTableCompanion(
            id: id,
            placeId: placeId,
            dayOfWeek: dayOfWeek,
            openTime: openTime,
            closeTime: closeTime,
            isClosed: isClosed,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int placeId,
            required int dayOfWeek,
            Value<String> openTime = const Value.absent(),
            Value<String> closeTime = const Value.absent(),
            Value<bool> isClosed = const Value.absent(),
          }) =>
              WorkingHoursTableCompanion.insert(
            id: id,
            placeId: placeId,
            dayOfWeek: dayOfWeek,
            openTime: openTime,
            closeTime: closeTime,
            isClosed: isClosed,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$WorkingHoursTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({placeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (placeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.placeId,
                    referencedTable:
                        $$WorkingHoursTableTableReferences._placeIdTable(db),
                    referencedColumn:
                        $$WorkingHoursTableTableReferences._placeIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$WorkingHoursTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WorkingHoursTableTable,
    WorkingHoursTableData,
    $$WorkingHoursTableTableFilterComposer,
    $$WorkingHoursTableTableOrderingComposer,
    $$WorkingHoursTableTableAnnotationComposer,
    $$WorkingHoursTableTableCreateCompanionBuilder,
    $$WorkingHoursTableTableUpdateCompanionBuilder,
    (WorkingHoursTableData, $$WorkingHoursTableTableReferences),
    WorkingHoursTableData,
    PrefetchHooks Function({bool placeId})>;
typedef $$PlaceImagesTableTableCreateCompanionBuilder
    = PlaceImagesTableCompanion Function({
  Value<int> id,
  required int placeId,
  required String url,
  Value<bool> isPrimary,
  Value<int> sortOrder,
});
typedef $$PlaceImagesTableTableUpdateCompanionBuilder
    = PlaceImagesTableCompanion Function({
  Value<int> id,
  Value<int> placeId,
  Value<String> url,
  Value<bool> isPrimary,
  Value<int> sortOrder,
});

final class $$PlaceImagesTableTableReferences extends BaseReferences<
    _$AppDatabase, $PlaceImagesTableTable, PlaceImagesTableData> {
  $$PlaceImagesTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PlacesTableTable _placeIdTable(_$AppDatabase db) =>
      db.placesTable.createAlias(
          $_aliasNameGenerator(db.placeImagesTable.placeId, db.placesTable.id));

  $$PlacesTableTableProcessedTableManager get placeId {
    final $_column = $_itemColumn<int>('place_id')!;

    final manager = $$PlacesTableTableTableManager($_db, $_db.placesTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_placeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PlaceImagesTableTableFilterComposer
    extends Composer<_$AppDatabase, $PlaceImagesTableTable> {
  $$PlaceImagesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPrimary => $composableBuilder(
      column: $table.isPrimary, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  $$PlacesTableTableFilterComposer get placeId {
    final $$PlacesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.placeId,
        referencedTable: $db.placesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlacesTableTableFilterComposer(
              $db: $db,
              $table: $db.placesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PlaceImagesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PlaceImagesTableTable> {
  $$PlaceImagesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPrimary => $composableBuilder(
      column: $table.isPrimary, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  $$PlacesTableTableOrderingComposer get placeId {
    final $$PlacesTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.placeId,
        referencedTable: $db.placesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlacesTableTableOrderingComposer(
              $db: $db,
              $table: $db.placesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PlaceImagesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlaceImagesTableTable> {
  $$PlaceImagesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<bool> get isPrimary =>
      $composableBuilder(column: $table.isPrimary, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$PlacesTableTableAnnotationComposer get placeId {
    final $$PlacesTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.placeId,
        referencedTable: $db.placesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlacesTableTableAnnotationComposer(
              $db: $db,
              $table: $db.placesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PlaceImagesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PlaceImagesTableTable,
    PlaceImagesTableData,
    $$PlaceImagesTableTableFilterComposer,
    $$PlaceImagesTableTableOrderingComposer,
    $$PlaceImagesTableTableAnnotationComposer,
    $$PlaceImagesTableTableCreateCompanionBuilder,
    $$PlaceImagesTableTableUpdateCompanionBuilder,
    (PlaceImagesTableData, $$PlaceImagesTableTableReferences),
    PlaceImagesTableData,
    PrefetchHooks Function({bool placeId})> {
  $$PlaceImagesTableTableTableManager(
      _$AppDatabase db, $PlaceImagesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlaceImagesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlaceImagesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlaceImagesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> placeId = const Value.absent(),
            Value<String> url = const Value.absent(),
            Value<bool> isPrimary = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
          }) =>
              PlaceImagesTableCompanion(
            id: id,
            placeId: placeId,
            url: url,
            isPrimary: isPrimary,
            sortOrder: sortOrder,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int placeId,
            required String url,
            Value<bool> isPrimary = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
          }) =>
              PlaceImagesTableCompanion.insert(
            id: id,
            placeId: placeId,
            url: url,
            isPrimary: isPrimary,
            sortOrder: sortOrder,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PlaceImagesTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({placeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (placeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.placeId,
                    referencedTable:
                        $$PlaceImagesTableTableReferences._placeIdTable(db),
                    referencedColumn:
                        $$PlaceImagesTableTableReferences._placeIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PlaceImagesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PlaceImagesTableTable,
    PlaceImagesTableData,
    $$PlaceImagesTableTableFilterComposer,
    $$PlaceImagesTableTableOrderingComposer,
    $$PlaceImagesTableTableAnnotationComposer,
    $$PlaceImagesTableTableCreateCompanionBuilder,
    $$PlaceImagesTableTableUpdateCompanionBuilder,
    (PlaceImagesTableData, $$PlaceImagesTableTableReferences),
    PlaceImagesTableData,
    PrefetchHooks Function({bool placeId})>;
typedef $$SocialLinksTableTableCreateCompanionBuilder
    = SocialLinksTableCompanion Function({
  Value<int> id,
  required int placeId,
  required String platform,
  required String url,
});
typedef $$SocialLinksTableTableUpdateCompanionBuilder
    = SocialLinksTableCompanion Function({
  Value<int> id,
  Value<int> placeId,
  Value<String> platform,
  Value<String> url,
});

final class $$SocialLinksTableTableReferences extends BaseReferences<
    _$AppDatabase, $SocialLinksTableTable, SocialLinksTableData> {
  $$SocialLinksTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PlacesTableTable _placeIdTable(_$AppDatabase db) =>
      db.placesTable.createAlias(
          $_aliasNameGenerator(db.socialLinksTable.placeId, db.placesTable.id));

  $$PlacesTableTableProcessedTableManager get placeId {
    final $_column = $_itemColumn<int>('place_id')!;

    final manager = $$PlacesTableTableTableManager($_db, $_db.placesTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_placeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SocialLinksTableTableFilterComposer
    extends Composer<_$AppDatabase, $SocialLinksTableTable> {
  $$SocialLinksTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get platform => $composableBuilder(
      column: $table.platform, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnFilters(column));

  $$PlacesTableTableFilterComposer get placeId {
    final $$PlacesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.placeId,
        referencedTable: $db.placesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlacesTableTableFilterComposer(
              $db: $db,
              $table: $db.placesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SocialLinksTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SocialLinksTableTable> {
  $$SocialLinksTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get platform => $composableBuilder(
      column: $table.platform, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnOrderings(column));

  $$PlacesTableTableOrderingComposer get placeId {
    final $$PlacesTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.placeId,
        referencedTable: $db.placesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlacesTableTableOrderingComposer(
              $db: $db,
              $table: $db.placesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SocialLinksTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SocialLinksTableTable> {
  $$SocialLinksTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get platform =>
      $composableBuilder(column: $table.platform, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  $$PlacesTableTableAnnotationComposer get placeId {
    final $$PlacesTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.placeId,
        referencedTable: $db.placesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlacesTableTableAnnotationComposer(
              $db: $db,
              $table: $db.placesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SocialLinksTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SocialLinksTableTable,
    SocialLinksTableData,
    $$SocialLinksTableTableFilterComposer,
    $$SocialLinksTableTableOrderingComposer,
    $$SocialLinksTableTableAnnotationComposer,
    $$SocialLinksTableTableCreateCompanionBuilder,
    $$SocialLinksTableTableUpdateCompanionBuilder,
    (SocialLinksTableData, $$SocialLinksTableTableReferences),
    SocialLinksTableData,
    PrefetchHooks Function({bool placeId})> {
  $$SocialLinksTableTableTableManager(
      _$AppDatabase db, $SocialLinksTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SocialLinksTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SocialLinksTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SocialLinksTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> placeId = const Value.absent(),
            Value<String> platform = const Value.absent(),
            Value<String> url = const Value.absent(),
          }) =>
              SocialLinksTableCompanion(
            id: id,
            placeId: placeId,
            platform: platform,
            url: url,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int placeId,
            required String platform,
            required String url,
          }) =>
              SocialLinksTableCompanion.insert(
            id: id,
            placeId: placeId,
            platform: platform,
            url: url,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SocialLinksTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({placeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (placeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.placeId,
                    referencedTable:
                        $$SocialLinksTableTableReferences._placeIdTable(db),
                    referencedColumn:
                        $$SocialLinksTableTableReferences._placeIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$SocialLinksTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SocialLinksTableTable,
    SocialLinksTableData,
    $$SocialLinksTableTableFilterComposer,
    $$SocialLinksTableTableOrderingComposer,
    $$SocialLinksTableTableAnnotationComposer,
    $$SocialLinksTableTableCreateCompanionBuilder,
    $$SocialLinksTableTableUpdateCompanionBuilder,
    (SocialLinksTableData, $$SocialLinksTableTableReferences),
    SocialLinksTableData,
    PrefetchHooks Function({bool placeId})>;
typedef $$UserFavoritesTableTableCreateCompanionBuilder
    = UserFavoritesTableCompanion Function({
  Value<int> id,
  required String userId,
  required int placeId,
  required String createdAt,
});
typedef $$UserFavoritesTableTableUpdateCompanionBuilder
    = UserFavoritesTableCompanion Function({
  Value<int> id,
  Value<String> userId,
  Value<int> placeId,
  Value<String> createdAt,
});

final class $$UserFavoritesTableTableReferences extends BaseReferences<
    _$AppDatabase, $UserFavoritesTableTable, UserFavoritesTableData> {
  $$UserFavoritesTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PlacesTableTable _placeIdTable(_$AppDatabase db) =>
      db.placesTable.createAlias($_aliasNameGenerator(
          db.userFavoritesTable.placeId, db.placesTable.id));

  $$PlacesTableTableProcessedTableManager get placeId {
    final $_column = $_itemColumn<int>('place_id')!;

    final manager = $$PlacesTableTableTableManager($_db, $_db.placesTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_placeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$UserFavoritesTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserFavoritesTableTable> {
  $$UserFavoritesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$PlacesTableTableFilterComposer get placeId {
    final $$PlacesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.placeId,
        referencedTable: $db.placesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlacesTableTableFilterComposer(
              $db: $db,
              $table: $db.placesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UserFavoritesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserFavoritesTableTable> {
  $$UserFavoritesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$PlacesTableTableOrderingComposer get placeId {
    final $$PlacesTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.placeId,
        referencedTable: $db.placesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlacesTableTableOrderingComposer(
              $db: $db,
              $table: $db.placesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UserFavoritesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserFavoritesTableTable> {
  $$UserFavoritesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PlacesTableTableAnnotationComposer get placeId {
    final $$PlacesTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.placeId,
        referencedTable: $db.placesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlacesTableTableAnnotationComposer(
              $db: $db,
              $table: $db.placesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UserFavoritesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserFavoritesTableTable,
    UserFavoritesTableData,
    $$UserFavoritesTableTableFilterComposer,
    $$UserFavoritesTableTableOrderingComposer,
    $$UserFavoritesTableTableAnnotationComposer,
    $$UserFavoritesTableTableCreateCompanionBuilder,
    $$UserFavoritesTableTableUpdateCompanionBuilder,
    (UserFavoritesTableData, $$UserFavoritesTableTableReferences),
    UserFavoritesTableData,
    PrefetchHooks Function({bool placeId})> {
  $$UserFavoritesTableTableTableManager(
      _$AppDatabase db, $UserFavoritesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserFavoritesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserFavoritesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserFavoritesTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<int> placeId = const Value.absent(),
            Value<String> createdAt = const Value.absent(),
          }) =>
              UserFavoritesTableCompanion(
            id: id,
            userId: userId,
            placeId: placeId,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String userId,
            required int placeId,
            required String createdAt,
          }) =>
              UserFavoritesTableCompanion.insert(
            id: id,
            userId: userId,
            placeId: placeId,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$UserFavoritesTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({placeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (placeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.placeId,
                    referencedTable:
                        $$UserFavoritesTableTableReferences._placeIdTable(db),
                    referencedColumn: $$UserFavoritesTableTableReferences
                        ._placeIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$UserFavoritesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserFavoritesTableTable,
    UserFavoritesTableData,
    $$UserFavoritesTableTableFilterComposer,
    $$UserFavoritesTableTableOrderingComposer,
    $$UserFavoritesTableTableAnnotationComposer,
    $$UserFavoritesTableTableCreateCompanionBuilder,
    $$UserFavoritesTableTableUpdateCompanionBuilder,
    (UserFavoritesTableData, $$UserFavoritesTableTableReferences),
    UserFavoritesTableData,
    PrefetchHooks Function({bool placeId})>;
typedef $$ChatSessionsTableTableCreateCompanionBuilder
    = ChatSessionsTableCompanion Function({
  Value<int> id,
  Value<String?> userId,
  required String startedAt,
  Value<String> language,
});
typedef $$ChatSessionsTableTableUpdateCompanionBuilder
    = ChatSessionsTableCompanion Function({
  Value<int> id,
  Value<String?> userId,
  Value<String> startedAt,
  Value<String> language,
});

final class $$ChatSessionsTableTableReferences extends BaseReferences<
    _$AppDatabase, $ChatSessionsTableTable, ChatSessionsTableData> {
  $$ChatSessionsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ChatMessagesTableTable,
      List<ChatMessagesTableData>> _chatMessagesTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.chatMessagesTable,
          aliasName: $_aliasNameGenerator(
              db.chatSessionsTable.id, db.chatMessagesTable.sessionId));

  $$ChatMessagesTableTableProcessedTableManager get chatMessagesTableRefs {
    final manager =
        $$ChatMessagesTableTableTableManager($_db, $_db.chatMessagesTable)
            .filter((f) => f.sessionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_chatMessagesTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ChatSessionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ChatSessionsTableTable> {
  $$ChatSessionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get language => $composableBuilder(
      column: $table.language, builder: (column) => ColumnFilters(column));

  Expression<bool> chatMessagesTableRefs(
      Expression<bool> Function($$ChatMessagesTableTableFilterComposer f) f) {
    final $$ChatMessagesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.chatMessagesTable,
        getReferencedColumn: (t) => t.sessionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChatMessagesTableTableFilterComposer(
              $db: $db,
              $table: $db.chatMessagesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ChatSessionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatSessionsTableTable> {
  $$ChatSessionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get language => $composableBuilder(
      column: $table.language, builder: (column) => ColumnOrderings(column));
}

class $$ChatSessionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatSessionsTableTable> {
  $$ChatSessionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  Expression<T> chatMessagesTableRefs<T extends Object>(
      Expression<T> Function($$ChatMessagesTableTableAnnotationComposer a) f) {
    final $$ChatMessagesTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.chatMessagesTable,
            getReferencedColumn: (t) => t.sessionId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ChatMessagesTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.chatMessagesTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$ChatSessionsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatSessionsTableTable,
    ChatSessionsTableData,
    $$ChatSessionsTableTableFilterComposer,
    $$ChatSessionsTableTableOrderingComposer,
    $$ChatSessionsTableTableAnnotationComposer,
    $$ChatSessionsTableTableCreateCompanionBuilder,
    $$ChatSessionsTableTableUpdateCompanionBuilder,
    (ChatSessionsTableData, $$ChatSessionsTableTableReferences),
    ChatSessionsTableData,
    PrefetchHooks Function({bool chatMessagesTableRefs})> {
  $$ChatSessionsTableTableTableManager(
      _$AppDatabase db, $ChatSessionsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChatSessionsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChatSessionsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChatSessionsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> userId = const Value.absent(),
            Value<String> startedAt = const Value.absent(),
            Value<String> language = const Value.absent(),
          }) =>
              ChatSessionsTableCompanion(
            id: id,
            userId: userId,
            startedAt: startedAt,
            language: language,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> userId = const Value.absent(),
            required String startedAt,
            Value<String> language = const Value.absent(),
          }) =>
              ChatSessionsTableCompanion.insert(
            id: id,
            userId: userId,
            startedAt: startedAt,
            language: language,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ChatSessionsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({chatMessagesTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (chatMessagesTableRefs) db.chatMessagesTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (chatMessagesTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ChatSessionsTableTableReferences
                            ._chatMessagesTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ChatSessionsTableTableReferences(db, table, p0)
                                .chatMessagesTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.sessionId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ChatSessionsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ChatSessionsTableTable,
    ChatSessionsTableData,
    $$ChatSessionsTableTableFilterComposer,
    $$ChatSessionsTableTableOrderingComposer,
    $$ChatSessionsTableTableAnnotationComposer,
    $$ChatSessionsTableTableCreateCompanionBuilder,
    $$ChatSessionsTableTableUpdateCompanionBuilder,
    (ChatSessionsTableData, $$ChatSessionsTableTableReferences),
    ChatSessionsTableData,
    PrefetchHooks Function({bool chatMessagesTableRefs})>;
typedef $$ChatMessagesTableTableCreateCompanionBuilder
    = ChatMessagesTableCompanion Function({
  Value<int> id,
  required int sessionId,
  required String role,
  required String content,
  required String timestamp,
});
typedef $$ChatMessagesTableTableUpdateCompanionBuilder
    = ChatMessagesTableCompanion Function({
  Value<int> id,
  Value<int> sessionId,
  Value<String> role,
  Value<String> content,
  Value<String> timestamp,
});

final class $$ChatMessagesTableTableReferences extends BaseReferences<
    _$AppDatabase, $ChatMessagesTableTable, ChatMessagesTableData> {
  $$ChatMessagesTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ChatSessionsTableTable _sessionIdTable(_$AppDatabase db) =>
      db.chatSessionsTable.createAlias($_aliasNameGenerator(
          db.chatMessagesTable.sessionId, db.chatSessionsTable.id));

  $$ChatSessionsTableTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<int>('session_id')!;

    final manager =
        $$ChatSessionsTableTableTableManager($_db, $_db.chatSessionsTable)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ChatMessagesTableTableFilterComposer
    extends Composer<_$AppDatabase, $ChatMessagesTableTable> {
  $$ChatMessagesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));

  $$ChatSessionsTableTableFilterComposer get sessionId {
    final $$ChatSessionsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sessionId,
        referencedTable: $db.chatSessionsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChatSessionsTableTableFilterComposer(
              $db: $db,
              $table: $db.chatSessionsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ChatMessagesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatMessagesTableTable> {
  $$ChatMessagesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));

  $$ChatSessionsTableTableOrderingComposer get sessionId {
    final $$ChatSessionsTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sessionId,
        referencedTable: $db.chatSessionsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ChatSessionsTableTableOrderingComposer(
              $db: $db,
              $table: $db.chatSessionsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ChatMessagesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatMessagesTableTable> {
  $$ChatMessagesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  $$ChatSessionsTableTableAnnotationComposer get sessionId {
    final $$ChatSessionsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.sessionId,
            referencedTable: $db.chatSessionsTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ChatSessionsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.chatSessionsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$ChatMessagesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatMessagesTableTable,
    ChatMessagesTableData,
    $$ChatMessagesTableTableFilterComposer,
    $$ChatMessagesTableTableOrderingComposer,
    $$ChatMessagesTableTableAnnotationComposer,
    $$ChatMessagesTableTableCreateCompanionBuilder,
    $$ChatMessagesTableTableUpdateCompanionBuilder,
    (ChatMessagesTableData, $$ChatMessagesTableTableReferences),
    ChatMessagesTableData,
    PrefetchHooks Function({bool sessionId})> {
  $$ChatMessagesTableTableTableManager(
      _$AppDatabase db, $ChatMessagesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChatMessagesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChatMessagesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChatMessagesTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> sessionId = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String> timestamp = const Value.absent(),
          }) =>
              ChatMessagesTableCompanion(
            id: id,
            sessionId: sessionId,
            role: role,
            content: content,
            timestamp: timestamp,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int sessionId,
            required String role,
            required String content,
            required String timestamp,
          }) =>
              ChatMessagesTableCompanion.insert(
            id: id,
            sessionId: sessionId,
            role: role,
            content: content,
            timestamp: timestamp,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ChatMessagesTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({sessionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (sessionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.sessionId,
                    referencedTable:
                        $$ChatMessagesTableTableReferences._sessionIdTable(db),
                    referencedColumn: $$ChatMessagesTableTableReferences
                        ._sessionIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ChatMessagesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ChatMessagesTableTable,
    ChatMessagesTableData,
    $$ChatMessagesTableTableFilterComposer,
    $$ChatMessagesTableTableOrderingComposer,
    $$ChatMessagesTableTableAnnotationComposer,
    $$ChatMessagesTableTableCreateCompanionBuilder,
    $$ChatMessagesTableTableUpdateCompanionBuilder,
    (ChatMessagesTableData, $$ChatMessagesTableTableReferences),
    ChatMessagesTableData,
    PrefetchHooks Function({bool sessionId})>;
typedef $$SyncMetadataTableTableCreateCompanionBuilder
    = SyncMetadataTableCompanion Function({
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $$SyncMetadataTableTableUpdateCompanionBuilder
    = SyncMetadataTableCompanion Function({
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $$SyncMetadataTableTableFilterComposer
    extends Composer<_$AppDatabase, $SyncMetadataTableTable> {
  $$SyncMetadataTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));
}

class $$SyncMetadataTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncMetadataTableTable> {
  $$SyncMetadataTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));
}

class $$SyncMetadataTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncMetadataTableTable> {
  $$SyncMetadataTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$SyncMetadataTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncMetadataTableTable,
    SyncMetadataTableData,
    $$SyncMetadataTableTableFilterComposer,
    $$SyncMetadataTableTableOrderingComposer,
    $$SyncMetadataTableTableAnnotationComposer,
    $$SyncMetadataTableTableCreateCompanionBuilder,
    $$SyncMetadataTableTableUpdateCompanionBuilder,
    (
      SyncMetadataTableData,
      BaseReferences<_$AppDatabase, $SyncMetadataTableTable,
          SyncMetadataTableData>
    ),
    SyncMetadataTableData,
    PrefetchHooks Function()> {
  $$SyncMetadataTableTableTableManager(
      _$AppDatabase db, $SyncMetadataTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncMetadataTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncMetadataTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncMetadataTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncMetadataTableCompanion(
            key: key,
            value: value,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncMetadataTableCompanion.insert(
            key: key,
            value: value,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncMetadataTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SyncMetadataTableTable,
    SyncMetadataTableData,
    $$SyncMetadataTableTableFilterComposer,
    $$SyncMetadataTableTableOrderingComposer,
    $$SyncMetadataTableTableAnnotationComposer,
    $$SyncMetadataTableTableCreateCompanionBuilder,
    $$SyncMetadataTableTableUpdateCompanionBuilder,
    (
      SyncMetadataTableData,
      BaseReferences<_$AppDatabase, $SyncMetadataTableTable,
          SyncMetadataTableData>
    ),
    SyncMetadataTableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PlacesTableTableTableManager get placesTable =>
      $$PlacesTableTableTableManager(_db, _db.placesTable);
  $$CategoriesTableTableTableManager get categoriesTable =>
      $$CategoriesTableTableTableManager(_db, _db.categoriesTable);
  $$PlaceCategoriesTableTableTableManager get placeCategoriesTable =>
      $$PlaceCategoriesTableTableTableManager(_db, _db.placeCategoriesTable);
  $$WorkingHoursTableTableTableManager get workingHoursTable =>
      $$WorkingHoursTableTableTableManager(_db, _db.workingHoursTable);
  $$PlaceImagesTableTableTableManager get placeImagesTable =>
      $$PlaceImagesTableTableTableManager(_db, _db.placeImagesTable);
  $$SocialLinksTableTableTableManager get socialLinksTable =>
      $$SocialLinksTableTableTableManager(_db, _db.socialLinksTable);
  $$UserFavoritesTableTableTableManager get userFavoritesTable =>
      $$UserFavoritesTableTableTableManager(_db, _db.userFavoritesTable);
  $$ChatSessionsTableTableTableManager get chatSessionsTable =>
      $$ChatSessionsTableTableTableManager(_db, _db.chatSessionsTable);
  $$ChatMessagesTableTableTableManager get chatMessagesTable =>
      $$ChatMessagesTableTableTableManager(_db, _db.chatMessagesTable);
  $$SyncMetadataTableTableTableManager get syncMetadataTable =>
      $$SyncMetadataTableTableTableManager(_db, _db.syncMetadataTable);
}
