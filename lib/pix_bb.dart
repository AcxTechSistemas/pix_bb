library pix_bb;

import 'package:pix_bb/src/repositories/pix_repository.dart';
import 'package:pix_bb/src/repositories/token_repository.dart';
import 'src/models/pix.dart';
import 'src/models/token_body.dart';
import 'src/services/dio_client.dart';
export './pix_bb.dart';

enum Ambiente {
  producao,
  homologacao,
}

/// A library that provides functionality to interact with the Pix API of Banco do Brasil.
///
/// This library contains classes to request and retrieve information about Pix transactions, including receiving recent transactions
/// and transactions within a given date range.
///
/// The [PixBB] class is the main class of this library and provides methods to request tokens and transaction data. It requires the following parameters:
/// - [_client]: an instance of [DioClient] used to make requests to the API.
/// - [_tokenUrl]: a [String] representing the URL to request a token for the API.
/// - [_apiUrl]: a [String] representing the base URL for the Pix API.
/// - [ambiente] a [Ambiente] representing which url will be defined in the request
/// - [Ambiente.homologacao] representing that the url that will be used in the request will be for the approval environment
/// - [Ambiente.producao] representing that the url that will be used in the request will be for the production environment
/// - By default the environment is set to production
///
/// To use this library, import it and create an instance of the [PixBB] class with the necessary parameters. Call the appropriate methods to request the desired information.
///
/// Example:
/// ```dart
/// import 'package:pix_bb/pix_bb.dart';
///
/// final pixbb = PixBB();
///
/// final token = await pixbb.getToken(basicKey: 'my_basic_key');
///
/// final recentTransactions = await pixbb.getRecentReceivedTransactions(accessToken: token.accessToken, developerApplicationKey: 'my_dev_key');
/// ```
class PixBB {
  final Ambiente ambiente;
  final _client = DioClient();
  late String _tokenUrl;
  late String _apiUrl;

  PixBB({this.ambiente = Ambiente.producao}) {
    _changeAmbiente();
  }

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

  /// Requests a token for the Pix API with the provided [basicKey].
  ///
  /// This method creates an instance of [TokenRepository] and uses it to request a token with the given [basicKey].
  ///
  /// Returns a [Future] with a [Token] object that contains the access token and its expiration time.
  Future<Token> getToken({required String basicKey}) {
    final repository = TokenRepository(_client, _tokenUrl);
    return repository.getToken(basicKey: basicKey);
  }

  /// Requests a list of recent received transactions from the Pix API.
  ///
  /// This method creates an instance of [PixRepository] and uses it to request a list of the most recent received transactions.
  /// The [accessToken] and [developerApplicationKey] parameters are required to authenticate the request.
  ///
  /// Returns a [Future] with a list of [Pix] objects representing the received transactions.
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

  /// Requests a list of transactions from the Pix API within the specified date range.
  ///
  /// This method creates an instance of [PixRepository] and uses it to request a list of transactions within the specified date range.
  /// The [accessToken] and [developerApplicationKey] parameters are required to authenticate the request.
  /// The [initialDate] and [finalDate] parameters are required to specify the date range for the requested transactions.
  ///
  /// Returns a [Future] with a list of [Pix] objects representing the transactions within the specified date range.
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
