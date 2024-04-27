import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:philjobnet/employeer/screens/view_manage/view_manage_job.dart';
import 'package:philjobnet/models/job_posting_model.dart';
import 'package:philjobnet/services/auth/firebase_firestore_services.dart';
import 'package:philjobnet/utils/bottom_modal/custom_confirmation_modal.dart';
import 'package:philjobnet/utils/floating_snackbar/custom_floating_snackbar.dart';
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
  final _minimumSalaryController = TextEditingController();
  final _maximumSalaryController = TextEditingController();
  final _salaryTypeController = TextEditingController();

  // FOCUS NODE DECLARATIONS
  final _jobPositionNode = FocusNode();
  final _companyNameNode = FocusNode();
  final _jobLocationNode = FocusNode();
  final _jobExperienceNode = FocusNode();
  final _minimumSalaryNode = FocusNode();
  final _maximumSalaryNode = FocusNode();
  final _salaryTypeNode = FocusNode();

  // VARIABLE DECLARATION
  String? selectedCategory;
  String? selectedJobType;
  String? selectedSalaryType;

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

  // LIST FOR SALARY TYPE
  final List<String> salaryType = [
    'Per Hour',
    'Daily',
    'Weekly',
    'Monthly',
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
    _minimumSalaryController.dispose();
    _maximumSalaryController.dispose();
    _minimumSalaryNode.dispose();
    _maximumSalaryNode.dispose();
    _salaryTypeController.dispose();
    _salaryTypeNode.dispose();
  }

  // FUNCTION THAT WILL HANDLE THE JOB POSTING
  void jostNewJob(JobPosting newJobPosting) async {
    await FireStoreServices.createJob(
      context: context,
      formKey: formKey,
      jobPosting: newJobPosting,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) async {
        if (_) {
          return;
        }
        showConfirmationModal(
          context,
          'You are about to discard this post.',
          "Discard",
          const ViewManageJobScreen(),
          false,
        );
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
                  const SizedBox(height: 20),
                  // TEXT: SCREEN TITLE
                  _buildTitleText(),
                  // SPACING
                  const SizedBox(height: 7),
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
                    nextFocusNode: _minimumSalaryNode,
                    inputFormatters: null,
                    validatorText: "Job experience is required",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Job experience is required";
                      }
                      return null;
                    },
                    isPassword: false,
                    hintText: "e.g 1-2 Years",
                    minLines: 1,
                    maxLines: 1,
                  ),
                  // SPACING
                  const SizedBox(height: 10),

                  // PRICE AND DISCOUNT
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // LABEL: MINIMUM SALARY
                            _buildLabel("Minimum Salary"),

                            // SIZED BOX: SPACING
                            const SizedBox(height: 2),

                            // TEXT FIELD: MINIMUM SALARY
                            CustomTextField(
                              controller: _minimumSalaryController,
                              currentFocusNode: _minimumSalaryNode,
                              nextFocusNode: _maximumSalaryNode,
                              validatorText: "Input required",
                              keyBoardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Input required";
                                }
                                return null;
                              },
                              hintText: "000",
                              minLines: 1,
                              maxLines: 1,
                              isPassword: false,
                            ),
                          ],
                        ),
                      ),

                      // SIZED BOX: SPACING
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        alignment: Alignment.center,
                        width: 10,
                        height: 20,
                        child: const Text(
                          "-",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // LABEL: MAXIMUM SALARY
                            _buildLabel("Maximum Salary"),

                            // SIZED BOX: SPACING
                            const SizedBox(height: 2),

                            // TEXT FIELD: MAXIMUM SALARY
                            CustomTextField(
                              controller: _maximumSalaryController,
                              currentFocusNode: _maximumSalaryNode,
                              nextFocusNode: _salaryTypeNode,
                              validatorText: "Input required",
                              keyBoardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Input required";
                                }
                                return null;
                              },
                              hintText: "0,000",
                              minLines: 1,
                              maxLines: 1,
                              isPassword: false,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // SPACING
                  const SizedBox(height: 10),
                  // LABEL: SALARY TYPE
                  _buildLabel("Salary Type"),

                  // SIZED BOX: SPACING
                  const SizedBox(height: 2),

                  // TEXT FIELD: SALARY TYPE
                  CustomDropDown(
                    items: salaryType,
                    hintText: 'Select Salary Type',
                    onChanged: (value) {
                      setState(() {
                        selectedSalaryType = value;
                        _salaryTypeController.text = value.toString();
                      });
                    },
                    selectedValue: selectedSalaryType,
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
      onPressed: () {
        // VALIDATE INPUT IN THE CLIENTS SIDE
        if (formKey.currentState!.validate()) {
          // COPY THE INPUT INTO MODEL
          JobPosting newJobPosting = JobPosting(
            jobCategory: _jobCategoryController.text.trim(),
            jobType: _typeOfJobController.text.trim(),
            jobPosition: _jobPositionController.text.trim(),
            companyName: _companyNameController.text.trim(),
            jobLocation: _jobLocationController.text.trim(),
            jobExperience: _jobExperienceController.text.trim(),
            minimumSalary: int.tryParse(_minimumSalaryController.text.trim()),
            maximumSalary: int.tryParse(_maximumSalaryController.text.trim()),
            salaryType: _salaryTypeController.text.trim(),
          );
          // CALL A FUNCTION THAT WILL HANDLE ON PASSING THE DATA TO BACKEND
          jostNewJob(newJobPosting);
        } else {
          // ERROR HANDLING SNACKBAR
          customFloatingSnackBar(
            context,
            "Please complete all required fields correctly.",
            const Color(0xFFe91b4f),
          );
        }
      },
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
