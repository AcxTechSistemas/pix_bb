abstract class PixErrorInterface implements Exception {
  String? get message;
  int? get errorCode;
  Map<String, dynamic>? get errorData;
}
