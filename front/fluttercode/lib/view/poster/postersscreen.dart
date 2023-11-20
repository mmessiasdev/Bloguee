import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttercode/component/colors.dart';
import 'package:fluttercode/component/header.dart';
import 'package:fluttercode/component/texts.dart';
import 'package:fluttercode/view/home/home_screen.dart';
import 'package:fluttercode/view/poster/posterscreen.dart';
import 'package:http/http.dart' as http;

import '../../model/posters.dart';

class PostersScreen extends StatelessWidget {
  const PostersScreen({super.key});

  Future<List<Attributes>> posters() async {
    List<Attributes> listItens = [];
    var url = Uri.parse('http://localhost:1337/api/posters');
    var response = await http.get(url);
    var body = jsonDecode(response.body);
    var itemCount = body["data"];
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(Attributes.fromJson(itemCount[i]));
    }
    return listItens;
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
                  builder: (context) => HomeScreen(),
                ),
              ));
            }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: SizedBox(
            child: Column(
              children: [
                Center(
                  child: PrimaryText(
                    text: 'Ultimos Posters',
                    color: nightColor,
                    align: TextAlign.center,
                  ),
                ),
                SizedBox(height: 75),
                SizedBox(
                  child: FutureBuilder(
                      future: posters(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                var render = snapshot.data![index];

                                return Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: GestureDetector(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: PrimaryColor,
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SecundaryText(
                                                text: render.title.toString(),
                                                align: TextAlign.start,
                                                color: nightColor,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: SubText(
                                                  text: render.desc.toString(),
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
                                                  child: SubText(
                                                    text: render.updatedAt
                                                        .toString()
                                                        .replaceAll("-", "/")
                                                        .substring(0, 10),
                                                    align: TextAlign.end,
                                                    color: nightColor,
                                                  ),
                                                ),
                                              ),
                                            ],
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
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
