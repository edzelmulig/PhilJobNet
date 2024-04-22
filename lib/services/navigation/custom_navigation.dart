import 'package:flutter/material.dart';

class NavigationService {
  // PUSH ANOTHER SCREEN
  static Future push(BuildContext context, Widget screen) async {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  // PUSH REPLACEMENT
  static Future pushReplacement(BuildContext context, Widget screen) async {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  // POP SCREEN
  static Future pop(BuildContext context) async {
    Navigator.pop(context);
  }

  // REMOVE ALL AND PUSH NEW SCREEN
  static Future<dynamic> removeAllAndPush(
      BuildContext context, Widget screen) async {
    return Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
      (_) => false, // Clear all previous routes
    );
  }
}
