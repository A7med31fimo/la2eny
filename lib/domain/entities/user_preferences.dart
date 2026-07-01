import 'package:equatable/equatable.dart';
class UserPreferences extends Equatable {
  final String? cuisineType;
  final int? budgetLevel;
  final double? maxDistanceKm;
  final String? mealType;
  final bool? openNow;
  final List<int> excludedIds;
  final List<String> keywords;
  const UserPreferences({this.cuisineType, this.budgetLevel, this.maxDistanceKm,
    this.mealType, this.openNow, this.excludedIds = const [], this.keywords = const []});
  const UserPreferences.empty() : cuisineType=null, budgetLevel=null, maxDistanceKm=null,
    mealType=null, openNow=null, excludedIds=const[], keywords=const[];
  int get signalCount {
    int c = 0;
    if (cuisineType != null) c++;
    if (budgetLevel != null) c++;
    if (maxDistanceKm != null) c++;
    if (mealType != null) c++;
    if (openNow != null) c++;
    if (keywords.isNotEmpty) c++;
    return c;
  }
  bool get hasEnoughSignals => signalCount >= 2;
  UserPreferences merge(UserPreferences o) => UserPreferences(
    cuisineType: o.cuisineType ?? cuisineType, budgetLevel: o.budgetLevel ?? budgetLevel,
    maxDistanceKm: o.maxDistanceKm ?? maxDistanceKm, mealType: o.mealType ?? mealType,
    openNow: o.openNow ?? openNow,
    excludedIds: [...excludedIds, ...o.excludedIds], keywords: [...keywords, ...o.keywords]);
  @override List<Object?> get props => [cuisineType, budgetLevel, maxDistanceKm, mealType, openNow, excludedIds, keywords];
}
