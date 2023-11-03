import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:fluttercode/component/colors.dart';
import 'package:get/get.dart';
import 'package:fluttercode/controller/controllers.dart';

class MainHeader extends StatelessWidget {
  MainHeader({Key? key, this.title, required this.onClick}) : super(key: key);
  String? title;
  Function onClick;
  

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
                width: 100,
                height: double.infinity,
                color: PrimaryColor,
                child: Center(
                  child: Text(
                    title!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                ),
              ),
              onTap: () => {
                onClick!()
              }),
        ],
      ),
    );
  }
}
