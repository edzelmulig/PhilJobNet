import 'package:flutter/material.dart';
import 'package:philjobnet/employeer/screens/view_manage/create_job.dart';
import 'package:philjobnet/employeer/screens/view_manage/view_manage_job.dart';
import 'package:philjobnet/services/auth/firebase_firestore_services.dart';
import 'package:philjobnet/services/navigation/custom_animated_navigation.dart';
import 'package:philjobnet/services/navigation/custom_screen_navigation.dart';
import 'package:philjobnet/utils/bottom_modal/custom_confirmation_modal.dart';
import 'package:philjobnet/widgets/button/custom_button.dart';

// ALERT DIALOG CUSTOM CLASS
class CustomAlertDialog extends StatelessWidget {
  final String jobID;
  final dynamic jobPosting;
  final Color backGroundColor;

  const CustomAlertDialog({
    super.key,
    required this.jobID,
    required this.jobPosting,
    required this.backGroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: backGroundColor,
      elevation: 0,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildIcon(),
          _buildJobPosition(jobPosting),
          _buildQuestionText(),
        ],
      ),
      actions: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // UPDATE
            PrimaryCustomButton(
              buttonText: "Update",
              onPressed: () {
                NavigationService.pop(context);
                navigateWithSlideFromRight(
                  context,
                  CreateJobScreen(
                    operation: 'Update',
                    jobPosting: jobPosting,
                    jobID: jobID,
                  ),
                  0.0,
                  1.0,
                );
              },
              buttonHeight: 55,
              buttonColor: const Color(0xFF279778),
              fontWeight: FontWeight.w500,
              fontSize: 17,
              fontColor: Colors.white,
              elevation: 1,
              borderRadius: 10,
            ),
            const SizedBox(height: 10),
            // DELETE
            PrimaryCustomButton(
              buttonText: "Delete",
              onPressed: () {
                showConfirmationModal(
                  context,
                  "Are you sure you want to delete this posted job",
                  'Delete',
                  const ViewManageJobScreen(),
                  false,
                  () {
                    NavigationService.pop(context);
                    FireStoreServices.deleteJob(
                      context: context,
                      jobID: jobID,
                    );
                  },
                );
              },
              buttonHeight: 55,
              buttonColor: const Color(0xFFe91b4f),
              fontWeight: FontWeight.w500,
              fontSize: 17,
              fontColor: Colors.white,
              elevation: 1,
              borderRadius: 10,
            ),
          ],
        )
      ],
    );
  }

  // WIDGET FOR ICON
  Widget _buildIcon() {
    return const ImageIcon(
      AssetImage('images/update_delete.png'),
      color: Color(0xFF3C3C40),
      size: 50,
    );
  }

  // WIDGET FOR JOB POSITION
  Widget _buildJobPosition(dynamic jobPosting) {
    return SizedBox(
      child: Text(
        "${jobPosting.jobType} ${jobPosting.jobPosition}",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 15.5,
          fontWeight: FontWeight.w700,
          color: Color(0xFF3C3C40),
        ),
      ),
    );
  }

  // WIDGET FOR QUESTION TEXT
  Widget _buildQuestionText() {
    return const Text(
      "What would you like to do with this job?",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Color(0xFF3C3C40),
      ),
    );
  }
}
