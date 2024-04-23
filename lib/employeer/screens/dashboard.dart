import 'package:flutter/material.dart';
import 'package:philjobnet/employeer/screens/job_posted.dart';
import 'package:philjobnet/services/navigation/custom_animated_navigation.dart';
import 'package:philjobnet/widgets/button/custom_button_with_number.dart';
import 'package:philjobnet/widgets/header/application_header_appbar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) async {
        if (_) {
          return;
        }
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height),
          child: const HeaderAppBar(),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 13, right: 13),
          child: Column(
            children: <Widget>[
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE1DEDE),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 12,
                    top: 12,
                    right: 12,
                    bottom: 12,
                  ),
                  child: Column(
                    children: <Widget>[
                      // JOB POSTED
                      Tooltip(
                        message: "View job posted",
                        child: CustomButtonWithNumber(
                          onPressed: () async {
                            navigateWithSlideFromRight(
                              context,
                              const JobPostedScreen(),
                              1.0,
                              0.0,
                            );
                          },
                          number: 10,
                          buttonText: "Job posted",
                          buttonColor: const Color(0xFF3499da),
                        ),
                      ),
                      // SPACING
                      const SizedBox(height: 10),
                      // APPLICANTS
                      Tooltip(
                        message: "View applicants applied",
                        child: CustomButtonWithNumber(
                          onPressed: () async {
                            navigateWithSlideFromRight(
                              context,
                              const JobPostedScreen(),
                              1.0,
                              0.0,
                            );
                          },
                          number: 5,
                          buttonText: "Applicants applied",
                          buttonColor: const Color(0xFF279778),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // SPACING
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
