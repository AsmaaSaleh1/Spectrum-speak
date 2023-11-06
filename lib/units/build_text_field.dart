
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../const.dart';

Widget buildTextField(String labelText, String placeholder,
    bool isPasswordTextField, bool isObscurePassword) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: TextField(
      obscureText: isPasswordTextField ? isObscurePassword : false,
      decoration: InputDecoration(
        suffixIcon: isPasswordTextField
            ? IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.remove_red_eye,
              color: kDarkerColor,
            ))
            : null,
        contentPadding: const EdgeInsets.only(bottom: 5, left: 8,),
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
          borderSide: const BorderSide(
            color: Colors.grey,
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
