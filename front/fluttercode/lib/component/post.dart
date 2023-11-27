import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttercode/component/colors.dart';
import 'package:fluttercode/component/texts.dart';
import 'package:fluttercode/view/posts/post/postscreen.dart';

class Posts extends StatelessWidget {
  Posts(
      {super.key,
      required this.plname,
      required this.title,
      required this.desc,
      required this.updatedAt,
      required this.id});

  String plname;
  String title;
  String desc;
  String updatedAt;
  String id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: PrimaryColor,
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SecundaryText(
                      text: plname,
                      color: SecudaryColor,
                      align: TextAlign.start),
                ),
                SecundaryText(
                  text: title,
                  align: TextAlign.start,
                  color: nightColor,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SubText(
                    text: desc,
                    align: TextAlign.start,
                    color: SecudaryColor,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SubTextSized(
                      text: updatedAt,
                      align: TextAlign.end,
                      color: nightColor,
                      size: 15,
                      fontweight: FontWeight.w600,
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
              id: id,
            ),
          ),
        ));
      },
    );
  }
}
