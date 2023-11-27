import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:fluttercode/component/colors.dart';
import 'package:fluttercode/component/texts.dart';
import 'package:get/get.dart';
import 'package:fluttercode/controller/controllers.dart';

class MainHeader extends StatelessWidget {
  MainHeader({Key? key, required this.title, required this.onClick})
      : super(key: key);
  String title;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: double.infinity,
      color: SecudaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/preto.png'),
          ),
          GestureDetector(
              child: Container(
                width: 130,
                height: double.infinity,
                color: PrimaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: SecundaryText(
                          text: title,
                          color: Colors.black,
                          align: TextAlign.center)),
                ),
              ),
              onTap: () => onClick()),
        ],
      ),
    );
  }
}
