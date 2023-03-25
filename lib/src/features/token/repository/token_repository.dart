import 'package:pix_bb/src/errors/pix_exception_interface.dart';
import 'package:pix_bb/src/features/token/models/token.dart';
import 'package:pix_bb/src/services/client_service.dart';
import 'package:result_dart/result_dart.dart';

import '../../../errors/bb_api_exception.dart';

/// The repository responsible for retrieving and managing tokens.
///
/// This class interacts with the [ClientService] to make API requests and return
/// results wrapped in [Result] objects containing either a [Token] or a [PixException].
class TokenRepository {
  /// Instance of the [ClientService] used to make API calls
  final ClientService _client;
  TokenRepository(ClientService client) : _client = client;

  /// Retrieve a token from the specified [url] using the provided [clientID].
  ///
  /// The API request is made through the [_client] service and the response is
  /// parsed into a [Token] object or an appropriate [PixException].
  ///
  /// Returns a [Future] containing a [Result] object with either a [Token] or
  /// a [PixException].
  Future<Result<Token, PixException>> getToken({
    required String url,
    required String basicKey,
  }) async {
    if (basicKey.isEmpty) {
      throw BBApiException.apiError(
          {'message': 'BasicKey is empty or not defined'});
    }
    final response = await _client.post(
      url,
      headers: {
        'Authorization': basicKey,
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      queryParameters: {
        'grant_type': 'client_credentials',
        'scope': 'cob.read cob.write pix.read pix.write',
      },
    );

    return response.fold((success) {
      if (success.containsKey('access_token')) {
        var token = Token.fromMap(success);
        return Success(token);
      } else {
        return Failure(BBApiException.apiError(success));
      }
    }, (failure) {
      return Failure(failure);
    });
  }
}
