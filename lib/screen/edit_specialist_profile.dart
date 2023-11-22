import 'package:flutter/material.dart';
import 'package:spectrum_speak/const.dart';
import 'package:spectrum_speak/units/build_text_field.dart';
import 'package:spectrum_speak/units/custom_button.dart';

class EditSpecialistProfile extends StatefulWidget {
  const EditSpecialistProfile({super.key});

  @override
  State<EditSpecialistProfile> createState() => _EditSpecialistProfileState();
}

class _EditSpecialistProfileState extends State<EditSpecialistProfile> {
  bool isObscurePassword = true;
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
                  buildTextField("User Name", "Asmaa", false, isObscurePassword),
                  buildTextField(
                      "Location", "Palestine ,Nablus", false, isObscurePassword),
                  buildTextField("Password", "********", true, isObscurePassword),
                  buildTextField("Price in dollar", "100\$", false, isObscurePassword),
                  buildTextField(
                      "Emile", "asmaa@gmail.com", false, isObscurePassword),
                  buildTextField("Phone", "0592101010", false, isObscurePassword),
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
