import 'package:flutter/material.dart';
import 'package:pix_bb/src/core/utils/date_formatter.dart';
import 'package:pix_bb/src/errors/bb_api_exception.dart';
import 'package:pix_bb/src/errors/bb_date_exception.dart';
import 'package:pix_bb/src/errors/pix_exception.dart';
import 'package:pix_bb/src/features/auth/domain/entities/token.dart';
import 'package:pix_bb/src/features/transactions/data/models/pix_model.dart';
import 'package:pix_bb/src/features/transactions/data/models/pix_pagination_model.dart';
import 'package:pix_bb/src/features/transactions/domain/entities/pix.dart';
import 'package:pix_bb/src/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:pix_bb/src/core/services/client_service.dart';
import 'package:result_dart/result_dart.dart';

class TransactionRepositoryImpl implements ITransactionRepository {
  final ClientService _client;

  TransactionRepositoryImpl(this._client);

  @override
  Future<Result<List<Pix>>> fetchTransactions({
    required Token token,
    required String url,
    required String developerApplicationKey,
    DateTimeRange? dateTimeRange,
  }) async {
    if (developerApplicationKey.isEmpty) {
      return Failure(BBApiException.apiError({
        'error': 'empty_app_dev_key',
        'error_description': 'Developer Application Key is empty or not defined',
      }));
    }

    if (dateTimeRange != null && dateTimeRange.duration >= const Duration(days: 5)) {
      return Failure(BBDateException.differenceBetweenDatesTooLong(dateTimeRange));
    }

    try {
      final List<Pix> allTransactions = [];

      // Fetch first page
      final firstPageResult = await _callApi(
        token: token,
        url: url,
        developerApplicationKey: developerApplicationKey,
        dateTimeRange: dateTimeRange,
        paginaAtual: 0,
      );

      final firstPageParams = TransactionParamsModel.fromMap(firstPageResult['parametros']);
      final transactions = (firstPageResult['pix'] as List).map((e) => PixModel.fromMap(e)).toList();
      allTransactions.addAll(transactions);

      final totalPages = firstPageParams.paginacao.quantidadeDePaginas;

      // Fetch remaining pages if any
      if (totalPages > 1) {
        for (int i = 1; i < totalPages; i++) {
          final pageResult = await _callApi(
            token: token,
            url: url,
            developerApplicationKey: developerApplicationKey,
            dateTimeRange: dateTimeRange,
            paginaAtual: i,
          );
          final pageTransactions = (pageResult['pix'] as List).map((e) => PixModel.fromMap(e)).toList();
          allTransactions.addAll(pageTransactions);
        }
      }

      return Success(allTransactions.reversed.toList());
    } on PixException catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(BBApiException.apiError({
        'error': 'unknown-error',
        'error_description': e.toString(),
      }));
    }
  }

  Future<Map<String, dynamic>> _callApi({
    required Token token,
    required String url,
    required String developerApplicationKey,
    required DateTimeRange? dateTimeRange,
    int paginaAtual = 0,
  }) async {
    final fourDaysAgo = DateTime.now().subtract(const Duration(days: 4));
    final currentDate = DateTime.now();

    final inicio = BbDateFormatter.formatToIso8601WithOffset(dateTimeRange?.start ?? fourDaysAgo);
    final fim = BbDateFormatter.formatToIso8601WithOffset(dateTimeRange?.end ?? currentDate);

    final queryParameters = {
      'paginaAtual': paginaAtual.toString(),
      'gw-dev-app-key': developerApplicationKey,
      'inicio': inicio,
      'fim': fim,
    };

    final response = await _client.get(
      '$url/pix',
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
      (failure) => throw failure,
    );
  }
}
