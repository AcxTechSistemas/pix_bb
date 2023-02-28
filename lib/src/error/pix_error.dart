import 'package:dio/dio.dart';
import 'package:pix_bb/src/error/date_exception.dart';
import 'pix_error_interface.dart';

///This class represents an implementation of the PixErrorInterface, which can be used to handle errors
///related to the Pix API requests. It contains a DioError object and a DateException object,
///which can be used to retrieve error details such as message, error code and error data.
class PixError implements PixErrorInterface {
  final DioError? dioError;
  final DateException? exception;

  PixError({this.dioError, this.exception});

  /// Returns the error message.
  @override
  String? get message => dioError?.message ?? exception?.message;

  /// Returns the error code.
  @override
  int? get errorCode => dioError?.response?.statusCode ?? exception?.errorCode;

  /// Returns the error data as a map.
  @override
  Map<String, dynamic>? get errorData =>
      dioError?.response?.data ?? exception?.errorData;
}
