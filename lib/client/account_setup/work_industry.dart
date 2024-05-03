import 'package:flutter/material.dart';
import 'package:philjobnet/client/account_setup/home_page.dart';
import 'package:philjobnet/services/navigation/custom_animated_navigation.dart';
import 'package:philjobnet/widgets/button/custom_button.dart';
import 'package:philjobnet/widgets/button/custom_navigation_button.dart';
import 'package:philjobnet/widgets/header/application_header_with_text.dart';

class WorkIndustry extends StatelessWidget {

  const WorkIndustry({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // HEADER
            const ApplicationHeaderWithText(),
            // COLUMN
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // LABEL
                          _buildTitleText(context, "Job Preferences"),
                          // DESCRIPTION
                          _buildDescriptionText(),
                          // SPACING
                          const SizedBox(height: 15),
                          // WORK INDUSTRY
                          CustomNavigationButton(
                            textButton: "Work Industry",
                            textColor: const Color(0xFF3C3C40),
                            onPressed: () {
                              navigateWithSlideFromRight(
                                context,
                                const HomePage(),
                                1.0,
                                0.0,
                              );
                            },
                          ),
                          // SPACING
                          const SizedBox(height: 10),

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // WIDGET FOR TITLE TEXT
  Widget _buildTitleText(BuildContext context, String textLabel) {
    return Text(
      textLabel,
      style: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w900,
        color: Color(0xFF202124),
      ),
    );
  }

  // WIDGET FOR DESCRIPTION
  Widget _buildDescriptionText() {
    return RichText(
      text: const TextSpan(
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.normal,
          color: Color(0xFF202124),
        ),
        children: <TextSpan>[
          TextSpan(text: "By setting your preferences, we can suggest "),
          TextSpan(text: "the best jobs for your skills and interests."),
        ],
      ),
    );
  }

  // WIDGET FOR NEXT BUTTON
  Widget _buildNextButton() {
    return PrimaryCustomButton(
      buttonText: "Save information",
      onPressed: () {},
      buttonHeight: 55,
      buttonColor: const Color(0xFF3499da),
      fontWeight: FontWeight.w500,
      fontSize: 17,
      fontColor: Colors.white,
      elevation: 1,
      borderRadius: 7,
    );
  }
}
