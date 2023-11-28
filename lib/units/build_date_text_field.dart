import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:spectrum_speak/constant/const_color.dart';

class BuildDateTextField extends StatefulWidget {
  final String labelText;
  final String placeholder;
  final TextEditingController controller;

  const BuildDateTextField({
    required this.labelText,
    required this.placeholder,
    required this.controller,
    super.key,
  });

  @override
  State<BuildDateTextField> createState() => _BuildDateTextFieldState();
}

class _BuildDateTextFieldState extends State<BuildDateTextField> {
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
            FontAwesomeIcons.calendar,
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
        onTap: ()async{
          DateTime? pickedDate= await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2323),
          );
              if(pickedDate!= null){
                setState((){
                  controller.text= DateFormat('yyyy-MM-dd').format(pickedDate);
                });
              }
        },
      ),
    );
  }
}
