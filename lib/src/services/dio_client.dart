import 'package:dio/dio.dart';
import 'package:pix_bb/src/services/client_service.dart';

class DioClient implements ClientService {
  final dio = Dio();

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
