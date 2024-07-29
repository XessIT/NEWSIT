import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class SecureStorageService {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<void> writeAccessToken(String token) async {
    await _secureStorage.write(key: 'access_token', value: token);
  }

  Future<String?> readAccessToken() async {
    return await _secureStorage.read(key: 'access_token');
  }

  Future<void> deleteAccessToken() async {
    await _secureStorage.delete(key: 'access_token');
  }

  Future<void> writeRefreshToken(String token) async {
    await _secureStorage.write(key: 'refresh_token', value: token);
  }

  Future<String?> readRefreshToken() async {
    return await _secureStorage.read(key: 'refresh_token');
  }

  Future<void> deleteRefreshToken() async {
    await _secureStorage.delete(key: 'refresh_token');
  }

  Future<void> clearAllTokens() async {
    await _secureStorage.deleteAll();
  }

  Future<bool> isAccessTokenValid() async {
    final token = await readAccessToken();
    if (token == null) {
      return false;
    }
    return !JwtDecoder.isExpired(token);
  }
}
