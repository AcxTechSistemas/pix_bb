library pix_bb;

import 'package:flutter/material.dart';
import 'package:pix_bb/src/features/fetch_transactions/repositories/fetch_transactions.dart';
import 'package:pix_bb/src/features/token/repository/token_repository.dart';
import 'package:result_dart/result_dart.dart';
import 'src/features/fetch_transactions/models/pix.dart';
import 'src/features/token/models/token.dart';
import 'src/services/dio_client.dart';
export './pix_bb.dart';
export 'src/errors/pix_exception_interface.dart';
export 'src/errors/bb_api_exception.dart';
export 'src/errors/bb_date_exception.dart';
export 'src/errors/bb_http_exceptions.dart';
export 'src/errors/bb_unknown_exception.dart';
export 'src/features/fetch_transactions/models/pix.dart';
export 'src/features/fetch_transactions/models/parametros.dart';

enum Ambiente {
  producao,
  homologacao,
}

/// The main class that provides the Pix Banco do Brasil's API functionalities.
///
/// This class encapsulates the operations related to:
/// - Authentication token management,
/// - Transaction retrieval.
class PixBB {
  final Ambiente _ambiente;
  final String _basicKey;
  final String _developerApplicationKey;
  final _client = DioClient();
  late String _tokenUrl;
  late String _apiUrl;

  PixBB({
    required Ambiente ambiente,
    required String basicKey,
    required String developerApplicationKey,
  })  : _ambiente = ambiente,
        _basicKey = basicKey,
        _developerApplicationKey = developerApplicationKey {
    _changeAmbiente();
  }

  _changeAmbiente() {
    switch (_ambiente) {
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

  /// Retrieves a valid token from the API.
  ///
  /// Returns a [Future] with a [Token] object representing the token.
  ///
  /// Throws a [PixException] if there's an error while fetching the token.
  Future<Token> getToken() {
    final repository = TokenRepository(_client);
    return repository
        .getToken(url: _tokenUrl, basicKey: _basicKey)
        .getOrThrow();
  }

  /// Retrieves a list of transactions from the API.
  ///
  /// [token] is a valid [Token] object used for authentication.
  ///
  /// [dateTimeRange] is an optional [DateTimeRange] object representing the range of dates to retrieve transactions from.
  ///
  /// Returns a [Future] with a [List] of [Pix] objects representing the transactions.
  ///
  /// Throws a [PixException] if there's an error while fetching the transactions.
  Future<List<Pix>> fetchTransactions({
    required Token token,
    DateTimeRange? dateTimeRange,
  }) {
    final repository = FetchTransactionsRepository(_client);
    final response = repository.fetchTransactions(
      token,
      url: _apiUrl,
      developerApplicationKey: _developerApplicationKey,
      dateTimeRange: dateTimeRange,
    );
    return response.getOrThrow();
  }
}
