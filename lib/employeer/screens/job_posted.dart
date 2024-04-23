import 'package:flutter/material.dart';
import 'package:philjobnet/widgets/button/custom_button.dart';
import 'package:philjobnet/widgets/header/application_header_appbar.dart';

class JobPostedScreen extends StatefulWidget {
  const JobPostedScreen({super.key});

  @override
  State<JobPostedScreen> createState() => _JobPostedScreenState();
}

class _JobPostedScreenState extends State<JobPostedScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) async {
        if (_) {
          return;
        }
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height),
          child: const HeaderAppBar(),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Column(
            children: <Widget> [
              // SPACING
              const SizedBox(height: 25),
              // LOGIN BUTTON
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: PrimaryCustomButton(
                    buttonText: "POST NEW JOB",
                    onPressed: () {},
                    buttonHeight: 55,
                    buttonColor: const Color(0xFF3499da),
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    fontColor: Colors.white,
                    elevation: 1,
                    borderRadius: 10,
                  ),
                ),
              ),
              // SPACING
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

}
