import 'dart:convert';

import 'package:fluttercode/component/colors.dart';
import 'package:fluttercode/view/complaint/components/complaintcont.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../component/header.dart';
import '../../component/texts.dart';
import '../../model/complaint.dart';

import 'package:http/http.dart' as http;

class ComplaintList extends StatefulWidget {
  const ComplaintList({Key? key}) : super(key: key);

  @override
  State<ComplaintList> createState() => _ComplaintListState();
}

class _ComplaintListState extends State<ComplaintList> {
  Future<List<Attributes>> getComplaintList() async {
    // TODO: implement getPostsList
    List<Attributes> listItens = [];
    var url = Uri.parse(
        '${dotenv.get('BASEURL').toString()}/api/complaints?sort=id:DESC');
    var response = await http.get(url);
    var body = jsonDecode(response.body);
    // parse
    var itemCount = body["data"];
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(Attributes.fromJson(itemCount[i]));
    }
    return listItens;
  }

  Future<void> getData() async {
    await Future.delayed(const Duration(seconds: 2));
    getComplaintList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: lightColor,
      child: Column(
        children: [
          const MainHeader(),
          Expanded(
            child: RefreshIndicator(
              backgroundColor: TerciaryColor,
              color: SecudaryColor,
              onRefresh: getData,
              child: ListView(
                children: [
                  Container(
                    color: lightColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: Icon(Icons.arrow_back_ios),
                            onTap: () => Navigator.pop(context),
                          ),
                          PrimaryText(
                            text: 'Denúncias',
                            color: TerciaryColor,
                            align: TextAlign.center,
                          ),
                          SizedBox(),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: FutureBuilder<List<Attributes>>(
                        future: getComplaintList(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  var renders = snapshot.data![index];
                                  if (renders.nivel == "Baixo") {
                                    return Column(
                                      children: [
                                        Center(
                                            child: CompaintContainer(
                                          time: renders.createdAt
                                              .toString()
                                              .substring(11, 16)
                                              .replaceAll("-", "/"),
                                          data: renders.createdAt
                                              .toString()
                                              .substring(0, 10)
                                              .replaceAll("-", "/"),
                                          colorText: Colors.black,
                                          colorBack:
                                              Color.fromRGBO(161, 217, 240, 1),
                                          content: renders.type.toString(),
                                          name: renders.email.toString(),
                                        )),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    );
                                  }
                                  if (renders.nivel == "Médio") {
                                    return Column(
                                      children: [
                                        Center(
                                            child: CompaintContainer(
                                          time: renders.createdAt
                                              .toString()
                                              .substring(11, 16)
                                              .replaceAll("-", "/"),
                                          data: renders.createdAt
                                              .toString()
                                              .substring(0, 10)
                                              .replaceAll("-", "/"),
                                          colorText: Colors.white,
                                          colorBack:
                                              Color.fromRGBO(19, 68, 90, 1),
                                          content: renders.type.toString(),
                                          name: renders.email.toString(),
                                        )),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    );
                                  }
                                  if (renders.nivel == "Alto") {
                                    return Column(
                                      children: [
                                        Center(
                                            child: CompaintContainer(
                                          time: renders.createdAt
                                              .toString()
                                              .substring(11, 16)
                                              .replaceAll("-", "/"),
                                          data: renders.createdAt
                                              .toString()
                                              .substring(0, 10)
                                              .replaceAll("-", "/"),
                                          colorText: Colors.white,
                                          colorBack:
                                              Color.fromRGBO(30, 31, 32, 1),
                                          content: renders.type.toString(),
                                          name: renders.email.toString(),
                                        )),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    );
                                  }
                                  return const SizedBox(
                                    height: 100,
                                    child: Center(
                                      child: Text('Não encontrado'),
                                    ),
                                  );
                                });
                          }
                          return SizedBox(
                            height: 300,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: TerciaryColor,
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
