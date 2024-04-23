import 'package:flutter/material.dart';
import 'package:philjobnet/widgets/header/application_header.dart';

class ApplicationHeaderWithText extends StatelessWidget {
  const ApplicationHeaderWithText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF202124),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // CONTAINER FOR WELCOME TEXT
          Padding(
            padding: EdgeInsets.only(left: 25, top: 20),
            child: Text(
              "Welcome to",
              style: TextStyle(
                height: 0.7,
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFFfefeff),
              ),
            ),
          ),
          // HEADER
          ApplicationHeader(paddingTop: 0, paddingBottom: 10),
        ],
      ),
    );
  }
}
