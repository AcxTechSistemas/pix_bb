import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pix_bb/src/error/date_exception.dart';
import 'package:pix_bb/src/error/pix_error.dart';
import 'package:pix_bb/src/models/pix.dart';
import 'package:pix_bb/src/repositories/pix_repository.dart';
import 'package:pix_bb/src/services/client_service.dart';

class MockServiceClient extends Mock implements ClientService {}

void main() {
  late ClientService client;
  late PixRepository repository;
  late DateException dateException;
  const url = 'https://example.com.br/oauth/token';
  const developerApplicationKey = '123';
  const accessToken = '123';

  setUp(() {
    client = MockServiceClient();
    repository = PixRepository(client, url);
    dateException = DateException(
      errorCode: 1001,
    );
  });

  test('Expect a return list transactions', () async {
    when(() => client.get(
          any(),
          headers: any(named: 'headers'),
          queryParameters: any(named: 'queryParameters'),
        )).thenAnswer((_) async => jsonDecode(jsonResponse));
    try {
      final response = await repository.getRecentReceivedTransactions(
        accessToken: accessToken,
        developerApplicationKey: developerApplicationKey,
      );
      expect(response, isA<List<Pix>>());
    } on PixError catch (e) {
      expect(e, isA<PixError>());
    }
  });

  test('Expect receive errorType PixError on getRecentReceivedTransactions',
      () async {
    when(() => client.get(
          any(),
          headers: any(named: 'headers'),
          queryParameters: any(named: 'queryParameters'),
        )).thenThrow(PixError(exception: DioError));
    try {
      await repository.getRecentReceivedTransactions(
        accessToken: '',
        developerApplicationKey: '',
      );
      fail('Expected PixError to be thrown');
    } on PixError catch (e) {
      expect(e, isA<PixError>());
    }
  });

  test('Expect a return list transactions for dated input', () async {
    when(() => client.get(
          any(),
          headers: any(named: 'headers'),
          queryParameters: any(named: 'queryParameters'),
        )).thenAnswer((_) async => jsonDecode(jsonResponse));
    try {
      final response = await repository.getTransactionsByDate(
        initialDate: DateTime.now().subtract(const Duration(days: 4)),
        finalDate: DateTime.now(),
        accessToken: accessToken,
        developerApplicationKey: developerApplicationKey,
      );
      expect(response, isA<List<Pix>>());
    } on PixError catch (e) {
      fail('Expected List Transactions Pix received: $e');
    }
  });

  test('Expect receive errorCode: 1001 on getTransactionsByDate', () async {
    when(() => client.get(
          any(),
          headers: any(named: 'headers'),
          queryParameters: any(named: 'queryParameters'),
        )).thenThrow(PixError(dateException: dateException));
    try {
      await repository.getTransactionsByDate(
        accessToken: '',
        developerApplicationKey: '',
        initialDate: DateTime.now().subtract(const Duration(days: 6)),
        finalDate: DateTime.now(),
      );
      fail('Expected PixError to be thrown');
    } on PixError catch (e) {
      expect(e.errorCode, 1001);
    }
  });
}

const jsonResponse = '''
{
    "pix": [
        {
            "endToEndId": "E00000000202301051000000000000000",
            "valor": "140.00",
            "horario": "2023-01-05T07:08:05.00-03:00",
            "pagador": {
                "cpf": "0000000000",
                "nome": "Cliente"
            },
            "infoPagador": "Pagamento"
        },
        {
            "endToEndId": "E00000000202301051000000000000000",
            "valor": "140.00",
            "horario": "2023-01-05T07:08:05.00-03:00",
            "pagador": {
                "cpf": "0000000000",
                "nome": "Cliente"
            },
            "infoPagador": "Pagamento"
        }
    ],
    "parametros": {
        "inicio": "2023-01-05T00:00:00.00-03:00",
        "fim": "2023-01-07T00:00:00.00-03:00",
        "paginacao": {
            "paginaAtual": 0,
            "itensPorPagina": 50,
            "quantidadeDePaginas": 1,
            "quantidadeTotalDeItens": 18
        }
    }
}
''';
