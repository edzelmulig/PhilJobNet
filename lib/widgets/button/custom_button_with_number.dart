import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class CustomButtonWithNumber extends StatefulWidget {
  // PARAMETERS NEEDED
  final VoidFutureCallBack onPressed;
  final int number;
  final String buttonText;
  final Color buttonColor;

  const CustomButtonWithNumber({
    super.key,
    required this.onPressed,
    required this.number,
    required this.buttonText,
    required this.buttonColor,
  });

  @override
  State<CustomButtonWithNumber> createState() => _CustomButtonWithNumberState();
}

class _CustomButtonWithNumberState extends State<CustomButtonWithNumber> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.only(left: 12, right: 12),
        backgroundColor: widget.buttonColor,
        foregroundColor: const Color(0xFF202124),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
        minimumSize: const Size(50, 65),
      ),
      onPressed: widget.onPressed,
      child: Row(
        children: <Widget>[
          // NUMBER
          _buildContainerNumber(),
          // SPACING
          const SizedBox(width: 10),
          // TEXT
          _buildButtonText(),
          // SPACER
          const Spacer(),
          // ARROW
          _buildArrowIcon(),
        ],
      ),
    );
  }

  // WIDGET FOR CONTAINER NUMBER
  Widget _buildContainerNumber() {
    return Container(
      width: 50,
      height: 43,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          widget.number.toString(),
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: widget.buttonColor,
          ),
        ),
      ),
    );
  }

  // WIDGET FOR TEXT BUTTON
  Widget _buildButtonText() {
    return Text(
      widget.buttonText,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    );
  }

  // WIDGET FOR ARROW ICON
  Widget _buildArrowIcon() {
    return const Icon(
      Icons.arrow_forward_ios_rounded,
      size: 17,
      color: Colors.white,
    );
  }
}
