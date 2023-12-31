import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:Bloguee/model/postFiles.dart';
import 'package:Bloguee/model/posts.dart';
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
      Uri.parse('$url/api/auth/local/register'),
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
      Uri.parse('$url/api/auth/local'),
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
      Uri.parse('$url/api/profile/me'),
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
      Uri.parse('$url/api/profile/me?populate=*'),
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
      Uri.parse('$url/api/chunks/$chunkId?populate=*'),
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
      "data": {
        "title": title,
        "desc": desc,
        "content": content,
        "profile": profileId,
        "chunk": chunkId,
        "chunkfixed": fixedChunk
      }
    };
    var response = await client.post(
      Uri.parse('$url/api/posts'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonEncode(body),
    );
    return response;
  }

  Future<List<PostsAttributes>> getPosts(
      {required String? token, required String? chunkId}) async {
    List<PostsAttributes> listItens = [];
    var response = await client.get(
      Uri.parse(
          '$url/api/posts?sort=id:DESC&filters[chunk][id][\$eqi]=${chunkId}&populate=*'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body["data"];
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(PostsAttributes.fromJson(itemCount[i]));
    }
    return listItens;
  }

  Future<Map> getPost({required String token, required String id}) async {
    var response = await client.get(
      Uri.parse('$url/api/posts/${id}?populate=*'),
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
      Uri.parse('$url/api/posts/${id}?populate=files'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body["data"]["attributes"]["files"]["data"];
    print(itemCount);
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(PostFiles.fromJson(itemCount[i]));
    }
    return listItens;
  }

  Future<List<PostsAttributes>> getPostSearch(
      {required String token,
      required String query,
      required String chunkId}) async {
    List<PostsAttributes> listItens = [];
    var response = await client.get(
      Uri.parse(
          "$url/api/posts?filters[title][\$containsi]=$query&filters[chunk][id][\$eqi]=$chunkId&populate=*"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body["data"];
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(PostsAttributes.fromJson(itemCount[i]));
    }
    return listItens;
  }

  Future<List<ProfileAttributes>> getProfiles(
      {required String? token, required String? chunkId}) async {
    List<ProfileAttributes> listItens = [];
    var response = await client.get(
      Uri.parse('$url/api/chunks/${chunkId}?populate[profiles][populate]=*'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body["data"]["attributes"]["profiles"]["data"];
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(ProfileAttributes.fromJson(itemCount[i]));
    }
    return listItens;
  }
}
