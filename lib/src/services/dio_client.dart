import 'package:dio/dio.dart';
import 'package:pix_bb/src/services/client_service.dart';

/// A class representing a [Dio] client that implements the [ClientService] interface.
///
/// The [DioClient] class provides HTTP methods for making requests and receiving responses from the Pix API. It requires the Dio package to be imported.
class DioClient implements ClientService {
  final dio = Dio();

  /// Sends an HTTP GET request to the specified [url] with optional [headers] and [queryParameters], and returns the response body as a [Map] of [String] keys to dynamic values.
  ///
  /// If [headers] or [queryParameters] are not specified, they will default to null.
  ///
  /// Throws a [DioError] if the request fails.
  @override
  Future<Map<String, dynamic>> get(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) async {
    final options = Options(headers: headers);
    final response = await dio.get(
      url,
      options: options,
      queryParameters: queryParameters,
    );
    return response.data;
  }

  /// Sends an HTTP POST request to the specified [url] with optional [headers] and [queryParameters], and returns the response body as a [Map] of [String] keys to dynamic values.
  ///
  /// If [headers] or [queryParameters] are not specified, they will default to null.
  ///
  /// Throws a [DioError] if the request fails.
  @override
  Future<Map<String, dynamic>> post(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) async {
    final options = Options(headers: headers);
    final response = await dio.post(
      url,
      options: options,
      queryParameters: queryParameters,
    );
    return response.data;
  }
}
