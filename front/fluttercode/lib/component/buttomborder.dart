import 'package:flutter/material.dart';
import 'package:fluttercode/component/texts.dart';

class InputOutlineButton extends StatelessWidget {
  final String title;
  final Function onClick;
  const InputOutlineButton(
      {Key? key, required this.title, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Color.fromRGBO(19, 68, 90, 1),
        backgroundColor: Colors.white,
        minimumSize: const Size(double.maxFinite, 45),
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
            side: BorderSide(
              color: Color.fromRGBO(19, 68, 90, 1),
            )),
      ),
      onPressed: () {
        FocusScope.of(context).requestFocus(FocusNode());
        onClick();
      },
      child: ButtomSecundary(text: title),
    );
  }
}
