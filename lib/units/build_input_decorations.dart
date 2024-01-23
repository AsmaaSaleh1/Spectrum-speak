import 'package:flutter/material.dart';

import '../constant/const_color.dart';

InputDecoration buildInputDecoration(IconData? preIcon, String? labelText, String placeholder,
    bool isPasswordTextField, bool isObscurePassword) {
  return InputDecoration(

        contentPadding: const EdgeInsets.only(
          bottom: 5,
          left: 8,
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: kDarkerColor,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: placeholder,
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

  );
}