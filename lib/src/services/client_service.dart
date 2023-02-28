/// This abstract class represents a client service that can be used to make HTTP requests to an API.
///
/// The [ClientService] class defines two methods, post and get, which allow for making HTTP POST and GET requests respectively. Both methods take a URL string as a required parameter, and optional header and query parameter maps.
///
/// Implementations of this class should provide concrete implementations of these methods to provide actual HTTP client functionality.
abstract class ClientService {
  /// Sends an HTTP POST request to the specified URL with optional headers and query parameters.
  ///
  /// The [url] parameter is a required string representing the URL to which the POST request should be sent.
  ///
  /// The optional [headers] parameter is a map of header names to values to include in the request.
  ///
  /// The optional [queryParameters] parameter is a map of query parameter names to values to include in the request.
  ///
  /// Returns a [Future] which resolves to a [Map] containing the response data from the server.
  Future<Map<String, dynamic>> post(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  });

  /// Sends an HTTP GET request to the specified URL with optional headers and query parameters.
  ///
  /// The [url] parameter is a required string representing the URL to which the GET request should be sent.
  ///
  /// The optional [headers] parameter is a map of header names to values to include in the request.
  ///
  /// The optional [queryParameters] parameter is a map of query parameter names to values to include in the request.
  ///
  /// Returns a [Future] which resolves to a [Map] containing the response data from the server.
  Future<Map<String, dynamic>> get(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  });
}
