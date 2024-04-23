import 'package:flutter/material.dart';
import 'package:philjobnet/auth/login_screen.dart';
import 'package:philjobnet/auth/singup_using_screen.dart';
import 'package:philjobnet/services/navigation/custom_screen_navigation.dart';
import 'package:philjobnet/widgets/fotter/application_footer.dart';
import 'package:philjobnet/widgets/header/application_header.dart';
import 'package:philjobnet/widgets/button/custom_button.dart';
import 'package:philjobnet/widgets/button/custom_role_selection.dart';

class AccountType extends StatefulWidget {
  const AccountType({super.key});

  @override
  State<AccountType> createState() => _AccountTypeState();
}

class _AccountTypeState extends State<AccountType> {
  bool isClientSelected = true;
  bool isProviderSelected = false;
  String selectedRole = 'client';

  @override
  void dispose() {
    selectedRole = 'client';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // HEADER
            const ApplicationHeader(paddingTop: 10, paddingBottom: 10),
            // SPACING
            const SizedBox(height: 50),
            // TEXT: ACCOUNT TYPE
            _buildAccountTypeText(),
            // SPACING
            const SizedBox(height: 20),
            // COLUMNS OF BUTTONS
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Column(
                children: <Widget>[
                  // CLIENT
                  CustomRoleSelection(
                    buttonText: 'I am looking for work',
                    isSelected: selectedRole == 'client' ? true : false,
                    onPressed: () {
                      setState(() {
                        selectedRole = 'client';
                      });
                    },
                  ),
                  // SPACING
                  const SizedBox(height: 10),
                  // EMPLOYER
                  CustomRoleSelection(
                    buttonText: 'I am offering employment',
                    isSelected: selectedRole == 'employer' ? true : false,
                    onPressed: () {
                      setState(() {
                        selectedRole = 'employer';
                      });
                    },
                  ),
                  // SPACING
                  const SizedBox(height: 20),
                  // LOGIN BUTTON
                  PrimaryCustomButton(
                    buttonText: "Create account",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SignUpUsingScreen(accountType: selectedRole),
                        ),
                      );
                    },
                    buttonHeight: 55,
                    buttonColor: const Color(0xFF3499da),
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                    fontColor: Colors.white,
                    elevation: 1,
                    borderRadius: 10,
                  ),
                  // SPACING
                  const SizedBox(height: 20),
                  // FOOTER
                  _buildSignIn(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// WIDGET FOR SCREEN DESCRIPTION
Widget _buildAccountTypeText() {
  return const Center(
    child: Text(
      "SELECT ACCOUNT TYPE",
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.3,
        color: Color(0xFF212024),
      ),
    ),
  );
}

// WIDGET TO NAVIGATE LOGIN SCREEN
Widget _buildSignIn(BuildContext context) {
  return ApplicationFooter(
    buttonQuestionText: "Already have an account?",
    onPressed: () async {
      await NavigationService.push(context, const LoginScreen());
    },
    buttonText: "Sign In",
  );
}