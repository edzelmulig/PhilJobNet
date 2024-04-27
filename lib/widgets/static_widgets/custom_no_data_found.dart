import 'package:flutter/material.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({super.key});

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
            AssetImage('images/no_data_found.png'),
            color: Color(0xFFc2c3c3),
            size: 100,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              children: [
                TextSpan(
                  text: "No jobs posted yet\n",
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
                  text: "When you have posted a job, you'll see them here.",
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
