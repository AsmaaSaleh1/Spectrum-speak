import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/rest/rest_api.dart';
import 'package:spectrum_speak/screen/main_page.dart';
import 'package:spectrum_speak/screen/parent_profile.dart';
import 'package:spectrum_speak/units/build_date_text_field.dart';
import 'package:spectrum_speak/units/build_drop_down_menu.dart';
import 'package:spectrum_speak/units/build_text_field.dart';
import 'package:spectrum_speak/units/validate_input_from_user.dart';

class AddChild extends StatefulWidget {
  final bool comeFromSignUp;
  const AddChild({super.key, required this.comeFromSignUp});

  @override
  State<AddChild> createState() => _AddChildState();
}

class _AddChildState extends State<AddChild> {
  bool isObscurePassword = true;
  String? selectedGender;
  String? degreeOfAutism;
  bool _showErrorText = false;
  bool _showDateError = false;
  final TextEditingController _childName = TextEditingController();
  final TextEditingController _childBirthDate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 100,
              ),
              child: Container(
                alignment: Alignment.topCenter,
                height: 210,
                //margin: const EdgeInsets.only(left: 8, top: 45),
                child: Image.asset(
                  'images/spectrumspeak.png',
                  width: 270.0,
                  height: 270.0,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 15, bottom: 35),
              child: Text(
                'Welcome, Parent',
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
              child: CustomTextField(
                  preIcon: Icons.family_restroom,
                  labelText: "Child Name",
                  placeholder: "Ahmad",
                  isPasswordTextField: false,
                  controller: _childName),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 5),
              width: 280,
              height: 50,
              child: BuildDateTextField(
                labelText: 'Birth Date',
                placeholder: '7th Oct 2002',
                controller: _childBirthDate,
              ),
            ),
            Visibility(
              visible: _showDateError,
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                child: const Text(
                  'Please enter a valid date (dd-mm-yyyy)',
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
                      FontAwesomeIcons.venusMars,
                      size: 25.0,
                      color: kDarkerColor,
                    ),
                  ),
                  Container(
                    width: 140,
                    alignment: AlignmentDirectional.center,
                    child: Icon(
                      Icons.format_list_numbered,
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
                  CustomDropDown(
                    items: const [
                      'ASD Level 1',
                      'ASD Level 2',
                      'ASD Level 3',
                    ],
                    selectedValue: degreeOfAutism,
                    hint: 'ASD Level',
                    onChanged: (String? value) {
                      setState(
                        () {
                          degreeOfAutism = value;
                        },
                      );
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
                print('Retrieved user ID: $userId');
                if (userId != null) {
                  if (_childName.text.isNotEmpty &&
                      _childBirthDate.text.isNotEmpty &&
                      selectedGender.toString().isNotEmpty &&
                      degreeOfAutism.toString().isNotEmpty) {
                    if (isDate(_childBirthDate.text)) {
                      saveChild(
                        userId,
                        _childName.text,
                        _childBirthDate.text,
                        selectedGender!,
                        degreeOfAutism!,
                      );
                    } else {
                      setState(() {
                        _showDateError = true;
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

  saveChild(String userId, String name, String birthDate, String gender,
      String degreeOfAutism) async {
    var rest =
        await childrenSignUp(userId, name, birthDate, gender, degreeOfAutism);
    if (rest['success']) {
      if(widget.comeFromSignUp){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MainPage()));
      }else{
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ParentProfile()));
      }
    } else {
      setState(() {
        _showErrorText = true;
      });
    }
  }
}
