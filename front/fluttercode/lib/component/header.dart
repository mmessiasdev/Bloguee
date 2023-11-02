import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:fluttercode/component/colors.dart';
import 'package:get/get.dart';
import 'package:fluttercode/controller/controllers.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      width: double.infinity,
      color: SecudaryColor,
      child: Center(
        child: Image(
          height: 37,
          image: AssetImage('assets/images/branco.png'),
        ),
      ),
    );
  }
}