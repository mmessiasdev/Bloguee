import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttercode/component/colors.dart';
import 'package:fluttercode/component/header.dart';
import 'package:fluttercode/component/padding.dart';
import 'package:fluttercode/component/post.dart';
import 'package:fluttercode/component/texts.dart';

class ChunkScreen extends StatefulWidget {
  const ChunkScreen({super.key});

  @override
  State<ChunkScreen> createState() => _ChunkScreenState();
}

class _ChunkScreenState extends State<ChunkScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MainHeader(title: 'Mais +', onClick: () {}),
        Padding(
          padding: defaultPadding,
          child: SizedBox(
            child: Column(
              children: [
                Column(
                  children: [
                    PrimaryText(
                        text: 'He Net',
                        color: nightColor,
                        align: TextAlign.start),
                    SubText(
                        text: 'Provedora de banda',
                        color: nightColor,
                        align: TextAlign.start),
                  ],
                ),
                Column(
                  children: [
                    SubText(
                        text: 'Posters:',
                        color: nightColor,
                        align: TextAlign.end),
                    SubText(
                        text: 'Posts', color: nightColor, align: TextAlign.end),
                  ],
                ),
                Column(
                  children: [
                    SubText(
                        text: 'Posts Fixados',
                        color: nightColor,
                        align: TextAlign.center),
                    Posts(
                      plname: 'Messias',
                      title: 'Teste',
                      desc: 'desc',
                      updatedAt: 'updatedAt',
                      id: 2.toString(),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SubText(
                      text: 'Posters em Destaque',
                      color: nightColor,
                      align: TextAlign.center,
                    ),
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: SixthColor,
                      child: SubText(
                        text: "Messias",
                        color: nightColor,
                        align: TextAlign.center,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
