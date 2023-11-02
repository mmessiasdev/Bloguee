import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalAuthService {
  final _storage = FlutterSecureStorage();

  Future<void> storeToken(String token) async {
    await _storage.write(key: "token", value: token);
  }

  Future<String?> getSecureToken(String token) async {
    return await _storage.read(key: "token");
  } 

  Future storeEmail(
      {required String email,
      required String full,
      required String id}) async {
    await _storage.write(key: "id", value: id);
    await _storage.write(key: "email", value: email);
    await _storage.write(key: "full", value: full);
  }

  Future<String?> getEmail(String unicKey) async {
    return await _storage.read(key: "email");
  }

  Future<String?> getId(String unicKey) async {
    return await _storage.read(key: "id");
  }

  Future<String?> getFull(String unicKey) async {
    return await _storage.read(key: "full");
  }

  Future<void> clear() async {
    await _storage.deleteAll();
  }
}
