import 'package:flutter/material.dart';
import 'package:philjobnet/auth/Sign_up_screens/signup_using_email.dart';
import 'package:philjobnet/auth/sign_in_screens/login_screen.dart';
import 'package:philjobnet/services/navigation/custom_screen_navigation.dart';
import 'package:philjobnet/utils/floating_snackbar/custom_floating_snackbar.dart';
import 'package:philjobnet/widgets/fotter/application_footer.dart';
import 'package:philjobnet/widgets/header/application_header_with_text.dart';
import 'package:philjobnet/widgets/button/custom_button_with_icon.dart';
import 'package:philjobnet/widgets/static_widgets/custom_label.dart';

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
    });
  }

  // FUTURE FUNCTION TO CHECK IF THE TERMS IS SELECTED
  Future proceedToSignUp(bool isEmail) async {
    if (isSelected && isEmail == true) {
      await NavigationService.push(
        context,
        SignUp(
          accountType: widget.accountType,
          signUpUsing: "Email",
        ),
      );
    } else if (isSelected && isEmail == false) {
      await NavigationService.push(
        context,
        SignUp(
          accountType: widget.accountType,
          signUpUsing: "Phone number",
        ),
      );
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
            // TEXT: SCREEN TITLE
            _buildTitleText(),
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
                    onPressed: () => proceedToSignUp(true),
                  ),
                  // SPACING
                  const SizedBox(height: 10),
                  // PHONE NUMBER
                  CustomButtonWithIcon(
                    icon: Icons.phone_rounded,
                    buttonText: 'Continue using Phone number',
                    buttonColor: const Color(0xFF3499da),
                    onPressed: () => proceedToSignUp(false),
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

Widget _buildTitleText() {
  return const CustomLabel(
    textLabel: "SIGN UP USING",
    fontSize: 20,
    fontWeight: FontWeight.w900,
    fontColor: Color(0xFF242424),
    letterSpacing: 1.3,
  );
}

// WIDGET FOR TERMS AND USE POLICY
Widget _buildTermsAndConditions(
  bool isSelected,
  Function(bool) updateSelected,
) {
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
