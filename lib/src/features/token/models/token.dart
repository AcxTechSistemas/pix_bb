// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

/// This class represents an OAuth2 access token, which is used for client authentication and authorization.
class Token {
  /// The access token string
  final String accessToken;

  /// The type of the token, e.g. "Bearer".
  final String tokenType;

  /// The lifetime of the access token in seconds
  final int expiresIn;

  /// The scope of the token, e.g. "pix.read".
  final String scope;

  Token({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.scope,
  });

  /// Returns a [Map] representation of the [Token] instance.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'tokenType': tokenType,
      'expiresIn': expiresIn,
      'scope': scope,
    };
  }

  /// Creates a [Token] instance from a [Map] representation.
  factory Token.fromMap(Map<String, dynamic> map) {
    return Token(
      accessToken: map['access_token'] as String,
      tokenType: map['token_type'] as String,
      expiresIn: map['expires_in'] as int,
      scope: map['scope'] as String,
    );
  }

  /// Converts this [Token] to a JSON-encoded string.
  String toJson() => json.encode(toMap());

  /// Creates a new [Token] object from the given JSON-encoded string.
  factory Token.fromJson(String source) =>
      Token.fromMap(json.decode(source) as Map<String, dynamic>);
}
