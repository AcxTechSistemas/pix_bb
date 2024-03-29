import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pix_bb/src/errors/bb_api_exception.dart';
import 'package:pix_bb/src/features/fetch_transactions/repositories/fetch_transactions.dart';
import 'package:pix_bb/src/features/token/models/token.dart';
import 'package:pix_bb/src/services/client_service.dart';
import 'package:result_dart/result_dart.dart';

class _MockClientService extends Mock implements ClientService {}

void main() {
  late ClientService client;
  late FetchTransactionsRepository fetchRepository;
  late Token token;
  const url = 'https://teste.example.com/auth';
  const developerApplicationKey = 'dev-app-key';

  setUp(() {
    client = _MockClientService();
    fetchRepository = FetchTransactionsRepository(client);
  });
  token = Token.fromMap({
    "access_token": "eyJhbGciOiJSUzI1NiIsIn",
    "expires_in": 300,
    "refresh_expires_in": 0,
    "token_type": "Bearer",
    "not-before-policy": 0,
    "scope": "pix.read pix.write"
  });

  group('FetchTransactions: ', () {
    test('Should return BBApiExeption if empty application developer key',
        () async {
      final response = await fetchRepository.fetchTransactions(
        token,
        url: url,
        developerApplicationKey: '',
      );
      final result = response.exceptionOrNull();
      expect(result, isNotNull);
      expect(result!.error, equals('empty_app_dev_key'));
    });
    test('Should return BBDateExeption If DateTimeRange is greater than 4 days',
        () async {
      final twentyDaysAgo = DateTime.now().subtract(const Duration(days: 20));
      final currentDate = DateTime.now();
      final response = await fetchRepository.fetchTransactions(
        token,
        url: url,
        developerApplicationKey: developerApplicationKey,
        dateTimeRange: DateTimeRange(start: twentyDaysAgo, end: currentDate),
      );
      final result = response.exceptionOrNull();
      expect(result, isNotNull);
      expect(result!.error, equals('difference-between-dates-too-long'));
    });
    test('Should return BBApiException if invalid format credentials',
        () async {
      when(() => client.get(
            any(),
            headers: any(named: 'headers'),
            queryParameters: any(named: 'queryParameters'),
          )).thenAnswer((_) async => Failure(BBApiException(
            error: 'invalid_client',
            errorDescription: 'Credenciais em formato invalido.',
          )));

      final response = await fetchRepository.fetchTransactions(
        token,
        url: url,
        developerApplicationKey: developerApplicationKey,
      );
      final result = response.exceptionOrNull();
      expect(result, isNotNull);
      expect(result!.error, equals('invalid_client'));
      expect(
        result.errorDescription,
        equals('Credenciais em formato invalido.'),
      );
    });
    test('Should return the PIX transactions of a 1-page response', () async {
      when(() => client.get(
            any(),
            headers: any(named: 'headers'),
            queryParameters: any(named: 'queryParameters'),
          )).thenAnswer((_) async => Success(onePageExpectedResponse));

      final response = await fetchRepository.fetchTransactions(
        token,
        url: url,
        developerApplicationKey: developerApplicationKey,
      );

      var result = response.getOrNull();
      expect(result, isNotNull);
      expect(result!.length, 1);
      expect(result[0].pagador.nome, equals('VICTOR'));
    });

    test('Should return the PIX transactions of a multiple pages response',
        () async {
      when(() => client.get(
            any(),
            headers: any(named: 'headers'),
            queryParameters: any(named: 'queryParameters'),
          )).thenAnswer((_) async => Success(multiplePageExpectedResponse));

      final response = await fetchRepository.fetchTransactions(
        token,
        url: url,
        developerApplicationKey: developerApplicationKey,
      );

      var result = response.getOrNull();
      expect(result, isNotNull);
      expect(result!.length, 20);
      expect(result[0].pagador.nome, equals('VICTOR'));
    });

    test('Should return BBApiException if response not contains key "pix" ',
        () async {
      final expectedResponse = {
        "httpCode": "401",
        "httpMessage": "Unauthorized",
        "moreInformation":
            "Cannot pass the security checks that are required by the target API or operation, Enable debug headers for more details."
      };
      when(() => client.get(any(),
              headers: any(named: 'headers'),
              queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Success(expectedResponse));

      final response = await fetchRepository.fetchTransactions(
        token,
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
      "quantidadeTotalDeItens": 4
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

var multiplePageExpectedResponse = {
  "parametros": {
    "inicio": "2023-01-01T00:00:00.00-03:00",
    "fim": "2023-01-03T00:00:00.00-03:00",
    "paginacao": {
      "paginaAtual": 0,
      "itensPorPagina": 100,
      "quantidadeDePaginas": 20,
      "quantidadeTotalDeItens": 4
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
