import 'package:pix_bb/src/features/auth/domain/entities/token.dart';
import 'package:result_dart/result_dart.dart';

abstract class IAuthRepository {
  Future<Result<Token>> getToken({
    required String url,
    required String basicKey,
  });
}
