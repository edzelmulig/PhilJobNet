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
    required String operation,
    String? jobID,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    try {
      // DISPLAY LOADING DIALOG
      showLoadingIndicator(context);

      // INITIALIZE TIMESTAMP EVERY JOB POSTED/UPDATED
      final Timestamp datePosted = Timestamp.now();

      var jobData = {
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
      };

      // DETERMINE WHETHER TO ADD OR UPDATE DATA
      if(operation == 'Post') {
        await firestore
            .collection('users')
            .doc(userCredential)
            .collection('job_posting')
            .add(jobData);
      } else if(operation == 'Update' && jobID != null){
        await firestore
            .collection('users')
            .doc(userCredential)
            .collection('job_posting')
            .doc(jobID)
            .set(jobData, SetOptions(merge: true));
      }



      // IF POSTING JOB IS SUCCESSFUL
      if (context.mounted) {
        // DISMISS LOADING DIALOG
        if (context.mounted) {
          NavigationService.pop(context);
          customFloatingSnackBar(
            context,
            'Job successfully created and posted.',
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
  static Future deleteJob({
    required BuildContext context,
    required String jobID,
  }) async {
    try {
      // DISPLAY LOADING DIALOG
      showLoadingIndicator(context);

      // DELETE THE JOB POSTED
      DocumentReference documentReference = firestore
          .collection('users')
          .doc(userCredential)
          .collection('job_posting')
          .doc(jobID);

      // DELETE THE JOB
      await documentReference.delete();

      // IF DELETING POSTED JOB IS SUCCESSFUL
      if (context.mounted) {
        // DISMISS LOADING DIALOG
        if (context.mounted) {
          NavigationService.pop(context);
          customFloatingSnackBar(
            context,
            'Job removed successfully!',
            const Color(0xFF3499da),
          );
        }
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


  // STREAM TO GET USER'S JOB POSTED
  Stream<QuerySnapshot<Map<String, dynamic>>> getPostedJobs() {
    return firestore
        .collection('users')
        .doc(userCredential)
        .collection('job_posting')
        .orderBy('datePosted', descending: true)
        .snapshots();
  }

  // COUNT ALL THE JOB POSTED
  Stream<int> countPostedJobs() {
    return firestore
        .collection('users')
        .doc(userCredential)
        .collection('job_posting')
        .snapshots()
        .map((snapshot) => snapshot.size);  // Map each snapshot to its document count
  }
}
