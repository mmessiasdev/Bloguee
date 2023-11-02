import 'package:fluttercode/component/colors.dart';
import 'package:fluttercode/component/header.dart';
import 'package:fluttercode/component/texts.dart';
import 'package:fluttercode/model/post.dart';
import 'package:fluttercode/view/blog/components/postcontainer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'blog_post.dart';

//ignore: must_be_immutable
class BlogPage extends StatefulWidget {
  const BlogPage();

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  Future<List<Attributes>> getPostsList() async {
    // TODO: implement getPostsList
    List<Attributes> listItens = [];
    var url =
        Uri.parse('${dotenv.get('BASEURL').toString()}/api/posts?sort=id:DESC');
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
    getPostsList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PrimaryText(
                          text: 'Blog',
                          color: TerciaryColor,
                          align: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SecundaryText(
                            text: 'O que aconteceu?',
                            color: TerciaryColor,
                            align: TextAlign.start,
                          ),
                          SubText(
                            text: 'Nós queremos saber!',
                            color: OffColor,
                            align: TextAlign.start,
                          ),
                        ],
                      ),
                      GestureDetector(
                        child: const Icon(
                          Icons.note_add,
                          size: 27,
                        ),
                        onTap: () => showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) => ContainerPost(),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: FutureBuilder<List<Attributes>>(
                      future: getPostsList(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                var renders = snapshot.data![index];
                                if (renders != null) {
                                  return Column(
                                    children: [
                                      Center(
                                        child: PostContainer(
                                          content: renders.content.toString(),
                                          name: renders.name.toString(),
                                        ),
                                      ),
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
    );
  }
}
