import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:spectrum_speak/constant/const_color.dart';

class BuildTimeTextField extends StatefulWidget {
  final String labelText;
  final String placeholder;
  final TextEditingController controller;

  const BuildTimeTextField({
    required this.labelText,
    required this.placeholder,
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  State<BuildTimeTextField> createState() => _BuildTimeTextFieldState();
}

class _BuildTimeTextFieldState extends State<BuildTimeTextField> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: TextField(
        controller: controller,
        obscureText: false,
        decoration: InputDecoration(
          prefixIcon: Icon(
            FontAwesomeIcons.clock,
            color: kDarkerColor,
          ),
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
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        onTap: () async {
          TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
          if (pickedTime != null) {
            setState(() {
              controller.text = DateFormat.Hm().format(
                DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  pickedTime.hour,
                  pickedTime.minute,
                ),
              );
            });
          }
        },
      ),
    );
  }
}
