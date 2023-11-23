import 'package:flutter/material.dart';
import 'package:fluttercode/component/colors.dart';
import 'package:fluttercode/component/texts.dart';

class ThumbPoster extends StatelessWidget {
  String title;
  String desc;
  String data;

  ThumbPoster({
    super.key,
    required this.title,
    required this.desc,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        color: SixthColor,
      ),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    text: data,
                    align: TextAlign.end,
                    color: nightColor,
                    size: 15,
                    fontweight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
