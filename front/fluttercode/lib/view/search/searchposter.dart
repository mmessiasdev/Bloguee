import 'dart:convert';
// import 'package:Movietips/View/Components/General/Category.dart';
// import 'package:Movietips/View/Components/General/MovieList.dart';
// import 'package:Movietips/View/OnTapScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttercode/component/colors.dart';
import 'package:fluttercode/component/texts.dart';
import 'package:fluttercode/model/posters.dart';
import 'package:fluttercode/view/poster/posterscreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

// ------------ MOVIE SEARCH COMPONENT ------------ //
class SearchPosters extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => 'Qual sua dúvida?';

  // ------------------------ //
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
  // ------------------------ //

  // ------------------------ //
  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          close(context, "");
        },
        icon: Icon(Icons.arrow_back_ios));
  }
  // ------------------------ //

  // ------------------------ //
  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder<List>(
      future: suggestions(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text('Procurando Poster...'),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Erro ao procurar Poster.'),
          );
        }
        return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var PosterApi = snapshot.data![index];
              // var url = "https://www.themoviedb.org/t/p/w600_and_h900_bestv2";
              if (PosterApi["title"] == null) {
                return Padding(
                  padding: const EdgeInsets.all(0),
                );
              }
              return ListTile(
                // leading: ClipRRect(
                //   borderRadius: BorderRadius.circular(5),
                //   child: Image.network(
                //     '${url}${PosterApi["poster_path"]}',
                //   ),
                // ),
                title: Text(
                  '${PosterApi["title"]}',
                  style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  '${PosterApi["desc"]}',
                  style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w300),
                ),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PosterScreen(),
                    )),
              );
            });
      },
    );
  }
  // ------------------------ //

  // ------------------------ //
  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    if(query.isEmpty){
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

  // Future<List> suggestions() async {
  //   var url = Uri.parse(
  //     'localhost:1337/api/posters?filters[title][containsi]=$query');
  //   var response = await http.get(url);
  //   var jsonResponse = jsonDecode(response.body);
  //   var itemCount = jsonResponse['attributes'];
  //   return itemCount;
  // }

  Future<List<Attributes>> suggestions() async {
    // TODO: implement getPostsList
    List<Attributes> listItens = [];
    var url = Uri.parse(
        'http://localhost:1337/api/posters?filters[title][\$containsi]=$query');
    var response = await http.get(url);
    var body = jsonDecode(response.body);
    print(body);
    // parse
    var itemCount = body["data"];
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(Attributes.fromJson(itemCount[i]));
    }
    return listItens;
  }

  // ------- Fetch Movie Query API ID ------- //
  // Future<List> fetch(String query) async {
  //   var url = Uri.parse(
  //       'localhost:1337/api/posters?filters[title][containsi]=$query');
  //   var response = await http.get(url);
  //   var jsonResponse = jsonDecode(response.body);
  //   var itemCount = jsonResponse['data']['attributes'];
  //   return itemCount;
  // }
  // ------------------------ //
}
