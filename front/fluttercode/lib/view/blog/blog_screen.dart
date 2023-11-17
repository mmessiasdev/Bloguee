import 'package:fluttercode/component/colors.dart';
import 'package:fluttercode/component/header.dart';
import 'package:fluttercode/component/texts.dart';
import 'package:fluttercode/view/account/account_screen.dart';
import 'package:flutter/material.dart';
import 'blog_post.dart';

//ignore: must_be_immutable
class BlogPage extends StatefulWidget {
  const BlogPage();

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MainHeader(
            title: "Text",
            onClick: () => (Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AccountScreen(),
                  ),
                ))),
        Expanded(
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
            ],
          ),
        ),
      ],
    );
  }
}
