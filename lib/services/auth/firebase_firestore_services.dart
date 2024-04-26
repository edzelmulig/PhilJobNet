import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:philjobnet/models/job_posting_model.dart';
import 'package:philjobnet/services/navigation/custom_screen_navigation.dart';
import 'package:philjobnet/utils/floating_snackbar/custom_floating_snackbar.dart';
import 'package:philjobnet/utils/loading_indicator/custom_loading_indicator.dart';

class FireStoreServices {
  // CREATE NEW JOB
  static Future createJob({
    // PARAMETERS NEEDED
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required JobPosting jobPosting,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    try {
      // DISPLAY LOADING DIALOG
      showLoadingIndicator(context);

      final userCredential = FirebaseAuth.instance.currentUser!.uid;

      // SAVING DATA TO FIRESTORE
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential)
          .collection('job_posting')
          .add({
        'jobCategory': jobPosting.jobCategory,
        'jobType': jobPosting.jobType,
        'jobPosition': jobPosting.jobPosition,
        'companyName': jobPosting.companyName,
        'jobLocation': jobPosting.jobLocation,
        'jobExperience': jobPosting.jobExperience,
        'minimumSalary': jobPosting.minimumSalary,
        'maximumSalary': jobPosting.maximumSalary,
        'salaryType': jobPosting.salaryType,
      });

      // IF POSTING JOB IS SUCCESSFUL
      if (context.mounted) {
        // DISMISS LOADING DIALOG
        if (context.mounted) {
          NavigationService.pop(context);
          customFloatingSnackBar(
            context,
            'Service created successfully.',
            const Color(0xFF3499da),
          );
        }
        // POP THE CURRENT SCREEN
        NavigationService.pop(context);
      }
    } catch (error) {
      // ERROR HANDLING SNACKBAR
      if (context.mounted) {
        customFloatingSnackBar(
          context,
          "Error updating service: ${error.toString()}",
          const Color(0xFFe91b4f),
        );
        // DISMISS LOADING DIALOG
        if (context.mounted) {
          NavigationService.pop(context);
        }
      }
    }
  }
}
