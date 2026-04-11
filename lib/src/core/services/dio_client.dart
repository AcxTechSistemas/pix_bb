import 'package:dio/dio.dart';
import 'package:pix_bb/src/errors/bb_api_exception.dart';
import 'package:pix_bb/src/errors/bb_http_exceptions.dart';
import 'package:pix_bb/src/core/services/client_service.dart';
import 'package:result_dart/result_dart.dart';

/// A client service that uses Dio HTTP client to perform HTTP GET and POST requests.
class DioClient implements ClientService {
  final dio = Dio();

  /// Sends an HTTP GET request to the specified URL.
  ///
  /// Returns a `Result` object containing the response body as a map if the request is successful,
  /// or a `PixException` if an error occurs.
  ///
  /// The optional `headers` and `queryParameters` parameters can be used to pass additional
  /// headers and query parameters to the request.
  @override
  Future<Result<Map<String, dynamic>>> get(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    Map<String, String>? body,
  }) async {
    try {
      final contentType = headers?['Content-Type'] ?? headers?['content-type'];
      final options = Options(
        headers: headers,
        contentType: contentType,
      );
      final response = await dio.get(
        url,
        options: options,
        queryParameters: queryParameters,
        data: body,
      );
      return Success(response.data);
    } on DioException catch (e) {
      if (e.response?.data != null && e.response?.data is Map) {
        return Failure(BBApiException.apiError(e.response!.data));
      } else {
        return Failure(BBHttpException.httpException(e));
      }
    } catch (e) {
      return Failure(BBHttpException.httpException(e));
    }
  }

  /// Sends an HTTP POST request to the specified URL.
  ///
  /// Returns a `Result` object containing the response body as a map if the request is successful,
  /// or a `PixException` if an error occurs.
  ///
  /// The optional `headers` and `queryParameters` parameters can be used to pass additional
  /// headers and query parameters to the request.
  @override
  Future<Result<Map<String, dynamic>>> post(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    Map<String, String>? body,
  }) async {
    try {
      final contentType = headers?['Content-Type'] ?? headers?['content-type'];
      final options = Options(
        headers: headers,
        contentType: contentType,
      );
      final response = await dio.post(
        url,
        options: options,
        queryParameters: queryParameters,
        data: body,
      );
      return Success(response.data);
    } on DioException catch (e) {
      if (e.response?.data != null && e.response?.data is Map) {
        return Failure(BBApiException.apiError(e.response!.data));
      } else {
        return Failure(BBHttpException.httpException(e));
      }
    } catch (e) {
      return Failure(BBHttpException.httpException(e));
    }
  }
}
