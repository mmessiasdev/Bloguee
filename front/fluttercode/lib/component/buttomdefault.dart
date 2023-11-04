import 'package:flutter/material.dart';
import 'package:fluttercode/component/colors.dart';
import 'package:fluttercode/component/texts.dart';

class InputTextButton extends StatelessWidget {
  final String title;
  final Function onClick;
  final Color? color;
  const InputTextButton({Key? key, required this.title, required this.onClick, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: color ?? FourtyColor,
        minimumSize: const Size(double.maxFinite, 50),
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 30),
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.all(Radius.circular(6.0)),
        // ),
      ),
      onPressed: () { 
        FocusScope.of(context).requestFocus(FocusNode());
        onClick();
      },
      child: ButtomText(text: title,)
    );  
  }
}
