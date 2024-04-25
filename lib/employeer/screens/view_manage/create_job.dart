import 'package:flutter/material.dart';
import 'package:philjobnet/services/navigation/custom_screen_navigation.dart';
import 'package:philjobnet/widgets/button/custom_button.dart';
import 'package:philjobnet/widgets/dropdown/custom_dropdown.dart';
import 'package:philjobnet/widgets/header/application_header_appbar.dart';
import 'package:philjobnet/widgets/static_widgets/custom_label.dart';
import 'package:philjobnet/widgets/text_field/custom_text_field.dart';

class CreateJobScreen extends StatefulWidget {
  final String operation;

  const CreateJobScreen({
    super.key,
    required this.operation,
  });

  @override
  State<CreateJobScreen> createState() => _CreateJobScreenState();
}

class _CreateJobScreenState extends State<CreateJobScreen> {
  // TEXT EDITING CONTROLLERS DECLARATIONS
  final _jobCategoryController = TextEditingController();
  final _jobPositionController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _jobLocationController = TextEditingController();
  final _typeOfJobController = TextEditingController();
  final _jobExperienceController = TextEditingController();

  // FOCUS NODE DECLARATIONS
  final _jobPositionNode = FocusNode();
  final _companyNameNode = FocusNode();
  final _jobLocationNode = FocusNode();
  final _jobExperienceNode = FocusNode();

  // VARIABLE DECLARATION
  String? selectedCategory;
  String? selectedJobType;

  // FORM KET FOR INPUT VALIDATION
  final formKey = GlobalKey<FormState>();

  // LIST FOR JOB CATEGORY
  final List<String> jobCategories = [
    'House Keeping & Maintenance',
    'Personal Care',
    'Automotive Services',
    'Equipment Operation',
    'Kitchen Works',
    'Transportation',
    'Mechanic Work',
    'Others',
  ];

  // LIST FOR JOB TYPE
  final List<String> jobType = [
    'Part Time',
    'Full Time',
    'Contract',
    'Freelance',
    'Internship',
    'Temporary',
  ];

  // DISPOSE
  @override
  void dispose() {
    super.dispose();
    _jobCategoryController.dispose();
    _typeOfJobController.dispose();
    _jobPositionController.dispose();
    _companyNameController.dispose();
    _jobLocationController.dispose();
    _jobExperienceController.dispose();
    _jobPositionNode.dispose();
    _jobLocationNode.dispose();
    _jobExperienceNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) async {
        if (_) {
          return;
        }
        NavigationService.pop(context);
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height),
          child: const HeaderAppBar(withLogoutIcon: false),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // SPACING
                  const SizedBox(height: 30),
                  // TEXT: SCREEN TITLE
                  _buildTitleText(),
                  // SPACING
                  const SizedBox(height: 5),
                  // LABEL: JOB CATEGORY
                  _buildLabel("Job Category"),
                  // SIZED BOX: SPACING
                  const SizedBox(height: 2),
                  // DROP DOWN BUTTON FOR CATEGORY
                  CustomDropDown(
                    items: jobCategories,
                    hintText: 'Select Job Category',
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                        _jobCategoryController.text = value.toString();
                      });
                    },
                    selectedValue: selectedCategory,
                  ),
                  // SPACING
                  const SizedBox(height: 10),
                  // LABEL: JOB TYPE
                  _buildLabel("Job Type"),
                  // SIZED BOX: SPACING
                  const SizedBox(height: 2),
                  // DROP DOWN BUTTON FOR TYPE
                  CustomDropDown(
                    items: jobType,
                    hintText: 'Select Job Type',
                    onChanged: (value) {
                      setState(() {
                        selectedJobType = value;
                        _typeOfJobController.text = value.toString();
                      });
                    },
                    selectedValue: selectedJobType,
                  ),
                  // SPACING
                  const SizedBox(height: 10),
                  // LABEL: JOB TYPE
                  _buildLabel("Job Position"),
                  // SIZED BOX: SPACING
                  const SizedBox(height: 2),
                  // JOB POSITION
                  CustomTextField(
                    controller: _jobPositionController,
                    currentFocusNode: _jobPositionNode,
                    nextFocusNode: _companyNameNode,
                    inputFormatters: null,
                    validatorText: "Job position is required",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Job position is required";
                      }
                      return null;
                    },
                    isPassword: false,
                    hintText: "Enter Job Position",
                    minLines: 1,
                    maxLines: 1,
                  ),
                  // SPACING
                  const SizedBox(height: 10),
                  // LABEL: JOB TYPE
                  _buildLabel("Company Name"),
                  // SIZED BOX: SPACING
                  const SizedBox(height: 2),
                  // COMPANY NAME
                  CustomTextField(
                    controller: _companyNameController,
                    currentFocusNode: _companyNameNode,
                    nextFocusNode: _jobLocationNode,
                    inputFormatters: null,
                    validatorText: "Company name is required",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Company name is required";
                      }
                      return null;
                    },
                    isPassword: false,
                    hintText: "Enter Company Name",
                    minLines: 1,
                    maxLines: 1,
                  ),
                  // SPACING
                  const SizedBox(height: 10),
                  // LABEL: JOB TYPE
                  _buildLabel("Job Location"),
                  // SIZED BOX: SPACING
                  const SizedBox(height: 2),
                  // COMPANY LOCATION
                  CustomTextField(
                    controller: _jobLocationController,
                    currentFocusNode: _jobLocationNode,
                    nextFocusNode: _jobExperienceNode,
                    inputFormatters: null,
                    validatorText: "Job location is required",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Job location is required";
                      }
                      return null;
                    },
                    isPassword: false,
                    hintText: "Enter City/Province",
                    minLines: 1,
                    maxLines: 1,
                  ),
                  // SPACING
                  const SizedBox(height: 10),
                  // LABEL: JOB TYPE
                  _buildLabel("Job Experience"),
                  // SIZED BOX: SPACING
                  const SizedBox(height: 2),
                  // JOB EXPERIENCE
                  CustomTextField(
                    controller: _jobExperienceController,
                    currentFocusNode: _jobExperienceNode,
                    nextFocusNode: null,
                    inputFormatters: null,
                    validatorText: "Job experience is required",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Job experience is required";
                      }
                      return null;
                    },
                    isPassword: false,
                    hintText: "Enter Years of Experience",
                    minLines: 1,
                    maxLines: 1,
                  ),
                  // SPACING
                  const SizedBox(height: 20),
                  // POST JOB BUTTON
                  _buildPostButton(),
                  // SPACING
                  const SizedBox(height: 10),
                ],
              ),
            ),
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

  // WIDGET FOR TITLE TEXT
  Widget _buildTitleText() {
    return const CustomLabel(
      textLabel: "Post new job",
      fontSize: 25,
      fontWeight: FontWeight.w900,
      fontColor: Color(0xFF242424),
    );
  }

  // WIDGET FOR POST BUTTON
  Widget _buildPostButton() {
    return PrimaryCustomButton(
      buttonText: "POST",
      onPressed: () {},
      buttonHeight: 55,
      buttonColor: const Color(0xFF3499da),
      fontWeight: FontWeight.w500,
      fontSize: 15,
      fontColor: Colors.white,
      elevation: 1,
      borderRadius: 10,
    );
  }
}
