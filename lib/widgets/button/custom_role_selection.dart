import 'package:flutter/material.dart';

class CustomRoleSelection extends StatelessWidget {
  // PARAMETERS NEEDED
  final String buttonText;
  final bool isSelected;
  final VoidCallback onPressed;

  const CustomRoleSelection({
    super.key,
    required this.buttonText,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: isSelected
              ? const Color(0xFF3499da).withOpacity(0.2)
              : Colors.white,
          foregroundColor: const Color(0xFF3499da).withOpacity(0.5),
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: isSelected ? const Color(0xFF3499da) : Colors.grey,
              width: 2.5,
            ),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          children: <Widget>[
            // LABEL
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF212024),
                ),
              ),
            ),
            // SPACER
            const Spacer(),
            // RADIO BUTTON
            Radio(
              value: true,
              groupValue: isSelected,
              onChanged: (bool? value) {
                onPressed();
              },
              activeColor: const Color(0xFF212024),
              fillColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return const Color(0xFF3499da);
                }
                return Colors.grey;
              }),
            ),
          ],
        ),
      ),
    );
  }
}
