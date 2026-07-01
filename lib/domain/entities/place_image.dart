import 'package:equatable/equatable.dart';
class PlaceImage extends Equatable {
  final int id;
  final int placeId;
  final String url;
  final bool isPrimary;
  final int sortOrder;
  const PlaceImage({required this.id, required this.placeId, required this.url,
    required this.isPrimary, required this.sortOrder});
  @override List<Object?> get props => [id, url];
}
