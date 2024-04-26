import 'package:flutter/material.dart';
import 'package:philjobnet/employeer/screens/view_manage/create_job.dart';
import 'package:philjobnet/services/navigation/custom_animated_navigation.dart';
import 'package:philjobnet/services/navigation/custom_screen_navigation.dart';
import 'package:philjobnet/widgets/button/custom_button.dart';
import 'package:philjobnet/widgets/header/application_header_appbar.dart';

class ViewManageJobScreen extends StatelessWidget {
  const ViewManageJobScreen({super.key});

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
        body: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Column(
            children: <Widget>[
              // SPACING
              const SizedBox(height: 25),
              // LOGIN BUTTON
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: PrimaryCustomButton(
                    buttonText: "POST NEW JOB",
                    onPressed: () {
                      navigateWithSlideFromRight(
                        context,
                        const CreateJobScreen(
                          operation: 'Post ',
                        ),
                        0.0,
                        1.0,
                      );
                    },
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
