import 'package:flutter/material.dart';
import 'package:spectrum_speak/screen/shadow_teacher_profile.dart';
import 'package:spectrum_speak/const.dart';
import 'package:spectrum_speak/units/build_text_field.dart';
import 'package:spectrum_speak/units/custom_button.dart';

import 'package:spectrum_speak/units/build_drop_down_menu.dart';

class EditShadowTeacherProfile extends StatefulWidget {
  const EditShadowTeacherProfile({super.key});

  @override
  State<EditShadowTeacherProfile> createState() => _EditShadowTeacherProfileState();
}

class _EditShadowTeacherProfileState extends State<EditShadowTeacherProfile> {
  bool isObscurePassword = true;
  String? selectedGender;
  String? availability;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          children: [
            Center(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(width: 4, color: kPrimary),
                          boxShadow: [
                            BoxShadow(
                              color: kDarkBlue.withOpacity(0.5),
                              blurRadius: 8.0, // Blur radius
                              spreadRadius: 2.0, // Spread radius
                              offset: const Offset(-5, 5),
                            ),
                          ],
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('images/prof.png'),
                          )),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 3, color: kPrimary),
                        color: kDarkBlue,
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: kPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  buildTextField("Teacher Name", "Asmaa", false, isObscurePassword),
                  buildTextField("Academic Qualification", "Master of special Education", false, isObscurePassword),
                  buildTextField(
                      "Location", "Palestine ,Nablus", false, isObscurePassword),
                  buildTextField("Birth Date", "7th Oct 2002", false, isObscurePassword),//TODO: make it calender
                  buildTextField("Password", "********", true, isObscurePassword),
                  buildTextField(
                      "Emile", "asmaa@gmail.com", false, isObscurePassword),
                  buildTextField("Phone", "0592101010", false, isObscurePassword),
                  Row(
                    children: [
                      CustomDropDown(
                        items: const [
                          'Male',
                          'Female',
                        ],
                        selectedValue: selectedGender,
                        hint: 'Select Gender',
                        onChanged: (String? value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                      ),
                      const SizedBox(width: 20,),
                      CustomDropDown(
                        items: const [
                          'Available',
                          'Not Available',
                        ],
                        selectedValue: availability,
                        hint: 'availability',
                        onChanged: (String? value) {
                          setState(() {
                            availability = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      foregroundColor: kDarkerColor,
                      backgroundColor: kPrimary,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ShadowTeacherProfile()),
                        );
                      },
                      buttonText: 'Cansel',
                      icon: const Icon(
                        Icons.cancel,
                        size: 18.0,
                      ),
                      iconColor: kRed,
                    ),
                    CustomButton(
                      foregroundColor: kDarkerColor,
                      backgroundColor: kPrimary,
                      onPressed: () {
                        // Handle the edit profile action here
                      },
                      buttonText: 'Save',
                      icon: const Icon(
                        Icons.save,
                        size: 18.0,
                      ),
                      iconColor: kGreen,
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
