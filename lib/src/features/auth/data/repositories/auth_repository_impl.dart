import 'package:pix_bb/src/errors/bb_api_exception.dart';
import 'package:pix_bb/src/features/auth/data/models/token_model.dart';
import 'package:pix_bb/src/features/auth/domain/entities/token.dart';
import 'package:pix_bb/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:pix_bb/src/core/services/client_service.dart';
import 'package:result_dart/result_dart.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final ClientService _client;

  AuthRepositoryImpl(this._client);

  @override
  Future<Result<Token>> getToken({
    required String url,
    required String basicKey,
  }) async {
    if (basicKey.isEmpty) {
      return Failure(BBApiException.apiError({
        'error': 'empty-basic-key',
        'error_description': 'BasicKey is empty or not defined',
      }));
    }

    final authHeader =
        basicKey.startsWith('Basic ') ? basicKey : 'Basic $basicKey';

    final response = await _client.post(
      url,
      headers: {
        'Authorization': authHeader,
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'grant_type': 'client_credentials',
        'scope': 'pix.read',
      },
    );

    return response.map((success) {
      if (success.containsKey('access_token')) {
        return TokenModel.fromMap(success);
      } else {
        throw BBApiException.apiError(success);
      }
    }).recover((failure) {
      return Failure(failure);
    });
  }
}
