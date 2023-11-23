import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttercode/component/colors.dart';
import 'package:fluttercode/component/texts.dart';
import 'package:fluttercode/component/thumbposter.dart';
import 'package:fluttercode/model/posters.dart';
import 'package:fluttercode/service/local_service/local_auth_service.dart';
import 'package:fluttercode/view/poster/posterscreen.dart';
import 'package:http/http.dart' as http;

class RenderPoster extends StatefulWidget {
  RenderPoster({super.key, required this.query});

  String query;

  @override
  State<RenderPoster> createState() => _RenderPosterState();
}

class _RenderPosterState extends State<RenderPoster> {
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

  Future<List<Attributes>> poster() async {
    List<Attributes> listItens = [];
    var response = await client.get(
      Uri.parse(
          'http://localhost:1337/api/posters?filters[title][\$containsi]=${widget.query}&populate=*'),
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
    return FutureBuilder<List<Attributes>>(
        future: poster(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var render = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 50),
                    child: GestureDetector(
                      child: ThumbPoster(
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

class SearchPosters extends SearchDelegate<String> {
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
    return RenderPoster(
      query: query,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    return RenderPoster(
      query: query,
    );
  }
}
