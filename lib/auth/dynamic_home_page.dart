import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:philjobnet/auth/login_screen.dart';
import 'package:philjobnet/client/home_page.dart';

class DynamicHomePage extends StatefulWidget {
  const DynamicHomePage({super.key});

  @override
  State<DynamicHomePage> createState() => _DynamicHomePage();
}

class _DynamicHomePage extends State<DynamicHomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Container(
              padding: const EdgeInsets.all(5),
              width: 80,
              height: 80,
              child: const LoadingIndicator(
                indicatorType: Indicator.lineSpinFadeLoader,
                colors: [Color(0xFF3499da)],
              ),
            ),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('User data not found.'),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to landing page
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text("Go to Login Page"),
                ),
              ],
            ),
          );
        }

        // Retrieve userType from the snapshot
        final userType = snapshot.data!.get('userType');
        debugPrint("++++ $userType");

        // Check userType and navigate to the corresponding home page
        if (userType == 'client') {
          return const HomePage(); // Navigate to client home page
        } else if (userType == 'Provider') {
          return const HomePage(); // Navigate to service provider home page
        } else {
          // Handle unknown userType (if needed)
          return const Center(
            child: Text('Unknown user type'),
          );
        }
      },
    );
  }
}