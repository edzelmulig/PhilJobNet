import 'package:flutter/material.dart';
import 'package:philjobnet/services/navigation/custom_screen_navigation.dart';
import 'package:philjobnet/widgets/header/application_header_appbar.dart';
import 'package:philjobnet/widgets/static_widgets/custom_under_development.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

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
        body: const UnderDevelopment(),
      ),
    );
  }
}
