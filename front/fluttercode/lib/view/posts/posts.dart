import 'package:Bloguee/component/containersLoading.dart';
import 'package:Bloguee/component/post.dart';
import 'package:Bloguee/model/postModel.dart';
import 'package:flutter/material.dart';
import 'package:Bloguee/component/colors.dart';
import 'package:Bloguee/component/header.dart';
import 'package:Bloguee/component/padding.dart';
import 'package:Bloguee/component/texts.dart';
import 'package:Bloguee/service/local/auth.dart';
import 'package:Bloguee/service/remote/auth.dart';
import 'package:Bloguee/view/posts/create/createpost.dart';
import 'package:http/http.dart' as http;

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  var client = http.Client();

  String? token;
  String? chunkId;

  @override
  void initState() {
    super.initState();
    getString();
  }

  void getString() async {
    var strToken = await LocalAuthService().getSecureToken("token");
    var strChunkId = await LocalAuthService().getChunkId("chunkId");

    setState(() {
      token = strToken;
      chunkId = strChunkId;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (token == null || chunkId == null) {
      return Center(child: CircularProgressIndicator());
    }

    return ListView(
      children: [
        MainHeader(
          title: 'Criar',
          onClick: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreatePost(),
              ),
            );
          },
        ),
        Padding(
          padding: defaultPadding,
          child: Column(
            children: [
              SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                child: PrimaryText(
                  text: 'Últimos Posts',
                  color: nightColor,
                  align: TextAlign.start,
                ),
              ),
              SizedBox(height: 40),
              FutureBuilder<List<PostsModel>>(
                future: RemoteAuthService()
                    .getPosts(token: token!, chunkId: chunkId!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return PostsLoading();
                  } else if (snapshot.hasError) {
                    return Center(
                      child: SubText(
                        text: 'Erro ao pesquisar post',
                        color: PrimaryColor,
                        align: TextAlign.center,
                      ),
                    );
                  } else if (snapshot.hasData) {
                    var posts = snapshot.data!;
                    return ListView.builder(
                      itemCount: posts.length,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var render = posts[index];
                        if (render.chunkfixed == true) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: WidgetPosts(
                              plname: 'Fixado',
                              title: render.title.toString(),
                              desc: render.desc.toString(),
                              updatedAt: render.updatedAt
                                  .toString()
                                  .replaceAll("-", "/")
                                  .substring(0, 10),
                              id: render.id.toString(),
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
