import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttercode/component/colors.dart';
import 'package:fluttercode/component/header.dart';
import 'package:fluttercode/component/padding.dart';
import 'package:fluttercode/component/post.dart';
import 'package:fluttercode/component/texts.dart';
import 'package:fluttercode/service/local_service/local_auth_service.dart';
import 'package:fluttercode/service/remote_service/remote_auth_service.dart';
import 'package:fluttercode/view/home/home_screen.dart';
import 'package:fluttercode/view/posts/create/createpost.dart';
import 'package:fluttercode/view/posts/post/postscreen.dart';
import 'package:http/http.dart' as http;

import '../../model/posts.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  var client = http.Client();

  var token;

  @override
  void initState() {
    super.initState();
    getString();
  }

  void getString() async {
    var strToken = await LocalAuthService().getSecureToken("token");

    setState(() {
      token = strToken.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MainHeader(
            title: 'Criar',
            onClick: () {
              (Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreatePost(),
                ),
              ));
            }),
        Padding(
          padding: defaultPadding,
          child: Center(
            child: PrimaryText(
              text: 'Ultimos Posts',
              color: nightColor,
              align: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
          height: 300,
          child: FutureBuilder<List<PostsAttributes>>(
              future: RemoteAuthService().getPosts(token: token),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return token == null
                      ? SizedBox()
                      : ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            var render = snapshot.data![index];
                            return Padding(
                              padding: const EdgeInsets.all(12),
                              child: Posts(
                                plname: render.plname.toString(),
                                title: render.title.toString(),
                                desc: render.desc.toString(),
                                updatedAt: render.updatedAt
                                    .toString()
                                    .replaceAll("-", "/")
                                    .substring(0, 10),
                                id: render.id.toString(),
                              ),
                            );
                          });
                } else if (snapshot.hasError) {
                  return Center(
                      child: SubText(
                    text: 'Erro ao pesquisar posts',
                    color: PrimaryColor,
                    align: TextAlign.center,
                  ));
                }
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: PrimaryColor,
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
