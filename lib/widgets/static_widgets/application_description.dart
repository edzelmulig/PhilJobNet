import 'package:flutter/material.dart';

class ApplicationDescription extends StatelessWidget {
  const ApplicationDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        style: TextStyle(
          height: 1.2,
          color: Color(0xFF212024),
          fontSize: 30,
          fontWeight: FontWeight.w700,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'Philippines Official\n',
          ),
          TextSpan(
            text: 'Job-Matching & LMI\n',
          ),
          TextSpan(
            text: 'Portal',
          ),
        ],
      ),
    );
  }
}
