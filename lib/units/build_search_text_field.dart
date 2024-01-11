import 'package:flutter/material.dart';

import 'package:spectrum_speak/constant/const_color.dart';

class CustomSearchTextField extends StatefulWidget {
  final String labelText;
  final String placeholder;
  final TextEditingController controller;
  final Function(String) onTextChanged;
  const CustomSearchTextField({
    super.key,
    required this.labelText,
    required this.placeholder,
    required this.controller,
    required this.onTextChanged,
  });

  @override
  State<CustomSearchTextField> createState() => _CustomSearchTextFieldState();
}

class _CustomSearchTextFieldState extends State<CustomSearchTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: TextField(
        controller: widget.controller,
        obscureText: false,
        decoration: InputDecoration(
          fillColor: Colors.grey.shade400,
          contentPadding: const EdgeInsets.only(
            bottom: 5,
            left: 8,
          ),
          labelText: widget.labelText,
          labelStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: kDarkerColor,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: widget.placeholder,
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(
              color: Colors.grey.shade700,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(
              color: kDarkerColor,
            ),
          ),
        ),
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: kDarkerColor,
        ),
        onChanged: widget.onTextChanged,
      ),
    );
  }
}
