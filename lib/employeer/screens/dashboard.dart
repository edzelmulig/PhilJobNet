import 'package:flutter/material.dart';
import 'package:philjobnet/employeer/screens/view_applicants.dart';
import 'package:philjobnet/employeer/screens/view_manage/view_manage_job.dart';
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
          child: const HeaderAppBar(withLogoutIcon: true),
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
                      // APPLICANTS
                      CustomButtonWithNumber(
                        onPressed: () async {
                          navigateWithSlideFromRight(
                            context,
                            const ViewApplicantsScreen(),
                            1.0,
                            0.0,
                          );
                        },
                        number: 5,
                        buttonText: "View applicants",
                        buttonColor: const Color(0xFF279778),
                      ),
                      // SPACING
                      const SizedBox(height: 10),
                      // JOB POSTED
                      CustomButtonWithNumber(
                        onPressed: () async {
                          navigateWithSlideFromRight(
                            context,
                            const ViewManageJobScreen(),
                            1.0,
                            0.0,
                          );
                        },
                        number: 10,
                        buttonText: "View & Manage Job Offers",
                        buttonColor: const Color(0xFF3499da),
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
