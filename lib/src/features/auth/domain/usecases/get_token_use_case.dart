import 'package:pix_bb/src/features/auth/domain/entities/token.dart';
import 'package:pix_bb/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:result_dart/result_dart.dart';

class GetTokenUseCase {
  final IAuthRepository _repository;

  GetTokenUseCase(this._repository);

  Future<Result<Token>> call({
    required String url,
    required String basicKey,
  }) {
    return _repository.getToken(url: url, basicKey: basicKey);
  }
}
