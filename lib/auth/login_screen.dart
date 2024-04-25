import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:philjobnet/auth/account_type.dart';
import 'package:philjobnet/auth/forgot_password_screen.dart';
import 'package:philjobnet/services/auth/firebase_auth_services.dart';
import 'package:philjobnet/services/navigation/custom_screen_navigation.dart';
import 'package:philjobnet/utils/floating_snackbar/custom_floating_snackbar.dart';
import 'package:philjobnet/widgets/static_widgets/application_description.dart';
import 'package:philjobnet/widgets/header/application_header.dart';
import 'package:philjobnet/widgets/button/custom_button.dart';
import 'package:philjobnet/widgets/static_widgets/custom_label.dart';
import 'package:philjobnet/widgets/button/custom_text_button.dart';
import 'package:philjobnet/widgets/text_field/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // TEXT EDITING CONTROLLERS DECLARATIONS
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // FOCUS NODE DECLARATIONS
  final _emailNode = FocusNode();
  final _passwordNode = FocusNode();

  // FORM KET FOR INPUT VALIDATION
  final formKey = GlobalKey<FormState>();

  // DISPOSE
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailNode.dispose();
    _passwordNode.dispose();
    super.dispose();
  }

  // FUNCTION THAT WILL HANDLE THE LOGIN
  Future performSignIn() async {
    try {
      if (formKey.currentState!.validate()) {
        await AuthService.signIn(
          context: context,
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      } else {
        // SHOW ERROR MESSAGE IF THERE IS PROBLEM ENCOUNTERED
        customFloatingSnackBar(
          context,
          "Please double check your inputs",
          const Color(0xFFe91b4f),
        );
      }
    } catch (error) {
      if (context.mounted) {
        customFloatingSnackBar(
          context,
          "Error login service: ${error.toString()}",
          const Color(0xFFe91b4f),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) async {
        if (_) {
          return;
        }
        SystemNavigator.pop();
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // HEADER
                const ApplicationHeader(paddingTop: 10, paddingBottom: 10),
                // SPACING
                const SizedBox(height: 60),
                // TEXT
                const ApplicationDescription(),
                // SPACING
                const SizedBox(height: 60),
                // COLUMN OF TEXT FIELD
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // LABEL: Email/Username
                        _buildLabel("Email/Username"),
                        // SIZED BOX: SPACING
                        const SizedBox(height: 2),
                        // EMAIL/USERNAME TEXT FIELD
                        CustomTextField(
                          controller: _emailController,
                          currentFocusNode: _emailNode,
                          nextFocusNode: _passwordNode,
                          inputFormatters: null,
                          validatorText: "Email is required",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email is required";
                            }
                            return null;
                          },
                          isPassword: false,
                          hintText: "Enter your email or username",
                          minLines: 1,
                          maxLines: 1,
                        ),
                        // SPACING
                        const SizedBox(height: 10),
                        // LABEL: Email/Username
                        _buildLabel("Password"),
                        // SIZED BOX: SPACING
                        const SizedBox(height: 2),
                        // PASSWORD TEXT FIELD
                        CustomTextField(
                          controller: _passwordController,
                          currentFocusNode: _passwordNode,
                          nextFocusNode: null,
                          inputFormatters: null,
                          validatorText: "Password is required",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password is required";
                            }
                            return null;
                          },
                          isPassword: true,
                          hintText: "Enter your password",
                          minLines: 1,
                          maxLines: 1,
                        ),
                        // SPACING
                        const SizedBox(height: 5),
                        // FORGOT PASSWORD
                        CustomTextButton(
                          buttonText: "Forgot Password?",
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          fontColor: Colors.grey,
                          foreGroundColor: const Color(0xFF3499da),
                          onPressed: () async {
                            await NavigationService.push(
                                context, const ForgotPasswordScreen());
                          },
                        ),
                        // SPACING
                        const SizedBox(height: 25),
                        // LOGIN BUTTON
                        PrimaryCustomButton(
                          buttonText: "Login",
                          onPressed: performSignIn,
                          buttonHeight: 55,
                          buttonColor: const Color(0xFF3499da),
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          fontColor: Colors.white,
                          elevation: 1,
                          borderRadius: 10,
                        ),
                        // SPACING
                        const SizedBox(height: 30),
                        // SIGN IN USING PHONE NUMBER
                        CustomTextButton(
                          buttonText: "Login using phone number",
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          fontColor: Colors.black54,
                          foreGroundColor: const Color(0xFF3499da),
                          onPressed: () async {
                            await NavigationService.push(
                                context, const ForgotPasswordScreen());
                          },
                        ),
                        // DIVIDER
                        const Padding(
                          padding: EdgeInsets.only(left: 25, right: 25),
                          child: Divider(color: Colors.grey),
                        ),
                        // SIGN UP
                        _buildSignUp(context),
                        const SizedBox(height: 60),
                        Center(
                          child: _buildApplicationVersion(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// WIDGET FOR LABEL
Widget _buildLabel(String textLabel) {
  return CustomLabel(
    textLabel: textLabel,
    fontSize: 15,
    fontWeight: FontWeight.w500,
    fontColor: const Color(0xFF242424),
  );
}

// Widget for Sign up
Widget _buildSignUp(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          "Don't have an account?",
          style: TextStyle(
            height: 1.3,
            fontSize: 15.0,
            color: Colors.grey,
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
            foregroundColor: const Color(0xFF3499da),
          ),
          onPressed: () async {
            await NavigationService.push(context, const AccountType());
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(
              fontSize: 15.5,
              fontWeight: FontWeight.w900,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    ),
  );
}

// Widget for application version
Widget _buildApplicationVersion() {
  return const Text(
    "Version 1.91.01963",
    style: TextStyle(
      color: Colors.grey,
      fontSize: 10,
    ),
  );
}
