import 'package:flutter/material.dart';
import 'package:fluttercode/component/colors.dart';
import 'package:fluttercode/component/header.dart';
import 'package:fluttercode/component/texts.dart';
import 'package:fluttercode/view/home/home_screen.dart';
import 'package:fluttercode/view/search/searchposter.dart';

class PosterScreen extends StatelessWidget {
  const PosterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MainHeader(title: "Voltar", onClick: () => Navigator.pop(context)),
        Padding(
          padding: const EdgeInsets.only(left: 40, right: 40, top: 25),
          child: Column(
            children: [
              PrimaryText(
                  text: "Senhas para roteadores TP Link",
                  color: nightColor,
                  align: TextAlign.start),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 1,
                child: SubText(
                  text: "Por Messias",
                  color: nightColor,
                  align: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 100,
              ),
              SubText(
                  text:
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                  color: nightColor,
                  align: TextAlign.justify),
              SizedBox(
                height: 100,
              ),
              SubText(
                  text:
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                  color: nightColor,
                  align: TextAlign.justify),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        )
      ],
    );
  }
}
