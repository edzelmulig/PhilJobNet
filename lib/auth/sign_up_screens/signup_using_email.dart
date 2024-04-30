import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:philjobnet/auth/Sign_up_screens/mobile_number_otp.dart';
import 'package:philjobnet/auth/sign_in_screens/login_screen.dart';
import 'package:philjobnet/models/employer_sign_up_model.dart';
import 'package:philjobnet/services/auth/firebase_auth_services.dart';
import 'package:philjobnet/services/auth/otp_service.dart';
import 'package:philjobnet/services/navigation/custom_screen_navigation.dart';
import 'package:philjobnet/utils/generate_code/generate_random_number.dart';
import 'package:philjobnet/widgets/fotter/application_footer.dart';
import 'package:philjobnet/widgets/header/application_header_with_text.dart';
import 'package:philjobnet/widgets/button/custom_button.dart';
import 'package:philjobnet/widgets/static_widgets/custom_label.dart';
import 'package:philjobnet/widgets/text_field/custom_text_field.dart';

class SignUp extends StatefulWidget {
  final String accountType;
  final String signUpUsing;

  const SignUp({
    super.key,
    required this.accountType,
    required this.signUpUsing,
  });

  @override
  State<SignUp> createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  // TEXT EDITING CONTROLLERS DECLARATIONS
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // FOCUS NODE DECLARATIONS
  final _emailNode = FocusNode();
  final _phoneNumberNode = FocusNode();
  final _passwordNode = FocusNode();
  final _confirmPasswordNode = FocusNode();

  // FORM KEY DECLARATION
  final formKey = GlobalKey<FormState>();

  // DISPOSE
  @override
  void dispose() {
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailNode.dispose();
    _phoneNumberNode.dispose();
    _passwordNode.dispose();
    _confirmPasswordNode.dispose();
    super.dispose();
  }

  // // FUNCTION TO GENERATE 6-DIGIT RANDOM NUMBER
  // String generateRandomNumber() {
  //   final random = Random();
  //   String randomNumber = '';
  //   for (int i = 0; i < 5; i++) {
  //     randomNumber += random.nextInt(10).toString();
  //   }
  //   return randomNumber;
  // }

  // FUNCTION THAT WILL HANDLE THE SIGN UP
  Future<void> performSignUp(EmployerSignUpModel createNewAccount) async {
    await AuthService.signUp(
      context: context,
      formKey: formKey,
      employerSignUpModel: createNewAccount,
      userType: widget.accountType,
    );
  }

  // FUNCTION THAT WILL SEND THE OTP
  // Future<void> sentOTP(String? phoneNumber, String otpMessage) async {
  //   String receiverNumber = '63${phoneNumber!.substring(1)}';
  //   debugPrint("FINAL NUMBER: $receiverNumber");
  //   var url = Uri.parse('https://app.philsms.com/api/v3/sms/send');
  //   var headers = {
  //     'Authorization': smsAPI,
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //   };
  //   var body = jsonEncode({
  //     "recipient": receiverNumber,
  //     "sender_id": "PhilSMS",
  //     "type": 'plain',
  //     "message": otpMessage,
  //   });
  //
  //   try {
  //     var response = await http.post(url, headers: headers, body: body);
  //     if (response.statusCode == 200) {
  //       print('SMS sent successfully: ${response.body}');
  //       debugPrint("SENT GENERATED NUMBER: $otpMessage");
  //     } else {
  //       print('Failed to send SMS: ${response.body}');
  //     }
  //   } catch (error) {
  //     debugPrint('Error sending OTP: $error');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    bool isEmail = widget.signUpUsing == 'Email' ? true : false;
    String generatedNumber = generateRandomNumber();
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
                      // TEXT: SCREEN TITLE
                      _buildTitleText(),
                      // SPACING
                      const SizedBox(height: 13),
                      // LABEL: Email/Username
                      _buildLabel("Email"),
                      // SIZED BOX: SPACING
                      const SizedBox(height: 2),
                      // EMAIL/USERNAME TEXT FIELD
                      CustomTextField(
                        controller: _emailController,
                        currentFocusNode: _emailNode,
                        nextFocusNode:
                            isEmail ? _passwordNode : _phoneNumberNode,
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
                      if (isEmail == false) ...[
                        // SPACING
                        const SizedBox(height: 5),
                        // LABEL: Email/Username
                        _buildLabel("Phone number"),
                        // SIZED BOX: SPACING
                        const SizedBox(height: 2),
                        CustomTextField(
                          controller: _phoneNumberController,
                          currentFocusNode: _phoneNumberNode,
                          nextFocusNode: _passwordNode,
                          keyBoardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validatorText: "Phone number is required",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Phone number is required";
                            } else if (value.length != 11) {
                              return "Invalid phone number. Number must be 11 digits";
                            }
                            return null;
                          },
                          isPassword: false,
                          hintText: "Enter your phone number",
                          minLines: 1,
                          maxLines: 1,
                        ),
                      ],
                      // SPACING
                      const SizedBox(height: 5),
                      // LABEL: Email/Username
                      _buildLabel("Password"),
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
                      _buildLabel("Confirm Password"),
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
                      // SPACING
                      const SizedBox(height: 25),
                      // SEND OTP BUTTON
                      _buildSignUpButton(widget.signUpUsing, generatedNumber),
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

  // WIDGET FOR LABEL
  Widget _buildLabel(String textLabel) {
    return CustomLabel(
      textLabel: textLabel,
      fontSize: 15,
      fontWeight: FontWeight.w500,
      fontColor: const Color(0xFF242424),
    );
  }

  // WIDGET FOR SCREEN TITLE
  Widget _buildTitleText() {
    return const CustomLabel(
      textLabel: "Employer information",
      fontSize: 25,
      fontWeight: FontWeight.w900,
      fontColor: Color(0xFF242424),
      letterSpacing: 0.5,
    );
  }

  // WIDGET FOR BUILDING SIGN UP BUTTON
  Widget _buildSignUpButton(String signUpUsing, String generatedNumber) {
    if (signUpUsing == 'Email') {
      return PrimaryCustomButton(
        buttonText: "Create account",
        onPressed: () {
          // VALIDATE INPUT IN THE CLIENTS SIDE
          if (formKey.currentState!.validate()) {
            // COPY THE INPUT INTO MODEL
            EmployerSignUpModel createNewAccount = EmployerSignUpModel(
              email: _emailController.text.trim(),
              phoneNumber: null,
              password: _passwordController.text.trim(),
            );
            // CALL A FUNCTION THAT WILL HANDLE ON PASSING THE DATA TO BACKEND
            performSignUp(createNewAccount);
          }
        },
        buttonHeight: 55,
        buttonColor: const Color(0xFF3499da),
        fontWeight: FontWeight.w500,
        fontSize: 17,
        fontColor: Colors.white,
        elevation: 1,
        borderRadius: 10,
      );
    } else {
      return PrimaryCustomButton(
        buttonText: "Send OTP",
        onPressed: () {
          // VALIDATE INPUT IN THE CLIENTS SIDE
          if (formKey.currentState!.validate()) {
            // COPY THE INPUT INTO MODEL
            EmployerSignUpModel createNewAccount = EmployerSignUpModel(
              email: _emailController.text.trim(),
              phoneNumber: _phoneNumberController.text.trim(),
              password: _passwordController.text.trim(),
            );

            // SEND OTP NUMBER
            OTPService.sendOTP(
              createNewAccount.phoneNumber,
              "PhilJobNet: Your verification code is: $generatedNumber",
            );

            // CALL A FUNCTION THAT WILL HANDLE ON PASSING THE DATA TO BACKEND
            NavigationService.push(
              context,
              MobileNumberOtp(
                employerSignUpModel: createNewAccount,
                userType: widget.accountType,
                generatedNumber: generatedNumber,
                signUpUsing: widget.signUpUsing,
              ),
            );
          }
        },
        buttonHeight: 55,
        buttonColor: const Color(0xFF3499da),
        fontWeight: FontWeight.w500,
        fontSize: 17,
        fontColor: Colors.white,
        elevation: 1,
        borderRadius: 10,
      );
    }
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
