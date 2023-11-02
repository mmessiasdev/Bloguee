import 'package:fluttercode/component/colors.dart';
import 'package:fluttercode/component/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class InfoInputLogin extends StatelessWidget {
  InfoInputLogin({Key? key, required this.title, required this.info})
      : super(key: key);
  String title;
  String info;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubText(text: title, color: TerciaryColorOff, align: TextAlign.start),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 30,
            color: Color.fromARGB(255, 215, 215, 215),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SubText(
                    text: info,
                    color: TerciaryColorOff,
                    align: TextAlign.start),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
