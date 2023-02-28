import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pix_bb/src/error/pix_error.dart';
import 'package:pix_bb/src/models/token_body.dart';
import 'package:pix_bb/src/repositories/token_repository.dart';
import 'package:pix_bb/src/services/client_service.dart';

class MockServiceClient extends Mock implements ClientService {}

void main() {
  late ClientService client;
  late TokenRepository repository;
  const basicKey = '123';
  const url = 'https://example.com.br/oauth/token';

  setUp(() {
    client = MockServiceClient();
    repository = TokenRepository(client, url);
  });

  test('Expect receive Token', () async {
    when(() => client.post(
          any(),
          headers: any(named: 'headers'),
          queryParameters: any(named: 'queryParameters'),
        )).thenAnswer((_) async => jsonDecode(jsonResponse));
    final response = await repository.getToken(basicKey: basicKey);
    expect(response, isA<Token>());
    expect(response.accessToken, isNotNull);
    expect(response.expiresIn, isNotNull);
    expect(response.scope, isNotNull);
    expect(response.tokenType, isNotNull);
  });

  test('Expect receive PixError', () async {
    when(() => client.post(
          any(),
          headers: any(named: 'headers'),
          queryParameters: any(named: 'queryParameters'),
        )).thenThrow(PixError());
    try {
      await repository.getToken(basicKey: '');
      fail('Expected PixError to be thrown');
    } on PixError catch (e) {
      expect(e, isA<PixError>());
    }
  });
}

const jsonResponse = '''
{
  "access_token": "PMHFioGV6LSpEQA2unv0U",
  "token_type": "Bearer",
  "expires_in": 600,
  "scope": "pix.read"
}
''';
