import 'package:flutter/material.dart';

import 'package:spectrum_speak/const.dart';

Widget buildTextField(IconData? preIcon, String labelText, String placeholder,
    bool isPasswordTextField, bool isObscurePassword,TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 0),
    child: TextField(
      controller: controller,
      obscureText: isPasswordTextField ? isObscurePassword : false,
      decoration: InputDecoration(
        prefixIcon: preIcon != null
            ? Icon(
                preIcon,
                color: kDarkerColor,
              )
            : null,
        suffixIcon: isPasswordTextField
            ? IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.remove_red_eye,
                  color: kDarkerColor,
                ),
              )
            : null,
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
      ),
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: kDarkerColor,
      ),
    ),
  );
}
