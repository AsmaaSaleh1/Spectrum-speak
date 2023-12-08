import 'package:flutter/material.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/units/build_text_field.dart';
import 'package:spectrum_speak/units/custom_button.dart';
import 'package:spectrum_speak/units/build_drop_down_menu.dart';

class EditSpecialistProfile extends StatefulWidget {
  const EditSpecialistProfile({super.key});

  @override
  State<EditSpecialistProfile> createState() => _EditSpecialistProfileState();
}

class _EditSpecialistProfileState extends State<EditSpecialistProfile> {
  bool isObscurePassword = true;
  String? selectedCity;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
                        labelText: "User Name",
                        placeholder: "Asmaa",
                        isPasswordTextField: false,
                        controller: _userNameController)),
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
                        labelText: "Price in dollar",
                        placeholder: "100\$",
                        isPasswordTextField: false,
                        controller: _priceController)),
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
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 250,
                height: 50,
                child: CustomButton(
                  foregroundColor: kDarkerColor,
                  backgroundColor: kBlue,
                  onPressed: () {},
                  buttonText: "Change Password",
                  icon: Icon(Icons.key_sharp),
                  iconColor: kPrimary,
                ),
              ),
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
          ],
        ),
      ),
    );
  }
}
