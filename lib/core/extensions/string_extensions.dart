extension StringExtensions on String {
  /// Returns true if string contains Arabic characters
  bool get isArabic {
    return contains(RegExp(r'[\u0600-\u06FF]'));
  }

  /// Returns true if string is predominantly Arabic
  bool get isArabicDominant {
    final arabicChars = RegExp(r'[\u0600-\u06FF]').allMatches(this).length;
    final totalChars = replaceAll(' ', '').length;
    if (totalChars == 0) return false;
    return arabicChars / totalChars > 0.4;
  }

  /// Truncate with ellipsis
  String truncate(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}...';
  }

  /// Returns null if string is empty, otherwise returns the string
  String? get nullIfEmpty => isEmpty ? null : this;

  /// Capitalize first letter
  String get capitalized {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

extension NullableStringExtensions on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNullOrEmpty => !isNullOrEmpty;
}
