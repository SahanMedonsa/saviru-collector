import 'package:flutter/material.dart';

class Gtext extends StatelessWidget {
  final String text;
  final double tsize;
  final Color tcolor;
  final FontWeight fweight;
  final TextAlign? textAlign;
  const Gtext(
      {super.key,
      required this.text,
      required this.tsize,
      required this.tcolor,
      required this.fweight,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: tsize,
        color: tcolor,
        fontWeight: fweight,
      ),
      textAlign: textAlign,
    );
  }
}
