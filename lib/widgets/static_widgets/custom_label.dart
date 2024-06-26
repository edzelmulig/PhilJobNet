import 'package:flutter/material.dart';

class CustomLabel extends StatelessWidget {
  // PARAMETERS NEEDED
  final String textLabel;
  final double fontSize;
  final FontWeight fontWeight;
  final Color fontColor;
  final double? letterSpacing;

  const CustomLabel({
    super.key,
    required this.textLabel,
    required this.fontSize,
    required this.fontWeight,
    required this.fontColor,
    this.letterSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textLabel,
      style: TextStyle(
        color: fontColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
      ),
    );
  }
}
