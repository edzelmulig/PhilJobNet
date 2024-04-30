import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:philjobnet/auth/sign_in_screens/login_screen.dart';
import 'package:philjobnet/services/navigation/custom_screen_navigation.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
            onTap: () async {
              // LOG OUT, NAVIGATE TO LOGIN PAGE
              FirebaseAuth.instance.signOut();
              await NavigationService.removeAllAndPush(
                  context, const LoginScreen());
            },
            child: const Text("Logout")),
      ),
      body: const Center(
        child: Text("WELCOME JOB SEEKER"),
      ),
    );
  }
}
