import 'package:flutter/material.dart';
import 'package:pix_bb/src/features/auth/domain/entities/token.dart';
import 'package:pix_bb/src/features/transactions/domain/entities/pix.dart';
import 'package:result_dart/result_dart.dart';

abstract class ITransactionRepository {
  Future<Result<List<Pix>>> fetchTransactions({
    required Token token,
    required String url,
    required String developerApplicationKey,
    DateTimeRange? dateTimeRange,
  });
}
