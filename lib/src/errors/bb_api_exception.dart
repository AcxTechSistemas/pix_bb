// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'pix_exception_interface.dart';

enum ApiExceptionType {
  applicationKeyNotAllowed,
  invalidCredentialsFormat,
  incorrectCredentials,
  basicKeyCannotBeEmpty,
  developerApplicationKeyCannotBeEmpty,
  unknown,
}

/// An exception representing an error response from the Banco do Brasil's API.
class BBApiException implements PixException {
  final String _error;

  final Map<String, dynamic> _errorData;

  final ApiExceptionType _type;

  BBApiException({
    required String error,
    required Map<String, dynamic> errorData,
    required ApiExceptionType type,
  })  : _error = error,
        _errorData = errorData,
        _type = type;

  /// The error message returned by the API.
  @override
  dynamic get message => _error;

  /// The error message returned by the API.
  dynamic get errorData => _errorData;

  /// The type of exception, which in this case is always [ApiErrorType.apiErrorType].
  @override
  Enum get exceptionType => _type;

  /// Creates a new [PixException] instance for an API error with the given [error].
  static PixException apiError(Map<String, dynamic> errorMap) {
    String errorMessage = 'uncaughtError';

    if (errorMap.containsKey('error_description')) {
      errorMessage = errorMap['error_description'];
    } else if (errorMap.containsKey('message')) {
      errorMessage = errorMap['message'];
    }

    if (errorMessage.contains('Application key is not allowed')) {
      return BBApiException(
        error: errorMessage,
        errorData: errorMap,
        type: ApiExceptionType.applicationKeyNotAllowed,
      );
    } else if (errorMessage.contains('Credenciais em formato invalido')) {
      return BBApiException(
        error: errorMessage,
        errorData: errorMap,
        type: ApiExceptionType.invalidCredentialsFormat,
      );
    } else if (errorMessage.contains('Software cliente não identificado')) {
      return BBApiException(
        error: errorMessage,
        errorData: errorMap,
        type: ApiExceptionType.incorrectCredentials,
      );
    } else if (errorMessage.contains('BasicKey is empty or not defined')) {
      return BBApiException(
        error: 'Basic key está vazia ou não definida',
        errorData: errorMap,
        type: ApiExceptionType.basicKeyCannotBeEmpty,
      );
    } else if (errorMessage
        .contains('Developer Application Key is empty or not defined')) {
      return BBApiException(
        error: 'Developer Application Key está vazia ou não definida',
        errorData: errorMap,
        type: ApiExceptionType.developerApplicationKeyCannotBeEmpty,
      );
    } else {
      return BBApiException(
        error: errorMessage,
        errorData: errorMap,
        type: ApiExceptionType.unknown,
      );
    }
  }

  /// Returns a string representation of this exception.

  @override
  String toString() => '''BBApiException:
  error: $_error,
  errorData: $_errorData,
  type: $_type''';
}
