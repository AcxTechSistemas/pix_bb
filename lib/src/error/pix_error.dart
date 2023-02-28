import 'package:dio/dio.dart';
import 'package:pix_bb/src/error/date_exception.dart';

import 'pix_error_interface.dart';

class PixError implements PixErrorInterface {
  final DioError? dioError;
  final DateException? exception;

  PixError({this.dioError, this.exception});

  @override
  String? get message => dioError?.message ?? exception?.message;

  @override
  int? get errorCode => dioError?.response?.statusCode ?? exception?.errorCode;

  @override
  Map<String, dynamic>? get errorData => dioError?.response?.data ?? exception?.errorData;
}
