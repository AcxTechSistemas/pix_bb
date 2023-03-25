import 'package:dio/dio.dart';
import 'package:pix_bb/src/errors/bb_api_exception.dart';
import 'package:pix_bb/src/errors/bb_http_exceptions.dart';
import 'package:pix_bb/src/errors/pix_exception_interface.dart';
import 'package:pix_bb/src/services/client_service.dart';
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
  Future<Result<Map<String, dynamic>, PixException>> get(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) async {
    try {
      final options = Options(headers: headers);
      final response = await dio.get(
        url,
        options: options,
        queryParameters: queryParameters,
      );
      return Success(response.data);
    } on DioError catch (e) {
      if (e.response?.data != null) {
        return Failure(BBApiException.apiError(e.response!.data));
      } else {
        return Failure(BBHttpException.httpException(e.message));
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
  Future<Result<Map<String, dynamic>, PixException>> post(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) async {
    try {
      final options = Options(headers: headers);
      final response = await dio.post(
        url,
        options: options,
        queryParameters: queryParameters,
      );
      return Success(response.data);
    } on DioError catch (e) {
      if (e.response?.data != null) {
        return Failure(BBApiException.apiError(e.response!.data));
      } else {
        return Failure(BBHttpException.httpException(e.message));
      }
    } catch (e) {
      return Failure(BBHttpException.httpException(e));
    }
  }
}
