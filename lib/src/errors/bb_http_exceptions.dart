// ignore_for_file:  sort_constructors_first
// ignore_for_file: public_member_api_docs

import 'package:pix_bb/src/errors/pix_exception_interface.dart';

enum HttpExceptionType {
  networkError,
}

/// Exception thrown when an HTTP request fails.
class BBHttpException implements PixException {
  final dynamic _error;

  final HttpExceptionType _type;

  BBHttpException({
    required dynamic error,
    required HttpExceptionType type,
  })  : _error = error,
        _type = type;

  @override
  Enum get exceptionType => _type;

  @override
  dynamic get message => _error;

  /// Factory method for creating an instance of [BBHttpException].
  ///
  /// [exception] is the underlying exception that caused the HTTP request to fail.
  static PixException httpException(dynamic exception) {
    return BBHttpException(
      error: exception,
      type: HttpExceptionType.networkError,
    );
  }

  /// Returns a string representation of this exception.
  @override
  String toString() => 'BBHttpException(error: $_error, type: $_type)';
}
