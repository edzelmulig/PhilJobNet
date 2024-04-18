import 'package:flutter/material.dart';
import 'package:philjobnet/auth/account_type.dart';
import 'package:philjobnet/widgets/application_header.dart';
import 'package:philjobnet/widgets/custom_button.dart';
import 'package:philjobnet/widgets/custom_label.dart';
import 'package:philjobnet/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // TEXT EDITING CONTROLLERS DECLARATIONS
  final _emailUsernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // FOCUS NODE DECLARATIONS
  final _emailUsernameNode = FocusNode();
  final _passwordNode = FocusNode();

  // DISPOSE
  @override
  void dispose() {
    _emailUsernameController.dispose();
    _passwordController.dispose();
    _emailUsernameNode.dispose();
    _passwordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // 1. HEADER
              const ApplicationHeader(),
              // SPACING
              const SizedBox(height: 60),
              // 2. TEXT
              _buildDescription(),
              // SPACING
              const SizedBox(height: 60),
              // 3. COLUMN OF TEXT FIELD
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // 1. LABEL: Email/Username
                    const CustomLabel(
                      textLabel: "Email/Username",
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontColor: Color(0xFF242424),
                    ),
                    // SIZED BOX: SPACING
                    const SizedBox(height: 2),
                    // 2. EMAIL/USERNAME TEXT FIELD
                    CustomTextField(
                      controller: _emailUsernameController,
                      currentFocusNode: _emailUsernameNode,
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
                    // 3. SPACING
                    const SizedBox(height: 10),
                    // 4. LABEL: Email/Username
                    const CustomLabel(
                      textLabel: "Password",
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontColor: Color(0xFF242424),
                    ),
                    // SIZED BOX: SPACING
                    const SizedBox(height: 2),
                    // 5. PASSWORD TEXT FIELD
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
                  ],
                ),
              ),
              // SPACING
              const SizedBox(height: 5),
              // 4. FORGOT PASSWORD
              Container(
                alignment: Alignment.center,
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                    foregroundColor: const Color(0xFF3499da),
                  ),
                  onPressed: () {
                    // NAVIGATE TO RESET PASSWORD SCREEN
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) =>
                    //       const ForgotPasswordPage()),
                    // );
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              // SPACING
              const SizedBox(height: 25),
              // 5. LOGIN BUTTON
              _buildLoginButton(),
              // SPACING
              const SizedBox(height: 30),
              // 6. SIGN IN USING PHONE NUMBER
              _buildSignInNumber(),
              // 7. DIVIDER
              const Padding(
                padding: EdgeInsets.only(left: 50, right: 50),
                child: Divider(color: Colors.grey),
              ),
              // 8. SIGN UP
              _buildSignUp(context),
              const SizedBox(height: 60),
              _buildApplicationVersion(),
            ],
          ),
        ),
      ),
    );
  }
}

  // Widget for app description
  Widget _buildDescription() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        style: TextStyle(
          height: 1.2,
          color: Color(0xFF212024),
          fontSize: 30,
          fontWeight: FontWeight.w700,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'Philippines Official\n',
          ),
          TextSpan(
            text: 'Job-Matching & LMI\n',
          ),
          TextSpan(
            text: 'Portal',
          ),
        ],
      ),
    );
  }

  // Widget for login button
  Widget _buildLoginButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: PrimaryCustomButton(
        buttonText: "Login",
        onPressed: () {},
        buttonHeight: 55,
        buttonColor: const Color(0xFF3499da),
        fontWeight: FontWeight.w500,
        fontSize: 17,
        fontColor: Colors.white,
        elevation: 1,
        borderRadius: 10,
      ),
    );
  }

  // Widget for login using phone number
  Widget _buildSignInNumber() {
    return Center(
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF3499da),
        ),
        onPressed: () {},
        child: const Text(
          "Login using phone number",
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
      ),
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AccountType(),
                ),
              );
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 15.0,
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
      "Version 191.01963",
      style: TextStyle(
        color: Colors.grey,
        fontSize: 10,
      ),
    );
  }
