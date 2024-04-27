import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:philjobnet/models/job_posting_model.dart';
import 'package:philjobnet/services/navigation/custom_screen_navigation.dart';
import 'package:philjobnet/utils/floating_snackbar/custom_floating_snackbar.dart';
import 'package:philjobnet/utils/loading_indicator/custom_loading_indicator.dart';

class FireStoreServices {
  static FirebaseFirestore get firestore => FirebaseFirestore.instance;

  static String get userCredential => FirebaseAuth.instance.currentUser!.uid;

  // CREATE JOB
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

      final Timestamp datePosted = Timestamp.now();


      // SAVING DATA TO FIRESTORE
      await firestore
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
        'datePosted': datePosted,
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

  // READ JOBS

  // DELETE JOB
  // static Future deleteJob({
  //   required BuildContext context,
  //   required String jobID,
  // }) async {
  //
  // };

  // STREAM TO GET USER'S JOB POSTED
  Stream<QuerySnapshot<Map<String, dynamic>>> getPostedJobs() {
    return firestore
        .collection('users')
        .doc(userCredential)
        .collection('job_posting')
        .snapshots();
  }

  // COUNT JOB POSTED
  static countJobs() async {
    try {
      QuerySnapshot querySnapshot = await firestore.collection('users').doc(
          userCredential).collection('job_posting').get();

      // RETURN COUNT OF JOB POSTED
      return querySnapshot.docs.length;

    } catch (error) {
      // HANDLE ERROR
      return 0;
    }
  }
}