import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:philjobnet/employeer/screens/view_manage/create_job.dart';
import 'package:philjobnet/employeer/screens/view_manage/job_posted_card.dart';
import 'package:philjobnet/models/job_posting_model.dart';
import 'package:philjobnet/services/auth/firebase_firestore_services.dart';
import 'package:philjobnet/services/navigation/custom_animated_navigation.dart';
import 'package:philjobnet/services/navigation/custom_screen_navigation.dart';
import 'package:philjobnet/widgets/button/custom_button.dart';
import 'package:philjobnet/widgets/header/application_header_appbar.dart';
import 'package:philjobnet/widgets/static_widgets/custom_no_data_found.dart';

class ViewManageJobScreen extends StatelessWidget {
  final String? jobID;

  const ViewManageJobScreen({super.key, this.jobID,});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) async {
        if (_) {
          return;
        }
        NavigationService.pop(context);
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height),
          child: const HeaderAppBar(withLogoutIcon: false),
        ),
        body: Column(
          children: <Widget>[
            // DISPLAY ALL THE JOB POSTED
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FireStoreServices().getPostedJobs(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // DISPLAY LOADING INDICATOR
                    return Center(
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
                  // CHECK IF THERE IS POSTED JOBS TO BE DISPLAYED
                  if (snapshot.data?.docs.isEmpty ?? true) {
                    // DISPLAY NO DATA AVAILABLE
                    return const NoDataFound();
                  } else {
                    // DISPLAY FETCH DATA/POSTED JOBS
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        //final display = snapshot.data!.docs[index].data();
                        //debugPrint("index: $index, $display");
                        final jobData = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                        final data = snapshot.data!.docs[index];
                        final jobID = data.id;
                        final jobPosting = JobPosting.fromMap(jobData);
                        // final DateFormat formatter = DateFormat('hh:mm');
                        // final formattedTime = formatter.format(jobPosting.datePosted!.toDate());
                        // debugPrint("== $formattedTime");

                        return JobPostedCard(
                          jobPosting: jobPosting,
                          jobID: jobID,
                        );
                      },
                    );
                  }
                },
              ),
            ),

            // LOGIN BUTTON
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: PrimaryCustomButton(
                    buttonText: "POST NEW JOB",
                    onPressed: () {
                      navigateWithSlideFromRight(
                        context,
                        CreateJobScreen(
                          operation: 'Post',
                          jobID: jobID,
                        ),
                        0.0,
                        1.0,
                      );
                    },
                    buttonHeight: 55,
                    buttonColor: const Color(0xFF3499da),
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    fontColor: Colors.white,
                    elevation: 1,
                    borderRadius: 10,
                  ),
                ),
              ),
            ),
            // SPACING
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
