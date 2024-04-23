import 'package:flutter/material.dart';
import 'package:philjobnet/services/navigation/custom_screen_navigation.dart';
import 'package:philjobnet/widgets/header/application_header_appbar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) async {
        if (_) {
          return;
        }
        NavigationService.popUntilFirst(context);
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height),
          child: const HeaderAppBar(),
        ),
        body: const Column(
          children: <Widget>[
            Center(
              child: Text("WELCOME EMPLOYER"),
            ),
          ],
        ),
      ),
    );
  }
}
