library pix_bb;

import 'package:pix_bb/src/repositories/pix_repository.dart';
import 'package:pix_bb/src/repositories/token_repository.dart';
import 'src/models/pix.dart';
import 'src/models/token_body.dart';
import 'src/services/dio_client.dart';
export './pix_bb.dart';

class PixBB {
  final _client = DioClient();
  final _tokenUrl = 'https://oauth.bb.com.br/oauth/token';
  final _apiUrl = 'https://api.bb.com.br/pix/v1';

  Future<Token> getToken({required String basicKey}) {
    final repository = TokenRepository(_client, _tokenUrl);
    return repository.getToken(basicKey: basicKey);
  }

  Future<List<Pix>> getRecentReceivedTransactions({
    required String accessToken,
    required String developerApplicationKey,
  }) {
    final repository = PixRepository(_client, _apiUrl);
    return repository.getRecentReceivedTransactions(
      accessToken: accessToken,
      developerApplicationKey: developerApplicationKey,
    );
  }

  Future<List<Pix>> getTransactionsByDate({
    required String accessToken,
    required String developerApplicationKey,
    required DateTime initialDate,
    required DateTime finalDate,
  }) {
    final repository = PixRepository(_client, _apiUrl);
    return repository.getTransactionsByDate(
      accessToken: accessToken,
      developerApplicationKey: developerApplicationKey,
      initialDate: initialDate,
      finalDate: finalDate,
    );
  }
}
