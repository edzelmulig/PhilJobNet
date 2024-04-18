import 'package:flutter/material.dart';
import 'package:philjobnet/widgets/application_header.dart';

class AccountType extends StatefulWidget {
  const AccountType({super.key});

  @override
  State<AccountType> createState() => _AccountTypeState();
}

class _AccountTypeState extends State<AccountType> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            // 1. HEADER
            ApplicationHeader(),
          ],
        ),
      ),
    );
  }
}

