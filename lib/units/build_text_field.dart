import 'package:flutter/material.dart';

import 'package:spectrum_speak/constant/const_color.dart';
class CustomTextField extends StatefulWidget {
  final IconData? preIcon;
  final String labelText;
  final String placeholder;
  final bool isPasswordTextField;
  final TextEditingController controller;
  const CustomTextField(
      {super.key,
      this.preIcon,
      required this.labelText,
      required this.placeholder,
      required this.isPasswordTextField,
      required this.controller});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.isPasswordTextField ? isObscurePassword : false,
        decoration: InputDecoration(
          prefixIcon: widget.preIcon != null
              ? Icon(
                  widget.preIcon,
                  color: kDarkerColor,
                )
              : null,
          suffixIcon: widget.isPasswordTextField
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObscurePassword = !isObscurePassword;
                    });
                  },
                  icon: Icon(
                    isObscurePassword ? Icons.visibility : Icons.visibility_off,
                    color: kDarkerColor,
                  ),
                )
              : null,
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
      ),
    );
  }
}
