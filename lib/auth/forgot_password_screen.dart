import 'package:flutter/material.dart';
import 'package:philjobnet/auth/sign_in_screens/login_screen.dart';
import 'package:philjobnet/services/auth/firebase_auth_services.dart';
import 'package:philjobnet/services/navigation/custom_screen_navigation.dart';
import 'package:philjobnet/widgets/fotter/application_footer.dart';
import 'package:philjobnet/widgets/header/application_header.dart';
import 'package:philjobnet/widgets/button/custom_button.dart';
import 'package:philjobnet/widgets/static_widgets/custom_label.dart';
import 'package:philjobnet/widgets/text_field/custom_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // TEXT EDITING CONTROLLERS DECLARATIONS
  final _emailController = TextEditingController();

  // FORM KET FOR INPUT VALIDATION
  final formKey = GlobalKey<FormState>();

  // DISPOSE
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // FUNCTION THAT WILL HANDLE THE PASSWORD RESET
  Future performPasswordReset() async {
    AuthService.passwordReset(
      context: context,
      email: _emailController.text.trim(),
      formKey: formKey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // HEADER
              const ApplicationHeader(paddingTop: 10, paddingBottom: 10),
              // SPACING
              const SizedBox(height: 30),
              // TEXT: SCREEN TITLE
              _buildTitleText(),
              // SPACING
              const SizedBox(height: 13),
              // TEXT: ACCOUNT TYPE
              _buildForgotPasswordText(),
              // SPACING
              const SizedBox(height: 10),
              Form(
                autovalidateMode: AutovalidateMode.disabled,
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // SIZED BOX: SPACING
                      const SizedBox(height: 5),
                      // EMAIL/USERNAME TEXT FIELD
                      CustomTextField(
                        controller: _emailController,
                        currentFocusNode: null,
                        nextFocusNode: null,
                        inputFormatters: null,
                        validatorText: "Email address is required",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email address is required";
                          }
                          return null;
                        },
                        isPassword: false,
                        hintText: "Enter the email address",
                        minLines: 1,
                        maxLines: 1,
                      ),
                      // SPACING
                      const SizedBox(height: 10),
                      // LOGIN BUTTON
                      PrimaryCustomButton(
                        buttonText: "Reset Password",
                        onPressed: performPasswordReset,
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
                      _buildSignIn(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleText() {
    return const Padding(
      padding: EdgeInsets.only(left: 25),
      child: CustomLabel(
        textLabel: "Reset password",
        fontSize: 25,
        fontWeight: FontWeight.w900,
        fontColor: Color(0xFF242424),
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildForgotPasswordText() {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Align(
        alignment: Alignment.topLeft,
        child: RichText(
          text: const TextSpan(children: <TextSpan>[
            TextSpan(
              text: "Enter your email address and select ",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Color(0xFF3C3C40),
              ),
            ),
            TextSpan(
              text: "Reset Password.",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xFF3C3C40),
              ),
            ),
          ]),
        ),
      ),
    );
  }


  // WIDGET TO NAVIGATE LOGIN SCREEN
  Widget _buildSignIn(BuildContext context) {
    return ApplicationFooter(
      buttonQuestionText: "Remember your account?",
      onPressed: () async {
        await NavigationService.push(context, const LoginScreen());
      },
      buttonText: "Sign In",
    );
  }
}
