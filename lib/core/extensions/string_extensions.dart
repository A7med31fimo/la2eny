extension StringExtensions on String {
  bool get isArabic => contains(RegExp(r'[\u0600-\u06FF]'));
  String truncate(int max) => length <= max ? this : '\${substring(0, max)}...';
  String? get nullIfEmpty => isEmpty ? null : this;
  String get capitalized => isEmpty ? this : '\${this[0].toUpperCase()}\${substring(1)}';
}
extension NullableStringExt on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNullOrEmpty => !isNullOrEmpty;
}
