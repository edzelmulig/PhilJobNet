import 'package:flutter/material.dart';
import 'package:philjobnet/services/auth/firebase_auth_services.dart';
import 'package:philjobnet/services/navigation/custom_screen_navigation.dart';

// LOGOUT CONFIRMATION MODAL
void showConfirmationModal(
  BuildContext context,
  String textReminder,
  String textAction,
  Widget destinationScreen,
  bool isLogout,
  VoidCallback onConfirmed,
) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(0),
      ),
    ),
    context: context,
    isDismissible: true,
    backgroundColor: Colors.white,
    elevation: 0,
    builder: (context) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Column(
            children: <Widget>[
              // REMINDER
              Container(
                margin: const EdgeInsets.only(top: 15, bottom: 5),
                child: Center(
                  child: Text(
                    textReminder,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF3C3C40),
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Color(0xFFF7F5F5),
              ),

              // ACTION
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    if (isLogout) {
                      AuthService.logout(context: context);
                    } else {
                      onConfirmed();
                      // POP MODAL
                      NavigationService.pop(context);

                      // POP CURRENT SCREEN
                      NavigationService.pop(context);

                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFe91b4f),
                    foregroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    elevation: 0,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(
                    textAction,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              // CANCEL
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    NavigationService.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFFE7E7E9),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                        side: const BorderSide(
                          color: Color(0xFF3C3C40),
                        )),
                    elevation: 0,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF3C3C40),
                    ),
                  ),
                ),
              ),
              // SPACING
              const SizedBox(height: 15),
            ],
          ),
        ),
      );
    },
  );
}
