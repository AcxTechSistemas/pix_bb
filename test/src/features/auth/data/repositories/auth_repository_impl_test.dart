import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pix_bb/src/errors/pix_exception.dart';
import 'package:pix_bb/src/errors/bb_api_exception.dart';
import 'package:pix_bb/src/features/auth/domain/entities/token.dart';
import 'package:pix_bb/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:pix_bb/src/core/services/client_service.dart';
import 'package:result_dart/result_dart.dart';

class _MockClientService extends Mock implements ClientService {}

void main() {
  late ClientService client;
  late AuthRepositoryImpl authRepository;
  const url = 'https://teste.example.com/auth';
  const basicKey = 'basic-key';

  setUp(() {
    client = _MockClientService();
    authRepository = AuthRepositoryImpl(client);
  });

  group('AuthRepositoryImpl: ', () {
    test('Should return BBApiException if empty basic key', () async {
      final response = await authRepository.getToken(
        url: url,
        basicKey: '',
      );
      final result = response.exceptionOrNull() as PixException;
      expect(result, isNotNull);
      expect(result.error, equals('empty-basic-key'));
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
              body: any(named: 'body'),
              queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Success(expectedResponse));

      final response = await authRepository.getToken(
        url: url,
        basicKey: basicKey,
      );

      var result = response.getOrThrow();

      expect(result, isNotNull);
      expect(result, isA<Token>());
      expect(result.accessToken, equals(expectedResponse['access_token']));
    });

    test('Should return BBApiException if response does not contain key "access_token"', () async {
      final expectedResponse = {'error': 'type'};

      when(() => client.post(any(),
              headers: any(named: 'headers'),
              body: any(named: 'body'),
              queryParameters: any(named: 'queryParameters')))
          .thenAnswer((_) async => Success(expectedResponse));

      final response = await authRepository.getToken(
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
