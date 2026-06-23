import 'package:equatable/equatable.dart';

class UserPreferences extends Equatable {
  final String? cuisineType;
  final int? budgetLevel;       // 1–4
  final double? maxDistanceKm;
  final String? mealType;       // dine_in, takeaway, delivery
  final bool? openNow;
  final List<int> excludedIds;
  final List<String> keywords;

  const UserPreferences({
    this.cuisineType,
    this.budgetLevel,
    this.maxDistanceKm,
    this.mealType,
    this.openNow,
    this.excludedIds = const [],
    this.keywords = const [],
  });

  const UserPreferences.empty()
      : cuisineType = null,
        budgetLevel = null,
        maxDistanceKm = null,
        mealType = null,
        openNow = null,
        excludedIds = const [],
        keywords = const [];

  int get signalCount {
    int count = 0;
    if (cuisineType != null) count++;
    if (budgetLevel != null) count++;
    if (maxDistanceKm != null) count++;
    if (mealType != null) count++;
    if (openNow != null) count++;
    if (keywords.isNotEmpty) count++;
    return count;
  }

  bool get hasEnoughSignals => signalCount >= 2;

  UserPreferences merge(UserPreferences other) {
    return UserPreferences(
      cuisineType: other.cuisineType ?? cuisineType,
      budgetLevel: other.budgetLevel ?? budgetLevel,
      maxDistanceKm: other.maxDistanceKm ?? maxDistanceKm,
      mealType: other.mealType ?? mealType,
      openNow: other.openNow ?? openNow,
      excludedIds: [...excludedIds, ...other.excludedIds],
      keywords: [...keywords, ...other.keywords],
    );
  }

  @override
  List<Object?> get props => [
        cuisineType,
        budgetLevel,
        maxDistanceKm,
        mealType,
        openNow,
        excludedIds,
        keywords,
      ];
}
