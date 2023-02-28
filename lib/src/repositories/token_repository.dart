import 'package:dio/dio.dart';
import 'package:pix_bb/src/error/pix_error.dart';
import 'package:pix_bb/src/models/token_body.dart';
import 'package:pix_bb/src/services/client_service.dart';

class TokenRepository {
  final ClientService client;
  final String url;
  TokenRepository(this.client, this.url);

  Future<Token> getToken({required String basicKey}) async {
    final headers = {
      'Authorization': basicKey,
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    final queryParameters = {
      'grant_type': 'client_credentials',
      'scope': 'pix.read',
    };
    try {
      final response = await client.post(
        url,
        headers: headers,
        queryParameters: queryParameters,
      );
      return Token.fromJson(response);
    } on DioError catch (e) {
      throw PixError(dioError: e);
    }
  }
}
