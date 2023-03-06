import 'package:dio/dio.dart';
import 'package:pix_bb/src/error/date_exception.dart';
import 'pix_error_interface.dart';

///This class represents an implementation of the PixErrorInterface, which can be used to handle errors
///related to the Pix API requests. It contains a DioError object and a DateException object,
///which can be used to retrieve error details such as message, error code and error data.
class PixError implements PixErrorInterface {
  final Object? _exception;
  final DateException? _dateException;

  PixError({Object? exception, DateException? dateException})
      : _exception = exception,
        _dateException = dateException;

  /// Returns the error message.
  @override
  String? get errorMessage {
    late DioError dioError;
    if (_exception != null && _exception is DioError) {
      dioError = _exception as DioError;
      return dioError.message;
    } else if (_dateException != null) {
      return _dateException?.message ?? '';
    } else {
      return null;
    }
  }

  /// Returns the error code.
  @override
  int? get errorCode {
    late DioError dioError;
    if (_exception != null && _exception is DioError) {
      dioError = _exception as DioError;
      return dioError.response?.statusCode;
    } else if (_dateException != null) {
      return _dateException?.errorCode;
    } else {
      return null;
    }
  }

  /// Returns the error data as a map.
  @override
  Map<String, dynamic>? get errorData {
    late DioError dioError;
    if (_exception != null && _exception is DioError) {
      dioError = _exception as DioError;
      return dioError.response?.data;
    } else if (_dateException != null) {
      return _dateException?.errorData;
    } else {
      return null;
    }
  }
}
