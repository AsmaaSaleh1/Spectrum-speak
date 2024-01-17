import 'package:flutter/material.dart';

import 'package:spectrum_speak/constant/const_color.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  final IconData? preIcon;
  final String labelText;
  final String placeholder;
  final bool isPasswordTextField;
  final TextEditingController controller;
  final bool disable;
  final int? numOfLine;
  final Function? onChange;
  final int maxCharacterCount;
  final TextInputType? keyboardType;
  final VoidCallback? onTap;
  final VoidCallback? onPressed;
  final FocusNode? focusNode;
  bool? existsBorder = true;
  CustomTextField({
    super.key,
    this.preIcon,
    required this.labelText,
    required this.placeholder,
    required this.isPasswordTextField,
    required this.controller,
    this.disable = false,
    this.numOfLine = 1,
    this.onChange,
    this.maxCharacterCount = 1000,
    this.keyboardType,
    this.onTap,
    this.onPressed,
    this.focusNode,
    this.existsBorder = true,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscurePassword = true;
  int _characterCount = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: TextField(
          focusNode: widget.focusNode,
          controller: widget.controller,
          obscureText: widget.isPasswordTextField ? isObscurePassword : false,
          maxLines: widget.numOfLine,
          keyboardType: widget.keyboardType != null
              ? widget.keyboardType
              : TextInputType.text,
          decoration: InputDecoration(
            filled: widget.disable,
            fillColor: Colors.grey.shade400,
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
                      isObscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
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
            enabledBorder: widget.existsBorder == true
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.grey.shade700,
                    ),
                  )
                : InputBorder.none,
            focusedBorder: widget.existsBorder == true
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: kDarkerColor,
                    ),
                  )
                : InputBorder.none,
          ),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: kDarkerColor,
          ),
          readOnly: widget.disable,
          onChanged: (text) {
            if (widget.onChange != null) {
              widget.onChange!(text);
            }
            setState(() {
              _characterCount = text.length;
            });

            if (_characterCount > widget.maxCharacterCount) {
              // Truncate the text to the maximum allowed characters
              widget.controller.text =
                  widget.controller.text.substring(0, widget.maxCharacterCount);
              widget.controller.selection = TextSelection.fromPosition(
                TextPosition(offset: widget.maxCharacterCount),
              );
            }
          },
        ),
      ),
    );
  }
}
