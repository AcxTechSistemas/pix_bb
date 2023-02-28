/// Exception to represent a date-related error.
class DateException implements Exception {
  /// Exception to represent a date-related error.
  final String? message;

  /// The error code associated with the exception.
  final int? errorCode;

  /// The error code associated with the exception.
  final Map<String, dynamic>? errorData;

  /// Creates a new instance of [DateException] with the given [message],
  /// [errorCode], and [errorData].
  DateException({
    this.message,
    this.errorCode,
    this.errorData,
  });
}
