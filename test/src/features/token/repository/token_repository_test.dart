import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pix_bb/src/errors/bb_api_exception.dart';
import 'package:pix_bb/src/features/token/models/token.dart';
import 'package:pix_bb/src/features/token/repository/token_repository.dart';
import 'package:pix_bb/src/services/client_service.dart';
import 'package:result_dart/result_dart.dart';

class _MockClientService extends Mock implements ClientService {}

void main() {
  late ClientService client;
  late TokenRepository tokenRepository;
  const url = 'https://teste.example.com/auth';
  const basicKey = 'basic-key';

  setUp(() {
    client = _MockClientService();
    tokenRepository = TokenRepository(client);
  });

  group('Token: ', () {
    test('Should return BBApiExeption if empty basic key', () async {
      final response = await tokenRepository.getToken(
        url: url,
        basicKey: '',
      );
      final result = response.exceptionOrNull();
      expect(result, isNotNull);
      expect(result!.error, equals('empty-basic-key'));
    });
    test('Should return Token', () async {
      final expectedResponse = {
        'access_token': '234k-vkhk-l1h2-3l3l',
        'token_type': 'Bearer',
        'expires_in': 20,
        'scope': 'pix.read',
      };

      when(() => client.post(any(),
              headers: any(named: 'headers'),
              queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Success(expectedResponse));

      final response = await tokenRepository.getToken(
        url: url,
        basicKey: basicKey,
      );

      var result = response.getOrThrow();

      expect(result, isNotNull);
      expect(result, isA<Token>());
      expect(result.accessToken, equals(expectedResponse['access_token']));
    });

    test(
        'Should return BBApiException if response not contains key "access_token" ',
        () async {
      final expectedResponse = {'error': 'type'};

      when(() => client.post(any(),
              headers: any(named: 'headers'),
              queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Success(expectedResponse));

      final response = await tokenRepository.getToken(
        url: url,
        basicKey: basicKey,
      );
      var result = response.exceptionOrNull() as BBApiException;

      expect(result, isA<BBApiException>());
      expect(result.error, isNotNull);
      expect(result.errorDescription, contains('error'));
    });
  });
}
