import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static final _storage = FlutterSecureStorage();

  static Future<void> storeToken(String accessToken, {String? refreshToken}) async {
    await _storage.write(key: 'accessToken', value: accessToken);
    if (refreshToken != null) {
      await _storage.write(key: 'refreshToken', value: refreshToken);
    }
  }

  static Future<String?> getAccessToken() async {
    return await _storage.read(key: 'accessToken');
  }

  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: 'refreshToken');
  }

  static Future<void> deleteAllTokens() async {
    await _storage.deleteAll();
  }
}