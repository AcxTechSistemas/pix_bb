/// This library provides a Flutter API for accessing the BB PIX API.
library pix_bb;

import 'package:pix_bb/src/repositories/pix_repository.dart';
import 'package:pix_bb/src/repositories/token_repository.dart';
import 'src/models/pix.dart';
import 'src/models/token_body.dart';
import 'src/services/dio_client.dart';
export './pix_bb.dart';
export 'src/error/pix_error.dart';
export 'src/models/pix.dart';

/// Represents the environment (production or homologation) where the API calls will be made.
enum Ambiente {
  producao,
  homologacao,
}

/// Provides methods for accessing the BB PIX API.
class PixBB {
  final Ambiente ambiente;
  final String basicKey;
  final String appDevKey;
  final _client = DioClient();
  late String _tokenUrl;
  late String _apiUrl;

  /// Creates a new instance of the [PixBB] class.
  ///
  /// The [ambiente] parameter specifies the environment (production or homologation) where the API calls will be made.
  /// The [basicKey] parameter specifies the basic key used to authenticate the requests.
  /// The [appDevKey] parameter specifies the application developer key used to authenticate the requests.
  PixBB({
    this.ambiente = Ambiente.producao,
    required this.basicKey,
    required this.appDevKey,
  }) {
    _changeAmbiente();
  }

  /// Sets the token and API URLs according to the specified environment.
  _changeAmbiente() {
    switch (ambiente) {
      case Ambiente.producao:
        _tokenUrl = 'https://oauth.bb.com.br/oauth/token';
        _apiUrl = 'https://api.bb.com.br/pix/v1';
        break;
      case Ambiente.homologacao:
        _tokenUrl = 'https://oauth.hm.bb.com.br/oauth/token';
        _apiUrl = 'https://api.hm.bb.com.br/pix/v1';
        break;
    }
  }

  /// Retrieves a new access token from the API.
  ///
  /// The [basicKey] parameter specifies the basic key used to authenticate the request.
  Future<Token> getToken() {
    final repository = TokenRepository(_client, _tokenUrl);
    return repository.getToken(basicKey: basicKey);
  }

  /// Retrieves a list of recent received transactions from the API.
  ///
  /// The [accessToken] parameter specifies the access token used to authenticate the request.
  Future<List<Pix>> getRecentReceivedTransactions({
    required String accessToken,
  }) {
    final repository = PixRepository(_client, _apiUrl);
    return repository.getRecentReceivedTransactions(
      accessToken: accessToken,
      developerApplicationKey: appDevKey,
    );
  }

  /// Retrieves a list of transactions within the specified date range from the API.
  ///
  /// The [accessToken] parameter specifies the access token used to authenticate the request.
  /// The [initialDate] parameter specifies the initial date of the range.
  /// The [finalDate] parameter specifies the final date of the range.
  Future<List<Pix>> getTransactionsByDate({
    required String accessToken,
    required DateTime initialDate,
    required DateTime finalDate,
  }) {
    final repository = PixRepository(_client, _apiUrl);
    return repository.getTransactionsByDate(
      accessToken: accessToken,
      developerApplicationKey: appDevKey,
      initialDate: initialDate,
      finalDate: finalDate,
    );
  }
}
