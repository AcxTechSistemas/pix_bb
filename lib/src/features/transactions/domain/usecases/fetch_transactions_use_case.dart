import 'package:flutter/material.dart';
import 'package:pix_bb/src/features/auth/domain/entities/token.dart';
import 'package:pix_bb/src/features/transactions/domain/entities/pix.dart';
import 'package:pix_bb/src/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:result_dart/result_dart.dart';

class FetchTransactionsUseCase {
  final ITransactionRepository _repository;

  FetchTransactionsUseCase(this._repository);

  Future<Result<List<Pix>>> call({
    required Token token,
    required String url,
    required String developerApplicationKey,
    DateTimeRange? dateTimeRange,
  }) {
    return _repository.fetchTransactions(
      token: token,
      url: url,
      developerApplicationKey: developerApplicationKey,
      dateTimeRange: dateTimeRange,
    );
  }
}
