import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:philjobnet/auth/dynamic_home_page.dart';
import 'package:philjobnet/auth/login_screen.dart';
import 'package:philjobnet/services/navigation/custom_navigation.dart';
import 'package:philjobnet/utils/floating_snackbar/custom_floating_snackbar.dart';
import 'package:philjobnet/utils/loading_indicator/custom_loading_indicator.dart';
import 'package:email_validator/email_validator.dart';

class AuthService {
  // SIGN IN AUTHENTICATION
  static Future signIn({
    // PARAMETERS NEEDED
    required BuildContext context,
    required email,
    required password,
  }) async {
    try {
      // DISPLAY LOADING INDICATOR
      showLoadingIndicator(context);

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // DISMISS LOADING INDICATOR
      if (context.mounted) {
        NavigationService.pop(context);
      }

      // NAVIGATE TO HOME PAGE AFTER SUCCESSFUL SIGN-IN
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const DynamicHomePage(),
          ),
        );
      }
    } on FirebaseAuthException catch (error) {
      // HANDLE FirebaseAuthException ERROR
      String errorMessage;
      if (error.code == 'user-not-found') {
        errorMessage =
            'Account not found. Please check your email and try again.';
      } else {
        errorMessage = 'Incorrect email or password. Please try again.';
      }

      // UPDATE ERROR MESSAGE
      if (context.mounted) {
        customFloatingSnackBar(
          context,
          errorMessage,
          const Color(0xFFe91b4f),
        );
      }

      // DISMISS LOADING DIALOG
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    } catch (error) {
      // DISPLAY ERROR MESSAGE IF FAILED TO LOGIN
      if (context.mounted) {
        await NavigationService.pop(context);
        if (context.mounted) {
          customFloatingSnackBar(
            context,
            "Error signing in: ${error.toString()}",
            const Color(0xFFe91b4f),
          );
        }
      }
    }
  }

  // SIGN UP AUTHENTICATION
  static Future signUp({
    // PARAMETERS NEEDED
    required BuildContext context,
    required email,
    required password,
    required userType,
  }) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        // DISPLAY LOADING INDICATOR
        showLoadingIndicator(context);

        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        );

        // SET USER TYPE
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          'userType': userType,
        });

        // SAVE ACCOUNT INFO TO FIRESTORE
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .collection('personal_information')
            .doc('data')
            .set({
          'email': email,
          'password': password,
          'userType': userType,
        });

        // DISMISS LOADING DIALOG
        if (context.mounted) {
          await NavigationService.pop(context);
        }

        // DISPLAY IF ACCOUNT CREATED SUCCESSFULLY
        if (context.mounted) {
          customFloatingSnackBar(
            context,
            'Account created successfully.',
            const Color(0xFF3499da),
          );
        }

        // NAVIGATE TO LOGIN SCREEN
        if (context.mounted) {
          await NavigationService.pushReplacement(context, const LoginScreen());
        }
      } catch (error) {
        // DISPLAY IF FAILED TO CREATE THE ACCOUNT
        if (context.mounted) {
          await NavigationService.pop(context);
          if (context.mounted) {
            customFloatingSnackBar(
              context,
              "Error signing up: ${error.toString()}",
              const Color(0xFFe91b4f),
            );
          }
        }
      }
    }
  }

  // RESET PASSWORD
  static Future passwordReset({
    // PARAMETERS NEEDED
    required BuildContext context,
    required email,
    required GlobalKey<FormState> formKey,
  }) async {
    if (formKey.currentState!.validate()) {
      final bool isEmailValid = EmailValidator.validate(email);
      if(isEmailValid) {
        try {
          await FirebaseAuth.instance.sendPasswordResetEmail(
            email: email,
          );

          if (!context.mounted) return;
          await NavigationService.pop(context);
          if (context.mounted) {
            customFloatingSnackBar(
              context,
              "Please check your email for the reset link.",
              const Color(0xFF3499da),
            );
          }
        } on FirebaseAuthException catch (e) {
          print(e);
        }
      } else {
        customFloatingSnackBar(
          context,
          "Please enter a valid email address.",
          const Color(0xFFe91b4f),
        );
      }
    }
  }
}
