import 'package:flutter/material.dart';
import 'package:fluttercode/component/colors.dart';
import 'package:fluttercode/component/texts.dart';
import 'package:fluttercode/component/thumbpost.dart';
import 'package:fluttercode/model/posts.dart';
import 'package:fluttercode/service/local/auth.dart';
import 'package:fluttercode/service/remote/auth.dart';
import 'package:fluttercode/view/posts/post/screen.dart';

class RenderPost extends StatefulWidget {
  RenderPost({super.key, required this.query});

  String query;

  @override
  State<RenderPost> createState() => _RenderPostState();
}

class _RenderPostState extends State<RenderPost> {

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
    return FutureBuilder<List<PostsAttributes>>(
        future: RemoteAuthService()
            .getPostSearch(token: token, query: widget.query, chunkId: chunkId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var render = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 25),
                    child: GestureDetector(
                      child: ThumbPost(
                          title: render.title.toString(),
                          desc: render.desc.toString(),
                          data: render.updatedAt
                              .toString()
                              .replaceAll("-", "/")
                              .substring(0, 10)),
                      onTap: () {
                        (Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PostScreen(
                              id: render.id.toString(),
                            ),
                          ),
                        ));
                      },
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Center(
                child: SubText(
              text: 'Erro ao pesquisar post',
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
        });
  }
}

class SearchPosts extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => 'Qual sua dúvida?';

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          close(context, "");
        },
        icon: Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    return RenderPost(
      query: query,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    return RenderPost(
      query: query,
    );
  }
}
