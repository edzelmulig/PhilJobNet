import 'package:flutter/material.dart';

class ApplicationHeader extends StatelessWidget {
  final double paddingTop;
  final double paddingBottom;

  const ApplicationHeader({
    super.key,
    required this.paddingTop,
    required this.paddingBottom,
  });

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
              margin: EdgeInsets.only(top: paddingTop, bottom: paddingBottom),
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
