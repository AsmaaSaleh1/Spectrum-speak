import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:spectrum_speak/const.dart';

class CustomDropDown extends StatefulWidget {
  final List<String> items;
  final String? selectedValue;
  final String? hint;
  final Function(String?) onChanged; // Added callback function

  const CustomDropDown({
    Key? key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.hint,
  }) : super(key: key);

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.grey.shade700,
            width: 1,
          ),
        ),
        child: DropdownButton<String>(
          value: widget.selectedValue,
          icon: const Icon(FontAwesomeIcons.chevronDown),
          elevation: 0,
          style: TextStyle(
            color: kDarkerColor,
            fontFamily: GoogleFonts.tinos().fontFamily,
            fontSize: 17,
          ),
          hint: widget.hint != null ? Text(widget.hint!) : null,
          onChanged: (String? value) {
              widget.onChanged(value); // Call the callback function
          },
          items: widget
              .items
              .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
          iconSize: 17,
          borderRadius: BorderRadius.circular(20.0),
          menuMaxHeight: 250,
          focusColor: kPrimary,
          padding: const EdgeInsets.all(5),//textPadding
          underline:Container(),//Hide the underline
        ),
      ),
    );
  }
}
