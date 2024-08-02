import 'dart:convert';

import 'package:Bloguee/model/postModel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:Bloguee/model/postFiles.dart';
import 'package:Bloguee/model/profiles.dart';
import 'package:http/http.dart' as http;

// const url = String.fromEnvironment('BASEURL', defaultValue: '');

class RemoteAuthService {
  var client = http.Client();
  final storage = FlutterSecureStorage();

  // String url =
  //     String.fromEnvironment('BASEURL', defaultValue: 'localhost:1337');

  String? url = dotenv.env["BASEURL"];
  Future<dynamic> signUp({
    required String email,
    required String password,
  }) async {
    var body = {"username": email, "email": email, "password": password};
    var response = await client.post(
      Uri.parse('$url/auth/local/register'),
      headers: {"Content-Type": "application/json"},
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
      Uri.parse('$url/auth/local'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
    return response;
  }

  Future<dynamic> createProfile({
    required String lname,
    required String token,
  }) async {
    var body = {"lname": lname};
    var response = await client.post(
      Uri.parse('$url/profiles/me'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonEncode(body),
    );
    return response;
  }

  Future<dynamic> getProfile({
    required String token,
  }) async {
    var response = await client.get(
      Uri.parse('$url/profiles/me'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    return response;
  }

  Future<Map> chunk({
    required String? chunkId,
    required String? token,
  }) async {
    var response = await client.get(
      Uri.parse('$url/chunks/$chunkId'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    var itens = json.decode(response.body);
    return itens;
  }

  Future addPost({
    required String? title,
    required String? desc,
    required String? content,
    required int? profileId,
    required int? chunkId,
    required String? token,
    required bool? fixedChunk,
  }) async {
    final body = {
      "title": title.toString(),
      "desc": desc.toString(),
      "content": content.toString(),
      "profile": profileId.toString(),
      "chunk": chunkId.toString(),
      "chunkfixed": fixedChunk.toString()
    };
    var response = await client.post(
      Uri.parse('$url/posts'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonEncode(body),
    );
    return response;
  }

  Future<List<PostsModel>> getPosts(
      {required String? token, required String? chunkId}) async {
    List<PostsModel> listItens = [];
    var response = await client.get(
      Uri.parse('$url/posts?chunk.id_eq=$chunkId'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body;
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(PostsModel.fromJson(itemCount[i]));
    }
    return listItens;
  }

  Future<Map> getPost(
      {required String token,
      required String id,
      required String? chunkId}) async {
    var response = await client.get(
      Uri.parse('$url/posts/$id?chunk.id_eq=$chunkId'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    var itens = json.decode(response.body);
    return itens;
  }

  Future<List<PostFiles>> getPostsFiles(
      {required String? token, required String? id}) async {
    List<PostFiles> listItens = [];
    var response = await client.get(
      Uri.parse('$url/posts/${id}'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body["files"];
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(PostFiles.fromJson(itemCount[i]));
    }
    return listItens;
  }

  Future<List<PostsModel>> getPostSearch(
      {required String token,
      required String query,
      required String chunkId}) async {
    List<PostsModel> listItens = [];
    var response = await client.get(
      Uri.parse("$url/posts?title_contains=$query&chunk.id_eq=$chunkId"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body;
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(PostsModel.fromJson(itemCount[i]));
    }
    return listItens;
  }

  Future<List<ProfilesModel>> getProfiles(
      {required String? token, required String? chunkId}) async {
    List<ProfilesModel> listItens = [];
    var response = await client.get(
      Uri.parse('$url/profiles?chunk.id_eq=$chunkId'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body;
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(ProfilesModel.fromJson(itemCount[i]));
    }
    return listItens;
  }
}
