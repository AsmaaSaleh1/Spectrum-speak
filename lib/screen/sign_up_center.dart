import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/rest/rest_api_center.dart';
import 'package:spectrum_speak/screen/specialist_profile.dart';
import 'package:spectrum_speak/units/build_drop_down_menu.dart';
import 'package:spectrum_speak/units/build_text_field.dart';
import 'package:spectrum_speak/units/validate_input_from_user.dart';

import 'add_profile_photo.dart';
import 'center_profile.dart';

class SignUpCenter extends StatefulWidget {
  final String SpecialistID;
  final String userId;
  const SignUpCenter({
    super.key,
    required this.SpecialistID,
    required this.userId,
  });

  @override
  State<SignUpCenter> createState() => _SignUpCenterState();
}

class _SignUpCenterState extends State<SignUpCenter> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  String? selectedCity;

  bool _showErrorText = false;
  bool _validEmail = false;
  bool _existEmail = false;
  bool _phoneError = false;

  int _characterCount = 0;
  int _maxCharacterCount = 200;

  String messages() {
    if (_validEmail) {
      return "Not valid Email";
    } else if (_existEmail) {
      return "Already exist email";
    } else {
      return "Error";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(right: 30, left: 30, top: 50, bottom: 30),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SpecialistProfile(
                        userId: widget.userId,
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.keyboard_double_arrow_left,
                      color: kDarkerColor,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Back to profile",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kDarkerColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              height: 210,
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
              child: CustomTextField(
                preIcon: FontAwesomeIcons.sackDollar,
                labelText: "Center Name",
                placeholder: "Asmaa Center",
                isPasswordTextField: false,
                controller: _nameController,
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 15),
              width: 280,
              height: 50,
              child: CustomTextField(
                preIcon: Icons.mail,
                labelText: "Email Address",
                placeholder: "AsmaaCenter@gmail.com",
                isPasswordTextField: false,
                controller: _emailController,
              ),
            ),
            Visibility(
              visible: _validEmail || _existEmail,
              child: Container(
                child: Text(
                  messages(),
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 15),
              width: 280,
              height: 50,
              child: CustomTextField(
                preIcon: Icons.phone,
                labelText: "Phone Number",
                placeholder: "0592777777",
                isPasswordTextField: false,
                controller: _phoneNumberController,
              ),
            ),
            Visibility(
              visible: _phoneError,
              child: Container(
                child: const Text(
                  'Not a number',
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
              height: 200,
              child: CustomTextField(
                labelText: "About",
                placeholder: "Lorem ipsum comment Lorem ipsum comment",
                isPasswordTextField: false,
                controller: _aboutController,
                numOfLine: 8,
                maxCharacterCount: _maxCharacterCount,
                onChange: (text) {
                  setState(() {
                    _characterCount = text.length;
                  });

                  if (_characterCount > _maxCharacterCount) {
                    // Truncate the text to the maximum allowed characters
                    _aboutController.text =
                        _aboutController.text.substring(0, _maxCharacterCount);
                    _aboutController.selection = TextSelection.fromPosition(
                      TextPosition(offset: _maxCharacterCount),
                    );
                  }
                },
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.only(right: 5),
              width: 280,
              height: 18,
              child: Text(
                '$_characterCount/$_maxCharacterCount',
                style: TextStyle(
                  color: _characterCount > _maxCharacterCount
                      ? kRed
                      : kDarkerColor.withOpacity(0.8),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 15),
              width: 280,
              height: 50,
              child: Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 0),
                    child: Icon(
                      FontAwesomeIcons.locationDot,
                      size: 22.0,
                      color: kDarkerColor,
                    ),
                  ),
                  CustomDropDown(
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
                _showErrorText = false;
                _validEmail = false;
                _existEmail = false;
                _phoneError = false;
                if (userId != null) {
                  if (_nameController.text.isEmpty ||
                      _emailController.text.isEmpty ||
                      _phoneNumberController.text.isEmpty ||
                      _aboutController.text.isEmpty ||
                      selectedCity == null) {
                    setState(() {
                      _showErrorText = true;
                    });
                    return;
                  }

                  if (!isValidEmail(_emailController.text)) {
                    setState(() {
                      _validEmail = true;
                    });
                    return;
                  }

                  if (await isEmailAlreadyExistsCenter(_emailController.text)) {
                    setState(() {
                      _existEmail = true;
                    });
                    return;
                  }

                  if (!isValidPhoneNumber(_phoneNumberController.text)) {
                    setState(() {
                      _phoneError = true;
                    });
                    return;
                  }
                  doSignUp(
                      _nameController.text,
                      _emailController.text,
                      _phoneNumberController.text,
                      _aboutController.text,
                      selectedCity!);
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
              height: 100,
            ),
          ],
        ),
      ),
    );
  }

  doSignUp(
    String centerName,
    String email,
    String phone,
    String description,
    String selectedCity,
  ) async {
    var rest = await centerSignUp(
      widget.SpecialistID,
      centerName.trim(),
      email.trim(),
      phone.trim(),
      description.trim(),
      selectedCity.trim(),
    );
    if (rest['success'] == true) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddProfilePhoto(
                comeFromSignUp: true,
              )));
    } else {
      setState(() {
        _showErrorText = true;
      });
    }
  }
}
