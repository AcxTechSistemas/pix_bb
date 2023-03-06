/// Interface for errors that occur in the Pix system.
abstract class PixErrorInterface implements Exception {
  /// The error message.
  String? get errorMessage;

  /// The HTTP error code, if available.
  int? get errorCode;

  /// Additional error data, if available.
  Map<String, dynamic>? get errorData;
}
