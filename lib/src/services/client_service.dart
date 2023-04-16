import 'package:result_dart/result_dart.dart';

import '../errors/pix_exception.dart';

/// This abstract class represents a client service that can perform GET and POST requests
/// and returns a Result object that contains either a Map<String, dynamic> with the response body
/// or a PixException if an error occurs.
abstract class ClientService {
  /// Performs a GET request to the specified [url] and returns a [Result] object
  /// containing either a [Map<String, dynamic>] with the response body or a [PixException] if an error occurs.
  ///
  /// Optional [headers] and [queryParameters] can be provided for the request.
  Future<Result<Map<String, dynamic>, PixException>> post(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  });

  /// Performs a POST request to the specified [url] and returns a [Result] object
  /// containing either a [Map<String, dynamic>] with the response body or a [PixException] if an error occurs.
  ///
  /// An optional [headers] and [body] can be provided for the request.
  Future<Result<Map<String, dynamic>, PixException>> get(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  });
}
