import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../const.dart';


class RemoteAuthService {
  var client = http.Client();
  final storage = FlutterSecureStorage();

  Future<dynamic> signUp({
    required String email,
    required String password,
  }) async {
    var body = {"username": email, "email": email, "password": password};
    var response = await client.post(
      Uri.parse('${dotenv.get('BASEURL').toString()}/api/auth/local/register'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
    return response;
  }

  Future<dynamic> createProfile({
    required String fullName,
    required String token,
  }) async {
    var body = {"fullName": fullName};
    var response = await client.post(
      Uri.parse('${dotenv.get('BASEURL').toString()}/api/profile/me'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonEncode(body),
    );
    return response;
  }

  Future<dynamic> signIn({
    required String email,
    required String password,
  }) async {
    var body = {"identifier": email, "password": password};
    var response = await client.post(
      Uri.parse('${dotenv.get('BASEURL').toString()}/api/auth/local'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
    return response;
  }

  Future<dynamic> getProfile({
    required String token,
  }) async {
    var response = await client.get(
      Uri.parse('${dotenv.get('BASEURL').toString()}/api/profile/me'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    return response;
  }

  

  Future addPost({
    required String content,
    required String token,
  }) async {
    final body = {"content": content};
    var response = await client.post(
      Uri.parse('${dotenv.get('BASEURL').toString()}/api/post/me'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonEncode(body),
    );
    return response;
  }

  Future addComplaint({
    required String type,
    required String nivel,
    required String desc,
    required String token,
  }) async {
    final body = {
      "type": type,
      "nivel": nivel,
      "desc": desc
    };
    var response = await client.post(
      Uri.parse('${dotenv.get('BASEURL').toString()}/api/complaint/me'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonEncode(body),
    );
    return response;
  }
}