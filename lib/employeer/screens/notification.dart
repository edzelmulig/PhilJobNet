import 'package:flutter/material.dart';
import 'package:philjobnet/widgets/header/application_header_appbar.dart';
import 'package:philjobnet/widgets/static_widgets/custom_under_development.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

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
          child: const HeaderAppBar(withLogoutIcon: true),
        ),
        body: const UnderDevelopment(),
      ),
    );
  }
}
