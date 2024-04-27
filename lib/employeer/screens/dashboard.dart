import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:philjobnet/employeer/screens/view_applicants.dart';
import 'package:philjobnet/employeer/screens/view_manage/view_manage_job.dart';
import 'package:philjobnet/services/auth/firebase_firestore_services.dart';
import 'package:philjobnet/services/navigation/custom_animated_navigation.dart';
import 'package:philjobnet/widgets/button/custom_button_with_number.dart';
import 'package:philjobnet/widgets/header/application_header_appbar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late int jobCount = 0;

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
        body: StreamBuilder<int>(
          stream: FireStoreServices().countPostedJobs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              Center(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  width: 80,
                  height: 80,
                  child: const LoadingIndicator(
                    indicatorType: Indicator.lineSpinFadeLoader,
                    backgroundColor: Colors.transparent,
                    colors: [Color(0xFF3499da)],
                  ),
                ),
              );
            }
            // HANDLE ERROR DURING FETCHING THE POSTED JOBS
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error: ${snapshot.hasError}",
                ),
              );
            }

            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text("No data available"));
            }

            int jobCount = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.only(left: 13, right: 13),
              child: Column(
                children: <Widget>[
                  // SPACER
                  const Spacer(),

                  // BUTTONS
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFe8f3f8),
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
                          _buildButton(
                            jobCount,
                            const ViewApplicantsScreen(),
                            const Color(0xFF279778),
                            "View applicants",
                          ),
                          // SPACING
                          const SizedBox(height: 10),
                          // JOB POSTED
                          _buildButton(
                            jobCount,
                            const ViewManageJobScreen(),
                            const Color(0xFF3499da),
                            "Manage Job Offers",
                          ),
                        ],
                      ),
                    ),
                  ),
                  // SPACING
                  const SizedBox(height: 15),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // WIDGET FOR BUILDING BUTTON
  Widget _buildButton(
    dynamic data,
    Widget destination,
    Color buttonColor,
    String buttonText,
  ) {
    return CustomButtonWithNumber(
      onPressed: () async {
        navigateWithSlideFromRight(
          context,
          // USE ROUTE HERE
          destination,
          1.0,
          0.0,
        );
      },
      number: data,
      buttonText: buttonText,
      buttonColor: buttonColor,
    );
  }
}
