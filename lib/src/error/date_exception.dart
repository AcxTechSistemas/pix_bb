class DateException implements Exception {
  final String? message;
  final int? errorCode;
  final Map<String, dynamic>? errorData;

  DateException({
    this.message,
    this.errorCode,
    this.errorData,
  });
}
