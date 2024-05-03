import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:philjobnet/client/account_setup/job_preferences.dart';
import 'package:philjobnet/models/account_setup_model.dart';
import 'package:philjobnet/services/auth/firebase_auth_services.dart';
import 'package:philjobnet/services/navigation/custom_animated_navigation.dart';
import 'package:philjobnet/utils/floating_snackbar/custom_floating_snackbar.dart';
import 'package:philjobnet/widgets/button/custom_button.dart';
import 'package:philjobnet/widgets/header/application_header_with_text.dart';
import 'package:philjobnet/widgets/static_widgets/custom_label.dart';
import 'package:philjobnet/widgets/text_field/custom_text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // TEXT EDITING CONTROLLERS DECLARATIONS
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  // FOCUS NODE DECLARATIONS
  final _firstNameNode = FocusNode();
  final _lastNameNode = FocusNode();

  // FORM KET FOR INPUT VALIDATION
  final formKey = GlobalKey<FormState>();

  // WITH EXPERIENCE OPTIONS
  int selectedExperience = 0;
  String selectedExperienceText = '';

  // WORK OPTION
  int selectedWorkButton = 0;
  String selectedWorkButtonText = '';

  final Map<int, String> experienceOptions = {
    1: 'With experience',
    2: 'New applicant',
  };

  final Map<int, String> workAvailabilityOptions = {
    1: 'Anytime',
    2: '1 week',
    3: '2 weeks',
    4: '3 weeks',
    5: '1 month',
    6: '2 months about',
  };

  void _updateSelectedExperience(int index) {
    setState(() {
      selectedExperience = index;
      selectedExperienceText = workAvailabilityOptions[selectedExperience]!;
    });
  }

  void _updateSelectedWorkButton(int index) {
    setState(() {
      selectedWorkButton = index;
      selectedWorkButtonText = workAvailabilityOptions[selectedWorkButton]!;
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _firstNameNode.dispose();
    _lastNameNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) async {
        if (_) {
          return;
        }
        AuthService.logout(context: context);
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // HEADER
                const ApplicationHeaderWithText(),
                // COLUMN
                Padding(
                  padding: const EdgeInsets.only(
                    left: 25,
                    top: 20,
                    right: 25,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // LABEL
                        _buildTitleText("Basic Information"),
                        // DESCRIPTION
                        _buildDescriptionText(),
                        // SPACING
                        const SizedBox(height: 15),
                        // FIRST NAME
                        _buildTextField(
                          _firstNameController,
                          _firstNameNode,
                          _lastNameNode,
                          null,
                          "First name",
                          false,
                          "First Name",
                        ),
                        // SPACING
                        const SizedBox(height: 10),
                        // LAST NAME
                        _buildTextField(
                          _lastNameController,
                          _lastNameNode,
                          null,
                          null,
                          "Last name",
                          false,
                          "Last Name",
                        ),
                        // SPACING
                        const SizedBox(height: 10),
                        // LABEL
                        _buildLabel("I am"),
                        // SPACING
                        const SizedBox(height: 10),
                        // EXPERIENCE OPTION
                        _buildExperienceOptions(),
                        // SPACING
                        const SizedBox(height: 10),
                        // LABEL
                        _buildLabel("Able to work"),
                        // SPACING
                        const SizedBox(height: 10),
                        // ABLE TO WORK OPTION
                        _buildAbleToWorkOptions(),
                        // SPACING
                        const SizedBox(height: 10),
                        // NEXT BUTTON
                        _buildNextButton(),
                        // SPACING
                        const SizedBox(height: 10),
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

  // WIDGET FOR TITLE TEXT
  Widget _buildTitleText(String textLabel) {
    return Text(
      textLabel,
      style: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w900,
        color: Color(0xFF202124),
      ),
    );
  }

  // WIDGET FOR DESCRIPTION
  Widget _buildDescriptionText() {
    return RichText(
      text: const TextSpan(
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.normal,
          color: Color(0xFF202124),
        ),
        children: <TextSpan>[
          TextSpan(text: "This information will only be shown "),
          TextSpan(text: "to Employees when you apply for a job."),
        ],
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    FocusNode currentNode,
    FocusNode? nextNode,
    TextInputFormatter? inputFormatters,
    String validatorText,
    bool isPassword,
    String hinText,
  ) {
    return CustomTextField(
      controller: controller,
      currentFocusNode: currentNode,
      nextFocusNode: nextNode,
      inputFormatters: null,
      validatorText: "$validatorText is required",
      validator: (value) {
        if (value!.isEmpty) {
          return "$validatorText is required";
        }
        return null;
      },
      isPassword: isPassword,
      hintText: hinText,
      minLines: 1,
      maxLines: 1,
    );
  }

  // WIDGET FOR LABEL
  Widget _buildLabel(String textLabel) {
    return CustomLabel(
      textLabel: textLabel,
      fontSize: 17,
      fontWeight: FontWeight.w700,
      fontColor: const Color(0xFF242424),
    );
  }

  // EXPERIENCE OPTIONS
  Widget _buildExperienceOptions() {
    return SizedBox(
      child: Row(
        children: <Widget>[
          _buildOptionButton(1, "With experience", selectedExperience,
              _updateSelectedExperience),
          const SizedBox(width: 10),
          _buildOptionButton(2, "New applicant", selectedExperience,
              _updateSelectedExperience),
        ],
      ),
    );
  }

  // WIDGET FOR ABLE TO WORK OPTION
  Widget _buildAbleToWorkOptions() {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // ROW 1:
          Row(
            children: <Widget>[
              _buildOptionButton(
                  1, "Anytime", selectedWorkButton, _updateSelectedWorkButton),
              const SizedBox(width: 10),
              _buildOptionButton(
                  2, "1 week", selectedWorkButton, _updateSelectedWorkButton),
            ],
          ),
          const SizedBox(height: 10),
          // ROW 2:
          Row(
            children: <Widget>[
              _buildOptionButton(
                  3, "2 weeks", selectedWorkButton, _updateSelectedWorkButton),
              const SizedBox(width: 10),
              _buildOptionButton(
                  4, "3 weeks", selectedWorkButton, _updateSelectedWorkButton),
            ],
          ),
          const SizedBox(height: 10),
          // ROW 3:
          Row(
            children: <Widget>[
              _buildOptionButton(
                  5, "1 month", selectedWorkButton, _updateSelectedWorkButton),
              const SizedBox(width: 10),
              _buildOptionButton(6, "2 months about", selectedWorkButton,
                  _updateSelectedWorkButton),
            ],
          ),
        ],
      ),
    );
  }

  // WIDGET FOR WORK OPTION
  Widget _buildOptionButton(
    int index,
    String text,
    int selected,
    void Function(int) onUpdate,
  ) {
    return Expanded(
      child: PrimaryCustomButton(
        buttonText: text,
        onPressed: () => onUpdate(index),
        buttonHeight: 55,
        buttonColor: selected == index
            ? const Color(0xFF3499da)
            : const Color(0xFF6c7687),
        fontWeight: FontWeight.w500,
        fontSize: 15,
        fontColor: Colors.white,
        elevation: 0,
        borderRadius: 8,
      ),
    );
  }

  // WIDGET FOR NEXT BUTTON
  Widget _buildNextButton() {
    return PrimaryCustomButton(
      buttonText: "Next",
      onPressed: () {
        // VALIDATE ALL
        if (formKey.currentState!.validate()) {
          if (selectedExperience != 0 || selectedWorkButton != 0) {
            AccountSetup accountSetup = AccountSetup(
              firstName: _firstNameController.text.trim(),
              lastName: _lastNameController.text.trim(),
              experienceChoice: selectedExperienceText,
              workAvailabilityChoice: selectedWorkButtonText,
            );
            navigateWithSlideFromRight(
              context,
              JobPreferences(accountSetup: accountSetup),
              1.0,
              0.0,
            );
          } else {
            customFloatingSnackBar(
              context,
              "Please fill all required fields.",
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
      borderRadius: 8,
    );
  }
}
