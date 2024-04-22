import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class ApplicationFooter extends StatelessWidget {
  // PARAMETERS NEEDED
  final String buttonQuestionText;
  final VoidFutureCallBack onPressed;
  final String buttonText;

  const ApplicationFooter({
    super.key,
    required this.buttonQuestionText,
    required this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            buttonQuestionText,
            style: const TextStyle(
              height: 1.3,
              fontSize: 15.0,
              color: Colors.grey,
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
              foregroundColor: const Color(0xFF3499da),
            ),
            onPressed: onPressed,
            child: Text(
              buttonText,
              style: const TextStyle(
                fontSize: 15.5,
                fontWeight: FontWeight.w900,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
