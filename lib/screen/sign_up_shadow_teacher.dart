import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/rest/rest_api.dart';
import 'package:spectrum_speak/units/build_date_text_field.dart';
import 'package:spectrum_speak/units/build_drop_down_menu.dart';
import 'package:spectrum_speak/units/build_text_field.dart';
import 'package:spectrum_speak/units/validate_input_from_user.dart';

import 'main_page.dart';

class SignUpShadowTeacher extends StatefulWidget {
  const SignUpShadowTeacher({super.key});

  @override
  State<SignUpShadowTeacher> createState() => _SignUpShadowTeacherState();
}

class _SignUpShadowTeacherState extends State<SignUpShadowTeacher> {
  bool isObscurePassword = true;
  String? selectedGender;
  String? availability;
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _qualificationController =
      TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  bool _showErrorText = false;
  bool _showSalaryError = false;
  bool _showDateError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 20,
              ),
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
                'Welcome, Teacher',
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
              child: buildTextField(
                  FontAwesomeIcons.graduationCap,
                  "Academic Qualification",
                  "Master of special Education",
                  false,
                  isObscurePassword,
                  _qualificationController),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 15),
              width: 280,
              height: 50,
              child: buildTextField(
                  FontAwesomeIcons.sackDollar,
                  "Salary",
                  "1000\$ (in one month)",
                  false,
                  isObscurePassword,
                  _salaryController),
            ),
            Visibility(
              visible: _showSalaryError,
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                child: const Text(
                  'Please enter a valid salary (maximum 99999.99)',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 5),
              width: 280,
              height: 50,
              child: BuildDateTextField(
                labelText: 'Birth Date',
                placeholder: '7th Oct 2002',
                controller: _birthDateController,
              ),
            ),
            Visibility(
              visible: _showDateError,
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                child: const Text(
                  'Please enter a valid date (yyyy-mm-dd)',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 280,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 140,
                    alignment: AlignmentDirectional.center,
                    child: Icon(
                      Icons.question_mark,
                      size: 25.0,
                      color: kDarkerColor,
                    ),
                  ),
                  Container(
                    width: 140,
                    alignment: AlignmentDirectional.center,
                    child: Icon(
                      FontAwesomeIcons.venusMars,
                      size: 25.0,
                      color: kDarkerColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 15),
              width: 280,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomDropDown(
                    items: const [
                      'Available',
                      'Not Available',
                    ],
                    selectedValue: availability,
                    hint: 'availability',
                    onChanged: (String? value) {
                      setState(
                        () {
                          availability = value;
                        },
                      );
                    },
                  ),
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
                ],
              ),
            ),
            Visibility(
              visible: _showErrorText,
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                child: const Text(
                  'All fields are required',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                String? userId = await AuthManager.getUserId();
                _showDateError = false;
                _showSalaryError = false;
                _showErrorText = false;
                if (userId != null) {
                  if (_salaryController.text.isNotEmpty &&
                      _birthDateController.text.isNotEmpty &&
                      availability.toString().isNotEmpty &&
                      _qualificationController.text.isNotEmpty &&
                      selectedGender.toString().isNotEmpty) {
                    if (isDecimal(_salaryController.text)) {
                      if (isDate(_birthDateController.text)) {
                        saveShadowTeacher(
                          userId,
                          _salaryController.text,
                          _birthDateController.text,
                          availability!,
                          _qualificationController.text,
                          selectedGender!,
                        );
                      } else {
                        setState(() {
                          _showDateError = true;
                        });
                      }
                    } else {
                      setState(() {
                        _showSalaryError = true;
                      });
                    }
                  } else {
                    setState(() {
                      _showErrorText = true;
                    });
                  }
                } else {
                  // Handle the case where user ID is not available
                  print('User ID not available');
                }
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
    );
  }

  saveShadowTeacher(String userId, String salary, String birthDate,
      String availability, String qualification, String gender) async {
    var rest = await shadowTeacherSignUp(
      userId,
      salary,
      birthDate,
      availability,
      qualification,
      gender,
    );
    if (rest['success']) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const MainPage()));
    } else {
      setState(() {
        _showErrorText = true;
      });
    }
  }
}
