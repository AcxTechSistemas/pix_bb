import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:pix_bb/src/error/date_exception.dart';
import 'package:pix_bb/src/error/pix_error.dart';
import 'package:pix_bb/src/models/pix.dart';
import 'package:pix_bb/src/services/client_service.dart';
import '../models/parametros.dart';

class PixRepository {
  final ClientService client;
  List<Pix> pixTransactions = [];
  late Parametros parametros;
  final String url;

  PixRepository(this.client, this.url);

  Future<List<Pix>> getRecentReceivedTransactions({
    required String accessToken,
    required String developerApplicationKey,
  }) async {
    final currentDate = DateTime.now();
    final initialDate = currentDate.subtract(const Duration(days: 4));
    final finalDate = currentDate;

    final response = await _getTransactions(
      initialDate,
      finalDate,
      accessToken,
      developerApplicationKey,
    );

    for (var transaction in response['pix']) {
      pixTransactions.add(Pix.fromJson(transaction));
    }
    return pixTransactions;
  }

  Future<List<Pix>> getTransactionsByDate({
    required String accessToken,
    required String developerApplicationKey,
    required DateTime initialDate,
    required DateTime finalDate,
  }) async {
    if (finalDate.difference(initialDate).inDays > 4) {
      log(
        '''Difference between start date and end date cannot be greater than 4 days
        Initial Date: $initialDate,
        Final Date: $finalDate,
        Difference: ${finalDate.difference(initialDate).inDays}
        ''',
        error: 1001,
      );
      throw PixError(
        exception: DateException(
          message: 'Difference between start date and end date cannot be greater than 4 days',
          errorCode: 1001,
          errorData: {
            'error': 'Difference_between_dates_too_long',
            'initialDate': initialDate,
            'finalDate': finalDate,
            'difference': finalDate.difference(initialDate).inDays,
          },
        ),
      );
    } else {
      final response = await _getTransactions(
        initialDate,
        finalDate,
        accessToken,
        developerApplicationKey,
      );

      parametros = Parametros.fromJson(response['parametros']);

      if (parametros.paginacao.quantidadeDePaginas == 1) {
        for (var pix in response['pix']) {
          pixTransactions.add(Pix.fromJson(pix));
        }
        return pixTransactions;
      } else {
        for (var i = 0; i < parametros.paginacao.quantidadeDePaginas; i++) {
          final paginaAtual = i.toString();

          final response = await _getTransactions(
            initialDate,
            finalDate,
            accessToken,
            developerApplicationKey,
            paginaAtual: paginaAtual,
          );

          for (var pix in response['pix']) {
            pixTransactions.add(Pix.fromJson(pix));
          }
        }
        return pixTransactions;
      }
    }
  }

  Future<dynamic> _getTransactions(
    DateTime initialDate,
    DateTime finalDate,
    String accessToken,
    String developerApplicationKey, {
    String paginaAtual = '0',
  }) async {
    final formattedInitialDate = formatToIso8601TimeZone(date: initialDate);
    final formattedFinalDate = formatToIso8601TimeZone(date: finalDate);

    final headers = {'Authorization': 'Bearer $accessToken'};

    final queryParameters = {
      'paginaAtual': paginaAtual,
      'gw-dev-app-key': developerApplicationKey,
      'inicio': formattedInitialDate,
      'fim': formattedFinalDate,
    };
    try {
      final response = await client.get(
        url,
        headers: headers,
        queryParameters: queryParameters,
      );
      return response;
    } on DioError catch (e) {
      throw PixError(dioError: e);
    }
  }
}

String formatToIso8601TimeZone({required DateTime date}) {
  String toIso8601TimeZone = DateFormat('yyyy-MM-ddThh:mm:ss.00-03:00').format(date);
  return toIso8601TimeZone;
}
