import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class CustomTextButton extends StatelessWidget {
  // PARAMETERS NEEDED
  final String buttonText;
  final double fontSize;
  final FontWeight fontWeight;
  final Color fontColor;
  final Color foreGroundColor;
  final VoidFutureCallBack onPressed;

  const CustomTextButton({
    super.key,
    required this.buttonText,
    required this.fontSize,
    required this.fontWeight,
    required this.fontColor,
    required this.foreGroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: foreGroundColor,
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: fontColor,
          ),
        ),
      ),
    );
  }
}
