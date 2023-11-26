import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/const.dart';
import 'package:spectrum_speak/units/build_drop_down_menu.dart';
import 'package:spectrum_speak/units/build_text_field.dart';

import 'follow_up_sign_up.dart';

class SignUpSpecialist extends StatefulWidget {
  const SignUpSpecialist({super.key});

  @override
  State<SignUpSpecialist> createState() => _SignUpSpecialistState();
}

class _SignUpSpecialistState extends State<SignUpSpecialist> {
  String? selectedSpecialist;
  bool isObscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20,),
                alignment: Alignment.topCenter,
                height: 210,
                //margin: const EdgeInsets.only(left: 8, top: 45),
                child: Image.asset(
                  'images/spectrumspeak.png',
                  width: 270.0,
                  height: 270.0,
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 15, bottom: 35),
                child: Text(
                  'Welcome, Specialist',
                  style: TextStyle(
                    color: kDarkerColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 15),
                width: 280,
                height: 50,
                child: buildTextField(FontAwesomeIcons.sackDollar, "Price", "100\$ (in one session)", false, isObscurePassword),),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 15),
                width: 280,
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Padding(
                      padding: const EdgeInsets.only(
                          top: 20,
                          right: 10,
                          bottom: 0),
                      child: Icon(
                        FontAwesomeIcons.userDoctor,
                        size: 25.0,
                        color: kDarkerColor,
                      ),
                    ),
                    CustomDropDown(
                      items: const [
                        'Audio & Speech',
                        'Rehabilitation',
                        'Psychiatrists'
                      ],
                      selectedValue: selectedSpecialist,
                      hint: 'Select Category',
                      onChanged: (String? value) {
                        setState(() {
                          selectedSpecialist = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const FollowUpSignUp()));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kYellow),
                  fixedSize: MaterialStateProperty.all(const Size(315, 50)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ), // specify width, height
                ),
                child: Text(
                  'Done',
                  style: TextStyle(
                    color: kDarkerColor,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
