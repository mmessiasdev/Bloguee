import 'package:flutter/material.dart';
import 'package:fluttercode/component/colors.dart';
import 'package:fluttercode/component/header.dart';
import 'package:fluttercode/component/padding.dart';
import 'package:fluttercode/component/post.dart';
import 'package:fluttercode/component/texts.dart';
import 'package:fluttercode/service/local/auth.dart';
import 'package:fluttercode/service/remote/auth.dart';
import 'package:fluttercode/view/posts/create/createpost.dart';
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
  var chunkId;

  @override
  void initState() {
    super.initState();
    getString();
  }

  void getString() async {
    var strToken = await LocalAuthService().getSecureToken("token");
    var strChunkId = await LocalAuthService().getChunkId("chunkId");

    setState(() {
      token = strToken.toString();
      chunkId = strChunkId.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return chunkId == null
        ? SizedBox()
        : ListView(
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
              FutureBuilder<List<PostsAttributes>>(
                  future: RemoteAuthService()
                      .getPosts(token: token, chunkId: chunkId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var render = snapshot.data![index];
                            return Padding(
                              padding: const EdgeInsets.all(15),
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
                    return SizedBox(
                      height: 300,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: PrimaryColor,
                        ),
                      ),
                    );
                  })
            ],
          );
  }
}
