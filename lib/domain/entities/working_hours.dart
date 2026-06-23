import 'package:equatable/equatable.dart';

class WorkingHours extends Equatable {
  final int id;
  final int placeId;
  final int dayOfWeek; // 0=Sunday ... 6=Saturday
  final String openTime;  // HH:MM
  final String closeTime; // HH:MM
  final bool isClosed;

  const WorkingHours({
    required this.id,
    required this.placeId,
    required this.dayOfWeek,
    required this.openTime,
    required this.closeTime,
    required this.isClosed,
  });

  static const List<String> dayNamesEn = [
    'Sunday', 'Monday', 'Tuesday', 'Wednesday',
    'Thursday', 'Friday', 'Saturday',
  ];

  static const List<String> dayNamesAr = [
    'الأحد', 'الاثنين', 'الثلاثاء', 'الأربعاء',
    'الخميس', 'الجمعة', 'السبت',
  ];

  String dayName(String locale) => locale == 'ar'
      ? dayNamesAr[dayOfWeek]
      : dayNamesEn[dayOfWeek];

  String get displayHours => isClosed ? 'Closed' : '$openTime – $closeTime';

  @override
  List<Object?> get props => [id, placeId, dayOfWeek];
}
