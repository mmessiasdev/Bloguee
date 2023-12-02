import 'package:fluttercode/component/padding.dart';
import 'package:fluttercode/service/local/auth.dart';
import 'package:fluttercode/service/remote/auth.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:fluttercode/component/colors.dart';
import 'package:fluttercode/component/header.dart';
import 'package:fluttercode/component/texts.dart';

class PostScreen extends StatefulWidget {
  PostScreen({super.key, required this.id});
  String id;

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  var client = http.Client();
  var email;
  var lname;
  var token;
  var id;
  var chunkId;

  @override
  void initState() {
    super.initState();
    getString();
  }

  void getString() async {
    var strToken = await LocalAuthService().getSecureToken("token");
    var strChunkId = await LocalAuthService().getChunkId("chunk");

    setState(() {
      token = strToken.toString();
      chunkId = strChunkId.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return chunkId == "null"
        ? SizedBox()
        : ListView(
            children: [
              MainHeader(
                  title: "Voltar", onClick: () => Navigator.pop(context)),
              FutureBuilder<Map>(
                  future:
                      RemoteAuthService().getPost(token: token, id: widget.id),
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
                                      align: TextAlign.start,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 1,
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
                                      text: render["data"]["attributes"]
                                          ["desc"],
                                      color: SecudaryColor,
                                      align: TextAlign.justify),
                                  SizedBox(
                                    height: 100,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              color: SixthColor,
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 30, top: 50, bottom: 50),
                                  child: SubText(
                                    text: render["data"]["attributes"]
                                        ["content"],
                                    align: TextAlign.start,
                                    color: nightColor,
                                  )),
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
                  })
            ],
          );
  }
}
