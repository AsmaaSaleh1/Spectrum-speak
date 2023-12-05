import 'package:flutter/material.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/units/build_date_text_field.dart';
import 'package:spectrum_speak/units/build_text_field.dart';
import 'package:spectrum_speak/units/custom_button.dart';

import 'package:spectrum_speak/units/build_drop_down_menu.dart';

class EditShadowTeacherProfile extends StatefulWidget {
  const EditShadowTeacherProfile({super.key});

  @override
  State<EditShadowTeacherProfile> createState() =>
      _EditShadowTeacherProfileState();
}

class _EditShadowTeacherProfileState extends State<EditShadowTeacherProfile> {
  bool isObscurePassword = true;
  String? selectedGender;
  String? availability;
  String? selectedCity;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _qualificationController =
      TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
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
            Column(
              children: [
                SizedBox(
                    width: 300,
                    height: 60,
                    child: CustomTextField(
                        preIcon: null,
                        labelText: "Teacher Name",
                        placeholder: "Asmaa",
                        isPasswordTextField:false,
                        controller: _userNameController)),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: 300,
                    height: 60,
                    child: CustomTextField(
                        preIcon: null,
                        labelText: "Academic Qualification",
                        placeholder: "Master of special Education",
                        isPasswordTextField: false,
                        controller: _qualificationController)),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 300,
                  height: 60,
                  child: BuildDateTextField(
                    labelText: 'Birth Date',
                    placeholder: '7th Oct 2002',
                    controller: _birthDateController,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: 300,
                    height: 60,
                    child: CustomTextField(
                        preIcon: null,
                        labelText: "Password",
                        placeholder: "********",
                        isPasswordTextField: true,
                        controller: _passwordController)),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 300,
                  height: 60,
                  child: CustomTextField(
                      preIcon: null,
                      labelText: "Email",
                      placeholder: "asmaa@gmail.com",
                      isPasswordTextField: false,
                      controller: _emailController),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: 300,
                    height: 60,
                    child: CustomTextField(
                        preIcon: null,
                        labelText: "Phone",
                        placeholder: "0592101010",
                        isPasswordTextField: false,
                        controller: _phoneNumberController)),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: 300,
                    height: 60,
                    child: CustomTextField(
                        preIcon: null,
                        labelText: "Salary",
                        placeholder: "1000\$ (in one month)",
                        isPasswordTextField: false,
                        controller: _salaryController)),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 300,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      const SizedBox(
                        width: 20,
                      ),
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
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 300,
                  height: 60,
                  alignment: AlignmentDirectional.center,
                  child: CustomDropDown(
                    items: const [
                      'Nablus',
                      'Ramallah',
                      'Jerusalem',
                      'Bethlehem',
                      'Qalqilya',
                      'Hebron',
                      'Jenin',
                      'Tulkarm',
                      'Other',
                    ],
                    selectedValue: selectedCity,
                    hint: 'Select City',
                    onChanged: (String? value) {
                      setState(() {
                        selectedCity = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20),
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
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
