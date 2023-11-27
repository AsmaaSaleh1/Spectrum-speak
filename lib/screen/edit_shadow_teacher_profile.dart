import 'package:flutter/material.dart';
import 'package:spectrum_speak/constant/const_color.dart';
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _qualificationController= TextEditingController();
  final TextEditingController _salaryController= TextEditingController();
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
                  buildTextField(null,"Teacher Name", "Asmaa", false, isObscurePassword,_userNameController),
                  const SizedBox(height: 25,),
                  buildTextField(null,"Academic Qualification", "Master of special Education", false, isObscurePassword,_qualificationController),
                  const SizedBox(height: 25,),
                  buildTextField(null,"Birth Date", "7th Oct 2002", false, isObscurePassword,_birthDateController),//TODO: make it calender
                  const SizedBox(height: 25,),
                  buildTextField(null,"Password", "********", true, isObscurePassword,_passwordController),
                  const SizedBox(height: 25,),
                  buildTextField(
                      null,"Emile", "asmaa@gmail.com", false, isObscurePassword,_emailController),
                  const SizedBox(height: 25,),
                  buildTextField(null,"Phone", "0592101010", false, isObscurePassword,_phoneNumberController),
                  const SizedBox(height: 25,),
                  buildTextField(null, "Salary", "1000\$ (in one month)", false, isObscurePassword,_salaryController),
                  const SizedBox(height: 25,),
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
                  //TODO:add location
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
                        Navigator.pop(context);
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
