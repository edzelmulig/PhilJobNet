import 'package:flutter/material.dart';
import 'package:philjobnet/auth/login_screen.dart';
import 'package:philjobnet/services/auth/firebase_auth_services.dart';
import 'package:philjobnet/services/navigation/custom_screen_navigation.dart';
import 'package:philjobnet/utils/floating_snackbar/custom_floating_snackbar.dart';
import 'package:philjobnet/widgets/fotter/application_footer.dart';
import 'package:philjobnet/widgets/header/application_header_with_text.dart';
import 'package:philjobnet/widgets/button/custom_button.dart';
import 'package:philjobnet/widgets/static_widgets/custom_label.dart';
import 'package:philjobnet/widgets/text_field/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  final String accountType;

  const SignUpScreen({
    super.key,
    required this.accountType,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // TEXT EDITING CONTROLLERS DECLARATIONS
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // FOCUS NODE DECLARATIONS
  final _emailNode = FocusNode();
  final _passwordNode = FocusNode();
  final _confirmPasswordNode = FocusNode();

  // FORM KEY DECLARATION
  final formKey = GlobalKey<FormState>();

  // DISPOSE
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailNode.dispose();
    _passwordNode.dispose();
    _confirmPasswordNode.dispose();
    super.dispose();
  }

  // FUNCTION THAT WILL HANDLE THE SIGN UP
  Future<void> performSignUp() async {
    try {
      if (formKey.currentState!.validate()) {
        await AuthService.signUp(
          context: context,
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          userType: widget.accountType.trim(),
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
          "Error updating service: ${error.toString()}",
          const Color(0xFFe91b4f),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // HEADER
              const ApplicationHeaderWithText(),
              // SPACING
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Form(
                  autovalidateMode: AutovalidateMode.disabled,
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // TEXT: SIGN UP USING EMAIL
                      _buildTextTitle(),
                      // SPACING
                      const SizedBox(height: 13),
                      // LABEL: Email/Username
                      const CustomLabel(
                        textLabel: "Email",
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontColor: Color(0xFF242424),
                      ),
                      // SIZED BOX: SPACING
                      const SizedBox(height: 2),
                      // EMAIL/USERNAME TEXT FIELD
                      CustomTextField(
                        controller: _emailController,
                        currentFocusNode: _emailNode,
                        nextFocusNode: _passwordNode,
                        inputFormatters: null,
                        validatorText: "Email address is required",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email address is required";
                          }
                          return null;
                        },
                        isPassword: false,
                        hintText: "Enter your email address",
                        minLines: 1,
                        maxLines: 1,
                      ),
                      // SPACING
                      const SizedBox(height: 5),
                      // LABEL: Email/Username
                      const CustomLabel(
                        textLabel: "Password",
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontColor: Color(0xFF242424),
                      ),
                      // SIZED BOX: SPACING
                      const SizedBox(height: 2),
                      // PASSWORD TEXT FIELD
                      CustomTextField(
                        controller: _passwordController,
                        currentFocusNode: _passwordNode,
                        nextFocusNode: _confirmPasswordNode,
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
                      // LABEL: Email/Username
                      const CustomLabel(
                        textLabel: "Confirm Password",
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontColor: Color(0xFF242424),
                      ),
                      // SIZED BOX: SPACING
                      const SizedBox(height: 2),
                      // PASSWORD TEXT FIELD
                      CustomTextField(
                        controller: _confirmPasswordController,
                        currentFocusNode: _confirmPasswordNode,
                        nextFocusNode: null,
                        inputFormatters: null,
                        validatorText:
                            "Password and Confirm Password does not match",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password cannot be empty";
                          } else if (value.length < 6) {
                            return "Password must be at least 6 characters long";
                          } else if (value != _passwordController.text) {
                            return "Password and Confirm Password does not match";
                          }
                          // PASSWORD IS VALUE RETURN NULL
                          return null;
                        },
                        isPassword: true,
                        hintText: "Confirm your password",
                        minLines: 1,
                        maxLines: 1,
                      ),
                      // SIGN UP BUTTON
                      // SPACING
                      const SizedBox(height: 25),
                      // LOGIN BUTTON
                      PrimaryCustomButton(
                        buttonText: "Create account",
                        onPressed: performSignUp,
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextTitle() {
    return const Text(
      "Create account",
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w900,
        letterSpacing: 0.5,
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
}
