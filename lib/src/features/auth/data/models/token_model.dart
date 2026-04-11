import 'dart:convert';
import 'package:pix_bb/src/features/auth/domain/entities/token.dart';

class TokenModel extends Token {
  const TokenModel({
    required super.accessToken,
    required super.tokenType,
    required super.expiresIn,
    required super.scope,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'access_token': accessToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
      'scope': scope,
    };
  }

  factory TokenModel.fromMap(Map<String, dynamic> map) {
    return TokenModel(
      accessToken: map['access_token'] as String,
      tokenType: map['token_type'] as String,
      expiresIn: map['expires_in'] as int,
      scope: map['scope'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TokenModel.fromJson(String source) =>
      TokenModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
