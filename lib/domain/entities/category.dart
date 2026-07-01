import 'package:equatable/equatable.dart';
class Category extends Equatable {
  final int id;
  final String nameAr;
  final String nameEn;
  final String? icon;
  const Category({required this.id, required this.nameAr, required this.nameEn, this.icon});
  String localizedName(String locale) => locale == 'ar' ? nameAr : nameEn;
  @override List<Object?> get props => [id, nameEn, nameAr];
}
