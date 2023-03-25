// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'pix_exception_interface.dart';

enum UnknownExceptionType {
  unknown,
}

/// An exception that represents an unknown error in the Pix BB API.
///
/// This exception can be used to wrap any kind of error that cannot be classified
/// into any of the other types of exceptions in this library. It holds an [_error]
/// object that can be of any type, and an [_type] that is always [UnknownExceptionType.unknown].
class BBUnknownException implements PixException {
  final dynamic _error;

  final UnknownExceptionType _type;

  /// Creates a new [BBUnknownException] with the given [_error] object and [_type].
  const BBUnknownException({
    required dynamic error,
    required UnknownExceptionType type,
  })  : _error = error,
        _type = type;

  /// The error message returned.
  @override
  dynamic get message => _error;

  /// The type of exception, which in this case is always [UnknownExceptionType.unknown].
  @override
  Enum get exceptionType => _type;

  /// Creates a new [PixException] from the given [e] object, wrapping it in a
  /// [BBUnknownException] with [_error] equal to [e.toString()] and [_type]
  /// equal to [UnknownExceptionType.unknown].
  static PixException unknownException(dynamic e) {
    return BBUnknownException(
      error: e.toString(),
      type: UnknownExceptionType.unknown,
    );
  }

  /// Returns a string representation of this exception.
  @override
  String toString() => 'BBUnknownException(error: $_error, type: $_type)';
}
