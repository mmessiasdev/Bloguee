import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttercode/component/colors.dart';
import 'package:fluttercode/component/header.dart';
import 'package:fluttercode/component/padding.dart';
import 'package:fluttercode/component/post.dart';
import 'package:fluttercode/component/texts.dart';
import 'package:fluttercode/model/chunks.dart';
import 'package:fluttercode/service/local_service/local_auth_service.dart';
import 'package:http/http.dart' as http;

class ChunkScreen extends StatefulWidget {
  const ChunkScreen({super.key});

  @override
  State<ChunkScreen> createState() => _ChunkScreenState();
}

class _ChunkScreenState extends State<ChunkScreen> {
  var client = http.Client();

  var email;
  var lname;
  var id;
  var token;
  var chunkId;

  @override
  void initState() {
    super.initState();
    getString();
  }

  void getString() async {
    var strEmail = await LocalAuthService().getEmail("email");
    var strFull = await LocalAuthService().getLname("lname");
    var strId = await LocalAuthService().getId("id");
    var strToken = await LocalAuthService().getSecureToken("token");
    var strChunkId = await LocalAuthService().getChunkId("chunk");

    setState(() {
      email = strEmail.toString();
      lname = strFull.toString();
      id = strId.toString();
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

  Future<List<ProfileAttributes>> chunkProfile() async {
    List<ProfileAttributes> listItens = [];
    var response = await client.get(
      Uri.parse('http://localhost:1337/api/chunks/$chunkId?populate=profiles'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body["data"]["attributes"]["profiles"]["data"];
    print(itemCount);
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(ProfileAttributes.fromJson(itemCount[i]));
    }
    return listItens;
  }

  Future<List<PostsAttributes>> chunkPosts() async {
    List<PostsAttributes> listItens = [];
    var response = await client.get(
      Uri.parse('http://localhost:1337/api/chunks/$chunkId?populate=posters'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body["data"]["attributes"]["posters"]["data"];
    print(itemCount);
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(PostsAttributes.fromJson(itemCount[i]));
    }
    return listItens;
  }

  @override
  Widget build(BuildContext context) {
    print(chunkId);
    return ListView(
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
                            Padding(
                              padding: defaultPadding,
                              child: Column(
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
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Expanded(
                        child: Center(
                            child: SubText(
                          text: 'Erro ao pesquisar poster',
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
                  future: chunkProfile(),
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
                          text: 'Erro ao pesquisar poster',
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
                  future: chunkPosts(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        width: double.infinity,
                        child: SubText(
                            text: 'Posts: ${snapshot.data!.length.toString()}',
                            color: nightColor,
                            align: TextAlign.end),
                      );
                    } else if (snapshot.hasError) {
                      return Expanded(
                        child: Center(
                            child: SubText(
                          text: 'Erro ao pesquisar poster',
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
              SizedBox(
                height: 300,
                child: FutureBuilder<List<PostsAttributes>>(
                    future: chunkPosts(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              var render = snapshot.data![index];
                              if (render.chunkfixed == true) {
                                return Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Posts(
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
                            });
                      } else if (snapshot.hasError) {
                        return Center(
                            child: SubText(
                          text: 'Erro ao pesquisar poster',
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
                height: 50,
              ),
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: SubText(
                      text: 'Posters em Destaque',
                      color: nightColor,
                      align: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: SixthColor,
                      child: SubText(
                        text: "Messias",
                        color: nightColor,
                        align: TextAlign.center,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
