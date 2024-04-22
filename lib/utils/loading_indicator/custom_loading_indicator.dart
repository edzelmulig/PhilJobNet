import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

// FUNCTION THAT WILL DISPLAY LOADING INDICATOR
void showLoadingIndicator(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent users from dismissing the dialog
    builder: (context) => Center(
      child: Container(
        padding: const EdgeInsets.all(5),
        width: 80,
        height: 80,
        child: const LoadingIndicator(
          indicatorType: Indicator.lineSpinFadeLoader,
          backgroundColor: Colors.transparent,
          colors: [Color(0xFF3499da)],
        ),
      ),
    ),
  );
}