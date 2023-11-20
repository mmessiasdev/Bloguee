import 'dart:convert';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:fluttercode/component/colors.dart';
import 'package:fluttercode/component/header.dart';
import 'package:fluttercode/component/texts.dart';

class PosterScreen extends StatelessWidget {
  PosterScreen({super.key, required this.id});
  String id;

  Future<Map> poster() async {
    var url = Uri.parse('http://localhost:1337/api/posters/$id?populate=*');
    http.Response response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MainHeader(title: "Voltar", onClick: () => Navigator.pop(context)),
        FutureBuilder<Map>(
            future: poster(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var render = snapshot.data!;
                return SizedBox(
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 30, right: 30, top: 25),
                        child: Column(
                          children: [
                            PrimaryText(
                                text: render["data"]["attributes"]["title"],
                                color: nightColor,
                                align: TextAlign.start),
                            SizedBox(
                              height: 25,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 1,
                              child: SubText(
                                text:
                                    "Por ${render["data"]["attributes"]["profile"]["data"]["attributes"]["lname"]}",
                                color: nightColor,
                                align: TextAlign.end,
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            SubText(
                                text: render["data"]["attributes"]["desc"],
                                color: SecudaryColor,
                                align: TextAlign.justify),
                            SizedBox(
                              height: 100,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: PrimaryColor,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 50, bottom: 50),
                          child: SubText(
                            text: render["data"]["attributes"]["content"],
                            align: TextAlign.justify,
                            color: nightColor,
                          )
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
            })
      ],
    );
  }
}
