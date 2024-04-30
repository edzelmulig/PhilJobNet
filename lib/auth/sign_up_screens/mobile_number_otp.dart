import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:philjobnet/models/employer_sign_up_model.dart';
import 'package:philjobnet/services/auth/firebase_auth_services.dart';
import 'package:philjobnet/utils/floating_snackbar/custom_floating_snackbar.dart';
import 'package:philjobnet/widgets/button/custom_button.dart';
import 'package:philjobnet/widgets/header/application_header.dart';
import 'package:philjobnet/widgets/static_widgets/custom_label.dart';
import 'package:philjobnet/widgets/text_field/custom_text_field.dart';

class MobileNumberOtp extends StatefulWidget {
  final EmployerSignUpModel employerSignUpModel;
  final String userType;
  final String generatedNumber;
  final String signUpUsing;

  const MobileNumberOtp({
    super.key,
    required this.employerSignUpModel,
    required this.userType,
    required this.generatedNumber,
    required this.signUpUsing,
  });

  @override
  State<MobileNumberOtp> createState() => _MobileNumberOtpState();
}

class _MobileNumberOtpState extends State<MobileNumberOtp> {
  // TEXT EDITING CONTROLLERS DECLARATIONS
  final _otpNumberController = TextEditingController();

  // FORM KET FOR INPUT VALIDATION
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _otpNumberController.dispose();
    super.dispose();
  }

  // FUNCTION THAT WILL PERFORM SIGN UP
  Future<void> performSignUp() async {
    await await AuthService.signUp(
      context: context,
      formKey: formKey,
      employerSignUpModel: widget.employerSignUpModel,
      userType: widget.userType,
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
              // TEXT: MESSAGE
              _buildVerificationCodeText(),
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
                      // PHONE NUMBER TEXT FIELD
                      CustomTextField(
                        controller: _otpNumberController,
                        currentFocusNode: null,
                        nextFocusNode: null,
                        keyBoardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validatorText: "Please enter the verification code.",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter the verification code.";
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
                      _buildConfirmButton(),
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
        textLabel: "Account verification",
        fontSize: 25,
        fontWeight: FontWeight.w900,
        fontColor: Color(0xFF242424),
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildVerificationCodeText() {
    return const Padding(
      padding: EdgeInsets.only(left: 25),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          "A verification code has been sent to your number.",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Color(0xFF3C3C40),
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return PrimaryCustomButton(
      buttonText: "Confirm",
      onPressed: () {
        String inputtedOTP = _otpNumberController.text.trim();
        debugPrint("Generated number: ${widget.generatedNumber}");
        debugPrint("Inputted number: $inputtedOTP");

        if (formKey.currentState!.validate()) {
          if (inputtedOTP == widget.generatedNumber) {
            debugPrint("SUCCESS!");
            customFloatingSnackBar(
              context,
              "Verification Successful!",
              const Color(0xFF279778),
            );
            performSignUp();
          } else {
            debugPrint("FAILED!");
            _otpNumberController.clear();
            customFloatingSnackBar(
              context,
              "Invalid verification code!",
              const Color(0xFFe91b4f),
            );
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
}
