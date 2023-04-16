// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:pix_bb/src/errors/pix_exception.dart';

/// An exception that represents an unknown error in the Pix Sicoob API.
///
/// This exception can be used to wrap any kind of error that cannot be classified
class BBUnknownException implements PixException {
  final String _error;

  final String _errorDescription;

  /// Creates a new [SicoobUnknownException] with the given [_error] object and [_errorData].
  const BBUnknownException({
    required dynamic error,
    required String errorDescription,
  })  : _error = error,
        _errorDescription = errorDescription;

  /// The error message returned.
  @override
  String get error => _error;

  /// The data of exception
  @override
  String get errorDescription => _errorDescription;

  /// Creates a new [PixException] from the given [e] object, wrapping it in a
  static PixException unknownException(dynamic e) {
    return BBUnknownException(
      error: 'unknown',
      errorDescription: e.toString(),
    );
  }

  @override
  String toString() =>
      'BBUnknownException: error: $error, errorData: $errorDescription';
}
