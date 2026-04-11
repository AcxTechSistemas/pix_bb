import 'package:equatable/equatable.dart';

/// This class represents an OAuth2 access token, which is used for client authentication and authorization.
class Token extends Equatable {
  /// The access token string
  final String accessToken;

  /// The type of the token, e.g. "Bearer".
  final String tokenType;

  /// The lifetime of the access token in seconds
  final int expiresIn;

  /// The scope of the token, e.g. "pix.read".
  final String scope;

  const Token({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.scope,
  });

  @override
  List<Object?> get props => [accessToken, tokenType, expiresIn, scope];
}
