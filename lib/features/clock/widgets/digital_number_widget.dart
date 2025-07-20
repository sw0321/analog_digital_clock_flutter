
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DigitalNumberWidget extends StatelessWidget {
  final String number;
  final TextStyle textStyle;

  const DigitalNumberWidget({
    super.key,
    required this.number,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      number,
      style: textStyle,
    );
  }
}
