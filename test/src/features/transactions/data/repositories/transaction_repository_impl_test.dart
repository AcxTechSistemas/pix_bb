import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pix_bb/src/errors/pix_exception.dart';
import 'package:pix_bb/src/errors/bb_api_exception.dart';
import 'package:pix_bb/src/features/auth/domain/entities/token.dart';
import 'package:pix_bb/src/features/transactions/data/repositories/transaction_repository_impl.dart';
import 'package:pix_bb/src/core/services/client_service.dart';
import 'package:result_dart/result_dart.dart';

class _MockClientService extends Mock implements ClientService {}

void main() {
  late ClientService client;
  late TransactionRepositoryImpl transactionRepository;
  late Token token;
  const url = 'https://teste.example.com/transactions';
  const developerApplicationKey = 'dev-app-key';

  setUp(() {
    client = _MockClientService();
    transactionRepository = TransactionRepositoryImpl(client);
  });

  token = const Token(
    accessToken: "eyJhbGciOiJSUzI1NiIsIn",
    expiresIn: 300,
    tokenType: "Bearer",
    scope: "pix.read pix.write",
  );

  group('TransactionRepositoryImpl: ', () {
    test('Should return BBApiException if empty application developer key',
        () async {
      final response = await transactionRepository.fetchTransactions(
        token: token,
        url: url,
        developerApplicationKey: '',
      );
      final result = response.exceptionOrNull() as PixException;
      expect(result, isNotNull);
      expect(result.error, equals('empty_app_dev_key'));
    });

    test(
        'Should return BBDateException If DateTimeRange is greater than 4 days',
        () async {
      final twentyDaysAgo = DateTime.now().subtract(const Duration(days: 20));
      final currentDate = DateTime.now();
      final response = await transactionRepository.fetchTransactions(
        token: token,
        url: url,
        developerApplicationKey: developerApplicationKey,
        dateTimeRange: DateTimeRange(start: twentyDaysAgo, end: currentDate),
      );
      final result = response.exceptionOrNull() as PixException;
      expect(result, isNotNull);
      expect(result.error, equals('difference-between-dates-too-long'));
    });

    test('Should return the PIX transactions of a 1-page response', () async {
      when(() => client.get(
            any(),
            headers: any(named: 'headers'),
            queryParameters: any(named: 'queryParameters'),
          )).thenAnswer((_) async => Success(onePageExpectedResponse));

      final response = await transactionRepository.fetchTransactions(
        token: token,
        url: url,
        developerApplicationKey: developerApplicationKey,
      );

      var result = response.getOrNull();
      expect(result, isNotNull);
      expect(result!.length, 1);
      expect(result[0].pagador.nome, equals('VICTOR'));
    });

    test('Should return BBApiException if response does not contain key "pix"',
        () async {
      final expectedResponse = {
        "httpCode": "401",
        "httpMessage": "Unauthorized",
        "moreInformation": "Error information"
      };
      when(() => client.get(any(),
              headers: any(named: 'headers'),
              queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Success(expectedResponse));

      final response = await transactionRepository.fetchTransactions(
        token: token,
        url: url,
        developerApplicationKey: developerApplicationKey,
      );

      var result = response.exceptionOrNull();

      expect(result, isNotNull);
      expect(result, isA<BBApiException>());
    });
  });
}

var onePageExpectedResponse = {
  "parametros": {
    "inicio": "2023-01-01T00:00:00.00-03:00",
    "fim": "2023-01-03T00:00:00.00-03:00",
    "paginacao": {
      "paginaAtual": 0,
      "itensPorPagina": 100,
      "quantidadeDePaginas": 1,
      "quantidadeTotalDeItens": 1
    }
  },
  "pix": [
    {
      "endToEndId": "E00360305",
      "txid": "W4ZD075",
      "valor": "150.00",
      "horario": "2023-01-02T12:54:20.665Z",
      "pagador": {"nome": "VICTOR", "cpf": "02477816144"},
      "infoPagador": ""
    }
  ]
};
