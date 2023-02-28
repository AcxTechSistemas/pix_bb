import 'package:dio/dio.dart';
import 'package:pix_bb/src/error/pix_error.dart';
import 'package:pix_bb/src/models/token_body.dart';
import 'package:pix_bb/src/services/client_service.dart';

/// A class representing a TokenRepository, responsible for managing requests and responses for token retrieval.
///
/// This class contains information about a client, URLs and headers for requesting data.
///
/// The [TokenRepository] class has a constructor that requires the following parameters:
/// - [client]: an instance of [ClientService] that will be used to make requests.
/// - [url]: a [String] representing the URL for the token API.
class TokenRepository {
  final ClientService client;
  final String url;
  TokenRepository(this.client, this.url);

  /// Retrieves a [Token] from the API using the provided basic authorization key.
  ///
  /// This method takes the following parameters:
  /// - [basicKey]: a [String] representing the basic authorization key.
  ///
  /// This method returns a [Future][Token].
  ///
  /// Throws a [PixError] if the API call fails with a [DioError].
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
