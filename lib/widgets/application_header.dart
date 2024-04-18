import 'package:flutter/material.dart';

class ApplicationHeader extends StatelessWidget {
  const ApplicationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF212024),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 1. Application logo
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              decoration: const BoxDecoration(
                color: Color(0xFF212024),
              ),
              child: Image.asset(
                'images/logo_philjobnet.png',
                height: 50,
                width: 200,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
