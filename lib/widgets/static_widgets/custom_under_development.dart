import 'package:flutter/material.dart';

class UnderDevelopment extends StatelessWidget {
  const UnderDevelopment({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // SPACING
          const SizedBox(height: 5),
          // ICON
          const ImageIcon(
            AssetImage('images/under_development.png'),
            color: Color(0xFFc2c3c3),
            size: 100,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              children: [
                TextSpan(
                  text: "Feature under development\n",
                  style: TextStyle(
                    color: Color(0xFFc2c3c3),
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                // SPACING
                WidgetSpan(
                  child: SizedBox(height: 20),
                ),
                TextSpan(
                  text: "Contact your developer.",
                  style: TextStyle(
                    color: Color(0xFFc2c3c3),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
