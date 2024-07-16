import 'package:flutter/material.dart';
import 'package:Bloguee/component/colors.dart';
import 'package:Bloguee/component/post.dart';
import 'package:Bloguee/component/containersLoading.dart';
import 'package:Bloguee/component/header.dart';
import 'package:Bloguee/component/padding.dart';
import 'package:Bloguee/component/texts.dart';
import 'package:Bloguee/model/posts.dart';
import 'package:Bloguee/model/profiles.dart';
import 'package:Bloguee/service/local/auth.dart';
import 'package:Bloguee/service/remote/auth.dart';
import 'package:http/http.dart' as http;

class ChunkScreen extends StatefulWidget {
  const ChunkScreen({super.key});

  @override
  State<ChunkScreen> createState() => _ChunkScreenState();
}

class _ChunkScreenState extends State<ChunkScreen> {
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
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return ListView(
      shrinkWrap: true,
      children: [
        MainHeader(title: '', onClick: () {}),
        Padding(
          padding: defaultPadding,
          child: Column(
            children: [
              FutureBuilder<Map>(
                future: RemoteAuthService().chunk(chunkId: chunkId!, token: token!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: PrimaryText(
                              text: "Carregando...",
                              color: nightColor,
                              align: TextAlign.start),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: SubText(
                              text: "Aguarde.",
                              color: nightColor,
                              align: TextAlign.start),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: SubText(
                        text: 'Erro ao pesquisar Chunk',
                        color: PrimaryColor,
                        align: TextAlign.center,
                      ),
                    );
                  } else if (snapshot.hasData) {
                    var render = snapshot.data!;
                    return Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: PrimaryText(
                              text: render["title"],
                              color: nightColor,
                              align: TextAlign.start),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: SubText(
                              text: render["subtitle"],
                              color: nightColor,
                              align: TextAlign.start),
                        ),
                      ],
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
              SizedBox(height: 100),
              SizedBox(
                width: double.infinity,
                child: SubText(
                    text: 'Posts Fixados',
                    color: nightColor,
                    align: TextAlign.start),
              ),
              FutureBuilder<List<PostsModel>>(
                future: RemoteAuthService().getPosts(token: token!, chunkId: chunkId!),
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
              SizedBox(height: 35),
              SizedBox(
                width: double.infinity,
                child: SubText(
                    text: 'Top Criadores',
                    color: nightColor,
                    align: TextAlign.start),
              ),
              FutureBuilder<List<ProfilesModel>>(
                future: RemoteAuthService().getProfiles(token: token!, chunkId: chunkId!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      height: 200,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: PrimaryColor,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: SubText(
                        text: 'Erro ao pesquisar post',
                        color: PrimaryColor,
                        align: TextAlign.center,
                      ),
                    );
                  } else if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 150,
                        ),
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          var render = snapshot.data![index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: SixthColor,
                                  child: Icon(
                                    Icons.people,
                                    color: PrimaryColor,
                                    size: 30,
                                  ),
                                ),
                                SubText(
                                  text: render.lname.toString(),
                                  color: nightColor,
                                  align: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
              FutureBuilder<List<ProfilesModel>>(
                future: RemoteAuthService().getProfiles(token: token!, chunkId: chunkId!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      width: double.infinity,
                      child: SubText(
                          text: 'Posters: carregando...',
                          color: nightColor,
                          align: TextAlign.end),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: SubText(
                        text: 'Erro ao pesquisar posters',
                        color: PrimaryColor,
                        align: TextAlign.center,
                      ),
                    );
                  } else if (snapshot.hasData) {
                    return SizedBox(
                      width: double.infinity,
                      child: SubText(
                          text: 'Posters: ${snapshot.data!.length.toString()}',
                          color: nightColor,
                          align: TextAlign.end),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
              FutureBuilder<List<PostsModel>>(
                future: RemoteAuthService().getPosts(token: token!, chunkId: chunkId!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      width: double.infinity,
                      child: SubText(
                          text: 'Posts: carregando...',
                          color: nightColor,
                          align: TextAlign.end),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: SubText(
                        text: 'Erro ao pesquisar posts',
                        color: PrimaryColor,
                        align: TextAlign.center,
                      ),
                    );
                  } else if (snapshot.hasData) {
                    return SizedBox(
                      width: double.infinity,
                      child: SubText(
                          text: 'Posts: ${snapshot.data!.length.toString()}',
                          color: nightColor,
                          align: TextAlign.end),
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
