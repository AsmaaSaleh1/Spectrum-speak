import 'package:flutter/material.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/units/build_drop_down_menu.dart';
import 'package:spectrum_speak/units/build_text_field.dart';
import 'package:spectrum_speak/units/custom_button.dart';

class EditCenterProfile extends StatefulWidget {
  const EditCenterProfile({super.key});

  @override
  State<EditCenterProfile> createState() => _EditCenterProfileState();
}

class _EditCenterProfileState extends State<EditCenterProfile> {
  bool isObscurePassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _centerNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  String? selectedCity;
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
                    padding: const EdgeInsets.only(top: 50.0, bottom: 20),
                    child: Container(
                      width: 250,
                      height: 140,
                      decoration: BoxDecoration(
                        border: Border.all(width: 4, color: kPrimary),
                        boxShadow: [
                          BoxShadow(
                            color: kDarkBlue.withOpacity(0.5),
                            blurRadius: 8.0, // Blur radius
                            spreadRadius: 5.0, // Spread radius
                            offset: const Offset(-5, 5),
                          ),
                        ],
                        shape: BoxShape.rectangle, // Set to rectangle
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('images/center.jpg'),
                        ),
                      ),
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
                        labelText: "Center Name",
                        placeholder: "Asmaa",
                        isPasswordTextField: false,
                        controller: _centerNameController)),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: 300,
                    height: 60,
                    child: CustomTextField(
                        preIcon: null,
                        labelText: "About",
                        placeholder: "The Centre for...",
                        isPasswordTextField: false,
                        controller: _aboutController)),
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
                Container(
                  height: 60,
                  width: 300,
                  alignment: AlignmentDirectional.topStart,
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
