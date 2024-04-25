import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:philjobnet/auth/login_screen.dart';
import 'package:philjobnet/services/navigation/custom_screen_navigation.dart';
import 'package:philjobnet/widgets/header/application_header.dart';

class HeaderAppBar extends StatelessWidget {
  final bool withLogoutIcon;

  const HeaderAppBar({
    super.key,
    required this.withLogoutIcon,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF202124),
      centerTitle: true,
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // APPLICATION LOGO
          ApplicationHeader(paddingTop: 10, paddingBottom: 10),
        ],
      ),
      actions: withLogoutIcon ? [
        // LOGOUT BUTTON
        Tooltip(
          message: "Logout",
          child: Container(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              style: IconButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                // LOG OUT, NAVIGATE TO LOGIN PAGE
                FirebaseAuth.instance.signOut();
                await NavigationService.removeAllAndPush(
                  context,
                  const LoginScreen(),
                );
              },
              icon: const ImageIcon(
                AssetImage('images/logout.png'),
                color: Color(0xFFfefeff),
                size: 22,
              ),
            ),
          ),
        ),
      ]
      : [],
    );
  }
}
