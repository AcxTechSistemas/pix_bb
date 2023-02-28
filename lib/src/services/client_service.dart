abstract class ClientService {
  Future<Map<String, dynamic>> post(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  });
  Future<Map<String, dynamic>> get(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  });
}
