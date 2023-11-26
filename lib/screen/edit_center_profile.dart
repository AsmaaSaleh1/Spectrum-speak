import 'package:flutter/material.dart';
import 'package:spectrum_speak/const.dart';
import 'package:spectrum_speak/units/build_text_field.dart';
import 'package:spectrum_speak/units/custom_button.dart';

class EditCenterProfile extends StatefulWidget {
  const EditCenterProfile({super.key});

  @override
  State<EditCenterProfile> createState() => _EditCenterProfileState();
}

class _EditCenterProfileState extends State<EditCenterProfile> {
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
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  buildTextField(null,"Center Name", "Asmaa", false, isObscurePassword),
                  const SizedBox(height: 25,),
                  buildTextField(null,"About", "The Rehabilitation Centre for...", false, isObscurePassword),
                  const SizedBox(height: 25,),
                  buildTextField(
                      null,"Location", "Palestine ,Nablus", false, isObscurePassword),
                  const SizedBox(height: 25,),
                  buildTextField(
                      null,"Emile", "asmaa@gmail.com", false, isObscurePassword),
                  const SizedBox(height: 25,),
                  buildTextField(null,"Phone", "0592101010", false, isObscurePassword),
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
