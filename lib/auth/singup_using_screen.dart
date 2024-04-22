import 'package:flutter/material.dart';
import 'package:philjobnet/auth/login_screen.dart';
import 'package:philjobnet/auth/signup_screen.dart';
import 'package:philjobnet/services/navigation/custom_navigation.dart';
import 'package:philjobnet/utils/floating_snackbar/custom_floating_snackbar.dart';
import 'package:philjobnet/widgets/application_footer.dart';
import 'package:philjobnet/widgets/application_header_with_text.dart';
import 'package:philjobnet/widgets/custom_button_with_icon.dart';

class SignUpUsingScreen extends StatefulWidget {
  // PARAMETERS NEEDED
  final String accountType;

  const SignUpUsingScreen({
    super.key,
    required this.accountType,
  });

  @override
  State<SignUpUsingScreen> createState() => _SignUpUsingScreen();
}

class _SignUpUsingScreen extends State<SignUpUsingScreen> {
  bool isSelected = false;

  // FUNCTION THAT WILL UPDATE THE VALUE OF TERMS OF USE
  void updateSelected(bool value) {
    setState(() {
      isSelected = value;
      debugPrint(isSelected.toString());
    });
  }

  // FUTURE FUNCTION TO CHECK IF THE TERMS IS SELECTED
  Future proceedToSignUp() async {
    if (isSelected) {
      await NavigationService.push(context, SignUpScreen(accountType: widget.accountType,));
    } else {
      customFloatingSnackBar(
        context,
        'Please agree to Terms of use and Privacy to proceed.',
        const Color(0xFF242424),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            // HEADER
            const ApplicationHeaderWithText(),
            // SPACING
            const SizedBox(height: 50),
            // TEXT: SIGN UP USING
            _buildSignUpUsingText(),
            // SPACING
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Column(
                children: <Widget>[
                  // EMAIL
                  CustomButtonWithIcon(
                    icon: Icons.email_rounded,
                    buttonText: 'Continue using Email',
                    buttonColor: const Color(0xFFe14a42),
                    onPressed: proceedToSignUp,
                  ),
                  // SPACING
                  const SizedBox(height: 10),
                  // PHONE NUMBER
                  CustomButtonWithIcon(
                    icon: Icons.phone_rounded,
                    buttonText: 'Continue using Phone number',
                    buttonColor: const Color(0xFF3499da),
                    onPressed: proceedToSignUp,
                  ),
                  // SPACING
                  const SizedBox(height: 20),
                  // TERMS AND CONDITIONS
                  _buildTermsAndConditions(isSelected, updateSelected),
                  // SPACING
                  const SizedBox(height: 15),
                  // DIVIDER
                  const Padding(
                    padding: EdgeInsets.only(left: 25, right: 25),
                    child: Divider(color: Colors.grey),
                  ),
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
Widget _buildSignUpUsingText() {
  return const Center(
    child: Text(
      "SIGN UP USING",
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.3,
        color: Color(0xFF212024),
      ),
    ),
  );
}

// WIDGET FOR TERMS AND USE POLICY
Widget _buildTermsAndConditions(
    bool isSelected, Function(bool) updateSelected) {
  return Row(
    children: <Widget>[
      // RADIO BUTTON
      Checkbox(
        value: isSelected,
        onChanged: (bool? value) {
          updateSelected(value ?? false);
        },
        activeColor: const Color(0xFF212024),
        fillColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return const Color(0xFF3499da);
            }
            return Colors.white;
          },
        ),
      ),
      Expanded(
        child: RichText(
          text: const TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: "I have agreed to the ",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.black54,
                ),
              ),
              TextSpan(
                text: "Terms of Use & Privacy Policy",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
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