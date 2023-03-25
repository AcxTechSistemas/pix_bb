import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pix_bb/src/errors/bb_date_exception.dart';
import 'package:pix_bb/src/errors/pix_exception_interface.dart';
import 'package:pix_bb/src/features/token/models/token.dart';
import 'package:pix_bb/src/services/client_service.dart';
import 'package:result_dart/result_dart.dart';

import '../../../errors/bb_api_exception.dart';
import '../../../errors/bb_unknown_exception.dart';
import '../models/parametros.dart';
import '../models/pix.dart';

/// A repository for fetching Pix transactions from the Banco do Brasil's API.
class FetchTransactionsRepository {
  /// Instance of the [ClientService] used to make API calls
  final ClientService _client;

  /// Instance of the [Parametros] used to make API calls
  late Parametros _parametros;

  /// Constructor for [FetchTransactionsRepository] that receives a [ClientService]
  FetchTransactionsRepository(ClientService client) : _client = client;

  /// Method that fetches transactions from the Pix API and returns a [Result] object
  ///
  /// - The [token] parameter is a [Token] object containing the access token and token type
  /// - The [url] parameter is the [Url] endpoint for fetching transactions
  /// - The [dateTimeRange] parameter is an optional [DateTimeRange] used to filter the transactions by date
  ///
  /// - Returns a [Success] object containing a list of [Pix] objects if successful
  /// - Returns a [Failure] object containing a [PixException] if unsuccessful
  Future<Result<List<Pix>, PixException>> fetchTransactions(
    Token token, {
    required String url,
    required String developerApplicationKey,
    DateTimeRange? dateTimeRange,
  }) async {
    if (developerApplicationKey.isEmpty) {
      throw BBApiException.apiError(
          {'message': 'Developer Application Key is empty or not defined'});
    }
    if (dateTimeRange != null &&
        dateTimeRange.duration >= const Duration(days: 5)) {
      throw BBDateException.differenceBetweenDatesTooLong(dateTimeRange);
    }
    List<Pix> pixTransactions = [];
    try {
      final response = await _callApi(
        token,
        url: url,
        developerApplicationKey: developerApplicationKey,
        dateTimeRange: dateTimeRange,
      );

      _parametros = Parametros.fromMap(response['parametros']);

      if (_parametros.paginacao.quantidadeDePaginas <= 1) {
        var transactions = response['pix'] as List;
        var receivedPix = transactions.map((e) => Pix.fromMap(e)).toList();
        pixTransactions.addAll(receivedPix);
        final reversedList = pixTransactions.reversed.toList();
        return Success(reversedList);
      } else {
        for (var i = 0; i < _parametros.paginacao.quantidadeDePaginas; i++) {
          final paginaAtual = i.toString();
          final multiplePagesResponse = await _callApi(
            token,
            url: url,
            developerApplicationKey: developerApplicationKey,
            dateTimeRange: dateTimeRange,
            paginaAtual: paginaAtual,
          );
          var transactions = multiplePagesResponse['pix'] as List;
          var receivedPix = transactions.map((e) => Pix.fromMap(e)).toList();
          pixTransactions.addAll(receivedPix);
        }
        final reversedList = pixTransactions.reversed.toList();
        return Success(reversedList);
      }
    } on PixException catch (e) {
      return Failure(e);
    }
  }

  /// Private method that makes the API call and returns a map of the response
  ///
  /// - The [token] parameter is a [Token] object containing the access token and token type
  /// - The [url] parameter is the [Url] endpoint for fetching transactions
  /// - The [dateTimeRange] parameter is an optional [DateTimeRange] used to filter the transactions by date
  /// - The [paginaAtual] parameter is an optional [String] used to specify the page number of the transaction results
  ///
  /// - Returns a [Map] containing the response from the API call
  ///
  /// - Throws a [BBApiException] or [BBUnknownException] if there's an error making the API call
  Future<Map<String, dynamic>> _callApi(
    Token token, {
    required String developerApplicationKey,
    required String url,
    required DateTimeRange? dateTimeRange,
    String paginaAtual = '0',
  }) async {
    final fourdaysAgo = DateTime.now().subtract(const Duration(days: 4));
    final currentDate = DateTime.now();

    final initialDate =
        formatToIso8601TimeZone(date: dateTimeRange?.start ?? fourdaysAgo);
    final finalDate =
        formatToIso8601TimeZone(date: dateTimeRange?.end ?? currentDate);

    final queryParameters = {
      'paginaAtual': paginaAtual,
      'gw-dev-app-key': developerApplicationKey,
      'inicio': initialDate,
      'fim': finalDate,
    };
    final response = await _client.get(
      url,
      headers: {'Authorization': '${token.tokenType} ${token.accessToken}'},
      queryParameters: queryParameters,
    );
    return response.fold(
      (success) {
        if (success.containsKey('pix')) {
          return success;
        } else {
          throw BBApiException.apiError(success);
        }
      },
      (failure) {
        throw failure;
      },
    );
  }
}

/// Private method that formats a [DateTime] object to ISO 8601 format with time zone information
///
/// - The [date] parameter is a [DateTime] object to be formatted
///
/// - Returns a [String] containing the formatted date string
String formatToIso8601TimeZone({required DateTime date}) {
  String toIso8601TimeZone =
      DateFormat('yyyy-MM-ddThh:mm:ss.00-03:00').format(date);
  return toIso8601TimeZone;
}
