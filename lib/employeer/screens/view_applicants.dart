import 'package:flutter/material.dart';
import 'package:philjobnet/widgets/header/application_header_appbar.dart';

class ViewApplicantsScreen extends StatefulWidget {
  const ViewApplicantsScreen({super.key});

  @override
  State<ViewApplicantsScreen> createState() => _ViewApplicantsScreen();
}

class _ViewApplicantsScreen extends State<ViewApplicantsScreen> {
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
          child: const HeaderAppBar(withLogoutIcon: false),
        ),
        body: const Padding(
          padding: EdgeInsets.only(left: 25, right: 25),
          child: Column(
            children: <Widget> [
              // SPACING
              SizedBox(height: 25),

            ],
          ),
        ),
      ),
    );
  }

}
