import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttercode/component/colors.dart';
import 'package:fluttercode/component/header.dart';
import 'package:fluttercode/component/padding.dart';
import 'package:fluttercode/component/post.dart';
import 'package:fluttercode/component/texts.dart';
import 'package:fluttercode/model/posts.dart';
import 'package:fluttercode/model/profiles.dart';
import 'package:fluttercode/service/local/auth.dart';
import 'package:fluttercode/service/remote/auth.dart';
import 'package:http/http.dart' as http;

class ChunkScreen extends StatefulWidget {
  const ChunkScreen({super.key});

  @override
  State<ChunkScreen> createState() => _ChunkScreenState();
}

class _ChunkScreenState extends State<ChunkScreen> {
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

  Future<Map> chunk() async {
    var response = await client.get(
      Uri.parse('http://localhost:1337/api/chunks/$chunkId?populate=*'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    var itens = json.decode(response.body);
    return itens;
  }

  @override
  Widget build(BuildContext context) {
    return chunkId == null
        ? const SizedBox()
        : ListView(
            children: [
              MainHeader(title: 'Mais +', onClick: () {}),
              Padding(
                padding: defaultPadding,
                child: Column(
                  children: [
                    FutureBuilder<Map>(
                        future: chunk(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var render = snapshot.data!;
                            return SizedBox(
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: PrimaryText(
                                            text: render["data"]["attributes"]
                                                ["title"],
                                            color: nightColor,
                                            align: TextAlign.start),
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: SubText(
                                            text: render["data"]["attributes"]
                                                ["subtitle"],
                                            color: nightColor,
                                            align: TextAlign.start),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Expanded(
                              child: Center(
                                  child: SubText(
                                text: 'Erro ao pesquisar post',
                                color: PrimaryColor,
                                align: TextAlign.center,
                              )),
                            );
                          }
                          return SizedBox(
                            height: 200,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: PrimaryColor,
                              ),
                            ),
                          );
                        }),
                    FutureBuilder<List<ProfileAttributes>>(
                        future: RemoteAuthService()
                            .getProfiles(token: token, chunkId: chunkId),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return SizedBox(
                              width: double.infinity,
                              child: SubText(
                                  text:
                                      'Posters: ${snapshot.data!.length.toString()}',
                                  color: nightColor,
                                  align: TextAlign.end),
                            );
                          } else if (snapshot.hasError) {
                            return Expanded(
                              child: Center(
                                  child: SubText(
                                text: 'Erro ao pesquisar posters',
                                color: PrimaryColor,
                                align: TextAlign.center,
                              )),
                            );
                          }
                          return SizedBox(
                            height: 200,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: PrimaryColor,
                              ),
                            ),
                          );
                        }),
                    FutureBuilder<List<PostsAttributes>>(
                        future: RemoteAuthService()
                            .getPosts(token: token, chunkId: chunkId),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return SizedBox(
                              width: double.infinity,
                              child: SubText(
                                  text:
                                      'Posts: ${snapshot.data!.length.toString()}',
                                  color: nightColor,
                                  align: TextAlign.end),
                            );
                          } else if (snapshot.hasError) {
                            return Expanded(
                              child: Center(
                                  child: SubText(
                                text: 'Erro ao pesquisar posts',
                                color: PrimaryColor,
                                align: TextAlign.center,
                              )),
                            );
                          }
                          return SizedBox(
                            height: 200,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: PrimaryColor,
                              ),
                            ),
                          );
                        }),
                    SizedBox(
                      height: 100,
                    ),
                    SecundaryText(
                      text: 'Posts Fixados',
                      color: nightColor,
                      align: TextAlign.center,
                    ),
                    SizedBox(
                      height: 400,
                      child: FutureBuilder<List<PostsAttributes>>(
                          future: RemoteAuthService()
                              .getPosts(token: token, chunkId: chunkId),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: snapshot.data?.length,
                                  itemBuilder: (context, index) {
                                    var render = snapshot.data![index];
                                    if (render.chunkfixed == true) {
                                      return Posts(
                                        plname: 'Fixado',
                                        title: render.title.toString(),
                                        desc: render.desc.toString(),
                                        updatedAt: render.updatedAt
                                            .toString()
                                            .replaceAll("-", "/")
                                            .substring(0, 10),
                                        id: render.id.toString(),
                                      );
                                    } else {
                                      return SizedBox();
                                    }
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
                          }),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    SecundaryText(
                      text: 'Top Criadores',
                      color: nightColor,
                      align: TextAlign.center,
                    ),
                    SizedBox(
                      height: 300,
                      child: FutureBuilder<List<ProfileAttributes>>(
                          future: RemoteAuthService()
                              .getProfiles(token: token, chunkId: chunkId),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 150,
                                  ),
                                  itemCount: snapshot.data?.length,
                                  itemBuilder: (context, index) {
                                    var render = snapshot.data![index];
                                    return Column(
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
                          }),
                    ),
                  ],
                ),
              )
            ],
          );
  }
}
