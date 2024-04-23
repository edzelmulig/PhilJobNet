import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class CustomButtonWithIcon extends StatelessWidget {
  // PARAMETERS NEEDED
  final IconData icon;
  final String buttonText;
  final Color buttonColor;
  final VoidFutureCallBack onPressed;

  const CustomButtonWithIcon({
    super.key,
    required this.icon,
    required this.buttonText,
    required this.buttonColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          foregroundColor: Colors.grey,
          backgroundColor: buttonColor,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // ICON
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
            ),
            // SPACER
            const Spacer(),
            // TEXT
            Padding(
              padding: const EdgeInsets.only(right: 35),
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}


