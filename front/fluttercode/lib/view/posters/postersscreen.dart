import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttercode/component/colors.dart';
import 'package:fluttercode/component/header.dart';
import 'package:fluttercode/component/texts.dart';
import 'package:fluttercode/service/local_service/local_auth_service.dart';
import 'package:fluttercode/view/home/home_screen.dart';
import 'package:fluttercode/view/posters/create/createposter.dart';
import 'package:fluttercode/view/posters/poster/posterscreen.dart';
import 'package:http/http.dart' as http;

import '../../model/posters.dart';

class PostersScreen extends StatefulWidget {
  const PostersScreen({super.key});

  @override
  State<PostersScreen> createState() => _PostersScreenState();
}

class _PostersScreenState extends State<PostersScreen> {
  var client = http.Client();

  var email;
  var lname;
  var id;
  var token;

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

    setState(() {
      email = strEmail.toString();
      lname = strFull.toString();
      id = strId.toString();
      token = strToken.toString();
    });
  }

  Future<List<Attributes>> posters() async {
    List<Attributes> listItens = [];
    var response = await client.get(
      Uri.parse('http://localhost:1337/api/posters?populate=*'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body["data"];
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(Attributes.fromJson(itemCount[i]));
    }
    return listItens;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: ListView(
          children: [
            MainHeader(
                title: 'Criar',
                onClick: () {
                  (Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreatePoster(),
                    ),
                  ));
                }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: PrimaryText(
                        text: 'Ultimos Posters',
                        color: nightColor,
                        align: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .6,
                    child: Expanded(
                      child: FutureBuilder<List<Attributes>>(
                          future: posters(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: snapshot.data?.length,
                                  itemBuilder: (context, index) {
                                    var render = snapshot.data![index];
                                    return Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: GestureDetector(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: PrimaryColor,
                                          ),
                                          child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 20, horizontal: 20),
                                              child: Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10),
                                                      child: SecundaryText(
                                                          text: render.plname
                                                              .toString(),
                                                          color: SecudaryColor,
                                                          align: TextAlign.start),
                                                    ),
                                                    SecundaryText(
                                                      text:
                                                          render.title.toString(),
                                                      align: TextAlign.start,
                                                      color: nightColor,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10),
                                                      child: SubText(
                                                        text: render.desc
                                                            .toString(),
                                                        align: TextAlign.start,
                                                        color: SecudaryColor,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: double.infinity,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                                top: 10),
                                                        child: SubTextSized(
                                                          text: render.updatedAt
                                                              .toString()
                                                              .replaceAll(
                                                                  "-", "/")
                                                              .substring(0, 10),
                                                          align: TextAlign.end,
                                                          color: nightColor,
                                                          size: 15,
                                                          fontweight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ),
                                        onTap: () {
                                          (Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => PosterScreen(
                                                id: render.id.toString(),
                                              ),
                                            ),
                                          ));
                                        },
                                      ),
                                    );
                                    ;
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
