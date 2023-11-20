import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttercode/component/colors.dart';
import 'package:fluttercode/component/texts.dart';
import 'package:fluttercode/model/posters.dart';
import 'package:fluttercode/view/poster/posterscreen.dart';
import 'package:http/http.dart' as http;

class SearchPosters extends SearchDelegate<String> {
  Future<List<Attributes>> suggestions() async {
    List<Attributes> listItens = [];
    var url = Uri.parse(
        'http://localhost:1337/api/posters?filters[title][\$containsi]=$query');
    var response = await http.get(url);
    var body = jsonDecode(response.body);
    var itemCount = body["data"];
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(Attributes.fromJson(itemCount[i]));
    }
    return listItens;
  }

  Future<List<Data>> sugId() async {
    List<Data> listId = [];
    var url = Uri.parse(
        'http://localhost:1337/api/posters?filters[title][\$containsi]=$query');
    var response = await http.get(url);
    var body = jsonDecode(response.body);
    var itemCount = body["data"];
    for (var i = 0; i < itemCount.length; i++) {
      listId.add(Data.fromJson(itemCount[i]));
    }
    return listId;
  }

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
    return FutureBuilder<List<Attributes>>(
        future: suggestions(),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SecundaryText(
                                  text: render.title.toString(),
                                  align: TextAlign.start,
                                  color: nightColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: SubText(
                                    text: render.desc.toString(),
                                    align: TextAlign.start,
                                    color: SecudaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
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
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder<List<Attributes>>(
        future: suggestions(),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SecundaryText(
                                  text: render.title.toString(),
                                  align: TextAlign.start,
                                  color: nightColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: SubText(
                                    text: render.desc.toString(),
                                    align: TextAlign.start,
                                    color: SecudaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
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
        });
  }
}
