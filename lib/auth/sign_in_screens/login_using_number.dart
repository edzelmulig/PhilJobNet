import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:philjobnet/services/auth/firebase_auth_services.dart';
import 'package:philjobnet/services/auth/otp_service.dart';
import 'package:philjobnet/utils/floating_snackbar/custom_floating_snackbar.dart';
import 'package:philjobnet/utils/generate_code/generate_random_number.dart';
import 'package:philjobnet/widgets/button/custom_button.dart';
import 'package:philjobnet/widgets/header/application_header.dart';
import 'package:philjobnet/widgets/static_widgets/custom_label.dart';
import 'package:philjobnet/widgets/text_field/custom_text_field.dart';

class LoginUsingNumber extends StatefulWidget {
  const LoginUsingNumber({super.key});

  @override
  State<LoginUsingNumber> createState() => _LoginUsingNumberState();
}

class _LoginUsingNumberState extends State<LoginUsingNumber> {
  // TEXT EDITING CONTROLLERS DECLARATIONS
  final _phoneNumberController = TextEditingController();
  final _verificationCode = TextEditingController();

  // VARIABLE DECLARATION
  bool hasFound = false;
  String email = 'No email found';
  String password = 'No password found';
  String generatedNumber = '';

  // FORM KET FOR INPUT VALIDATION
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _verificationCode.dispose();
    super.dispose();
  }

  // FUNCTION THAT WILL HANDLE THE LOGIN
  Future performSignIn() async {
    try {
      if (formKey.currentState!.validate()) {
        await AuthService.signIn(
          context: context,
          email: email,
          password: password,
        );
      } else {
        // SHOW ERROR MESSAGE IF THERE IS PROBLEM ENCOUNTERED
        customFloatingSnackBar(
          context,
          "Error: Please use your email to login.",
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
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // HEADER
            const ApplicationHeader(paddingTop: 10, paddingBottom: 10),
            // SPACING
            const SizedBox(height: 30),
            // TEXT: SCREEN TITLE
            _buildTitleText(),
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
                    // LABEL: Email/Username
                    _buildLabel("Phone Number"),
                    // SIZED BOX: SPACING
                    const SizedBox(height: 2),
                    // PHONE NUMBER TEXT FIELD
                    CustomTextField(
                      controller: _phoneNumberController,
                      currentFocusNode: null,
                      nextFocusNode: null,
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
                      hintText: "e.g 09123456789",
                      minLines: 1,
                      maxLines: 1,
                    ),
                    if (hasFound == true) ...[
                      // SPACING
                      const SizedBox(height: 10),
                      // LABEL: Email/Username
                      _buildLabel("Verification Code"),
                      // SIZED BOX: SPACING
                      const SizedBox(height: 2),
                      CustomTextField(
                        controller: _verificationCode,
                        currentFocusNode: null,
                        nextFocusNode: null,
                        keyBoardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validatorText: "Invalid verification code",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Verification code is required";
                          } else if (generatedNumber !=
                              _verificationCode.text.trim()) {
                            return "Invalid verification code";
                          }
                          return null;
                        },
                        isPassword: false,
                        hintText: "Enter verification code",
                        minLines: 1,
                        maxLines: 1,
                      ),

                      // SPACING
                      const SizedBox(height: 10),

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
                    ],
                    // SPACING
                    const SizedBox(height: 10),
                    if (hasFound == false) ...[
                      // LOGIN BUTTON
                      _buildConfirmButton(),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // WIDGET FOR SCREEN TITLE
  Widget _buildTitleText() {
    return const Padding(
      padding: EdgeInsets.only(left: 25),
      child: CustomLabel(
        textLabel: "Login using phone number",
        fontSize: 25,
        fontWeight: FontWeight.w900,
        fontColor: Color(0xFF242424),
        letterSpacing: 0.5,
      ),
    );
  }

  // WIDGET THAT WILL HANDLE FOR SEND VERIFICATION CODE BUTTON
  Widget _buildConfirmButton() {
    return PrimaryCustomButton(
      buttonText: "Send verification code",
      onPressed: () async {
        // VALIDATE INPUT
        if (formKey.currentState!.validate()) {
          FirebaseFirestore firestore = FirebaseFirestore.instance;
          final userCollection = firestore.collection('users');

          try {
            // FETCH ALL USERS
            final usersSnapshot = await userCollection.get();

            bool userFound = false;

            // Loop through all user documents to find the matching phone number in nested collections
            for (var userDoc in usersSnapshot.docs) {
              var personalInfoDoc = await userCollection
                  .doc(userDoc.id)
                  .collection('personal_information')
                  .doc('data')
                  .get();

              var userData = personalInfoDoc.data();
              if (userData != null &&
                  userData['phoneNumber'] ==
                      _phoneNumberController.text.trim()) {
                setState(() {
                  email = userData['email'];
                  password = userData['password'];
                });

                userFound = true;
                break;
              }
            }

            if (!userFound) {
              debugPrint('No user found for that phone number.');
              if (context.mounted) {
                customFloatingSnackBar(
                  context,
                  "No user found for that phone number.",
                  const Color(0xFFe91b4f),
                );
              }
            } else {
              setState(() {
                hasFound = true;
              });
              // GENERATE RANDOM NUMBERS
              generatedNumber = generateRandomNumber();
              // SEND OTP NUMBER
              OTPService.sendOTP(
                _phoneNumberController.text.trim(),
                "PhilJobNet: Your verification code is: $generatedNumber",
              );
            }
          } catch (error) {
            if (context.mounted) {
              customFloatingSnackBar(
                context,
                "Error during search: ${error.toString()}",
                const Color(0xFFe91b4f),
              );
            }
          }
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

  // WIDGET FOR LABEL
  Widget _buildLabel(String textLabel) {
    return CustomLabel(
      textLabel: textLabel,
      fontSize: 15,
      fontWeight: FontWeight.w500,
      fontColor: const Color(0xFF242424),
    );
  }
}
