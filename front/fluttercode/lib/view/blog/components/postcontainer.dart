import 'package:flutter/material.dart';

import '../../../component/colors.dart';
import '../../../component/texts.dart';

class PostContainer extends StatelessWidget {
  PostContainer({Key? key, required this.content, required this.name}) : super(key: key);
  String content;
  String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FourtyColor,
        borderRadius: BorderRadius.circular(6),
      ),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: TerciaryColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: SubText(
                          text: name,
                          color: Colors.black,
                          align: TextAlign.start,),
                    ),
                  ],
                ),
                // Icon(Icons.favorite_border),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: SubText(
                  text: content, color: Colors.black, align: TextAlign.justify),
            ),
            Row(),
          ],
        ),
      ),
    );
    ;
  }
}
