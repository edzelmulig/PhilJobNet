import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  // PARAMETERS NEEDED
  final List<String> items;
  final String hintText;
  final Function(String?) onChanged;
  final Function(String?) onSaved;
  final String? selectedValue;

  const CustomDropDown({
    super.key,
    required this.items,
    required this.hintText,
    required this.onChanged,
    required this.onSaved,
    required this.selectedValue,
  });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue;
  }
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      isExpanded: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xFF3499da),
            width: 1.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Color(0xFFe91b4f),
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Color(0xFFe91b4f),
            width: 2.0,
          ),
        ),
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xFFBDBDC7),
            // Set color for enabled state
            width: 1.5, // Set width for enabled state
          ),
        ),
      ),
      hint: Text(
        widget.hintText,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.normal,
          color: Color(0xFF6c7687),
        ),
      ),
      items: widget.items
          .map(
            (item) => DropdownMenuItem(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          )
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Selection is required';
        }
        return null;
      },
      value: selectedValue,
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
      iconStyleData: const IconStyleData(
        icon: Padding(
          padding: EdgeInsets.only(right: 5),
          child: Icon(
            Icons.arrow_drop_down,
            color: Color(0xFF3C3C40),
          ),
        ),
        iconSize: 26,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 15),
      ),
    );
  }
}
