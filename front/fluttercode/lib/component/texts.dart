import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryText extends StatelessWidget {
  PrimaryText({required this.text, required this.color, required this.align});
  String text;
  Color color;
  TextAlign align;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(
        text,
        textAlign: align,
        style: GoogleFonts.montserrat(
          fontSize: 48,
          textStyle: TextStyle(
            color: color,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}

class SecundaryText extends StatelessWidget {
  SecundaryText({required this.text, required this.color, required this.align});
  String text;
  Color color;
  TextAlign align;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(
        text,
        textAlign: align,
        style: GoogleFonts.montserrat(
          fontSize: 20,
          textStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: color,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}

class ButtomText extends StatelessWidget {
  ButtomText({
    required this.text,
  });
  String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(
          fontSize: 20,
          textStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 0, 0, 0),
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}

class ButtomSecundary extends StatelessWidget {
  ButtomSecundary({
    required this.text,
  });
  String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(
          fontSize: 20,
          textStyle: TextStyle(
            color: Color.fromRGBO(0, 0, 0, 1),
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}

class SubText extends StatelessWidget {
  SubText({required this.text, required this.color, required this.align});
  String text;
  Color color;
  TextAlign align;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(
        text,
        textAlign: align,
        style: GoogleFonts.montserrat(
          fontSize: 20,
          textStyle: TextStyle(
            color: color,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}

class SubTextSized extends StatelessWidget {
  SubTextSized(
      {required this.text,
      required this.color,
      required this.align,
      required this.size,
      required this.fontweight});
  String text;
  Color color;
  TextAlign align;
  double size;
  FontWeight fontweight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(
        text,
        textAlign: align,
        style: GoogleFonts.montserrat(
          fontSize: size,
          textStyle: TextStyle(
            color: color,
            fontWeight: fontweight,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
