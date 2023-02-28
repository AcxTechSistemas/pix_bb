/// A class representing an access token returned by an authentication API.
///
/// This class contains information about the token, including its value, type,
/// expiration time, and scope.
class Token {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final String scope;

  Token({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.scope,
  });

  /// A factory method for creating a [Token] object from a JSON object.
  ///
  /// This method takes a [Map<String, dynamic>] object and returns a new instance of [Token] class.
  ///
  /// The following keys must be present in the input JSON object:
  /// - 'access_token': the value of the access token.
  /// - 'token_type': the type of the token.
  /// - 'expires_in': the number of seconds until the token expires.
  /// - 'scope': the scope of the token.
  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      expiresIn: json['expires_in'],
      scope: json['scope'],
    );
  }

  /// A method for serializing the [Token] object to a JSON object.
  ///
  /// This method returns a [Map<String, dynamic>] object representing the [Token] object.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    data['expires_in'] = expiresIn;
    data['scope'] = scope;
    return data;
  }
}
