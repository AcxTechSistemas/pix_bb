import 'package:pix_bb/src/errors/pix_exception.dart';

/// Exception thrown when an HTTP request fails.
class BBHttpException implements PixException {
  final String _error;

  final String _errorDescription;

  BBHttpException({
    required String error,
    required String errorDescription,
  })  : _error = error,
        _errorDescription = errorDescription;

  @override
  String get error => _error;

  @override
  String get errorDescription => _errorDescription;

  /// Factory method for creating an instance of [BBHttpException].
  ///
  /// [exception] is the underlying exception that caused the HTTP request to fail.
  static PixException httpException(Object exception) {
    return BBHttpException(
      error: 'network-error',
      errorDescription: exception.toString(),
    );
  }

  @override
  String toString() =>
      'BBHttpException: error: $error,  errorData: $errorDescription';
}
