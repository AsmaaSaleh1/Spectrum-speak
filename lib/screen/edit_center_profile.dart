import 'package:flutter/material.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/modules/center.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/rest/rest_api_center.dart';
import 'package:spectrum_speak/screen/center_profile.dart';
import 'package:spectrum_speak/units/build_drop_down_menu.dart';
import 'package:spectrum_speak/units/build_text_field.dart';
import 'package:spectrum_speak/units/custom_button.dart';
import 'package:spectrum_speak/units/validate_input_from_user.dart';

import 'login.dart';

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
  int _characterCount = 0;
  int _maxCharacterCount = 200;

  bool _showErrorText = false;
  bool _validEmail = false;
  bool _phoneError = false;

  String messages() {
    if (_validEmail) {
      return "Not valid Email";
    } else {
      return "Error";
    }
  }
  @override
  void initState() {
    super.initState();
    // Call your method to fetch user data from the database
    _getCenter().then((center) {
      // Update text controllers with fetched data
      setState(() {
        _centerNameController.text = center!.centerName;
        _aboutController.text = center.description;
        _emailController.text = center.email;
        _phoneNumberController.text = center.phone;
        selectedCity = center.city;
      });
    });
    checkLoginStatus();
  }

  // Method to check if the user is logged in
  Future<void> checkLoginStatus() async {
    bool isLoggedIn = await AuthManager.isUserLoggedIn();

    if (!isLoggedIn) {
      // If the user is not logged in, navigate to the login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
  }
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
                    labelText: "Center Name",
                    placeholder: "Asmaa",
                    isPasswordTextField: false,
                    controller: _centerNameController,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 300,
                  height: 60,
                  child: CustomTextField(
                    labelText: "Email",
                    placeholder: "asmaa@gmail.com",
                    isPasswordTextField: false,
                    controller: _emailController,
                  ),
                ),
                Visibility(
                  visible: _validEmail,
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
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 300,
                  height: 60,
                  child: CustomTextField(
                    labelText: "Phone",
                    placeholder: "0592101010",
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
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  width: 300,
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
                        _aboutController.text = _aboutController.text
                            .substring(0, _maxCharacterCount);
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
                  width: 300,
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
                const SizedBox(
                  height: 5,
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
                    hint: '  Select City         ',
                    onChanged: (String? value) {
                      setState(() {
                        selectedCity = value;
                      });
                    },
                  ),
                ),
                Visibility(
                  visible: _showErrorText,
                  child: Container(
                    child: const Text(
                      'All fields are required',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
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
                      onPressed: () async {
                        String? userId = await AuthManager.getUserId();
                        _showErrorText = false;
                        _validEmail = false;
                        _phoneError = false;
                        if (userId != null) {
                          if (_centerNameController.text.isEmpty ||
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

                          if (!isValidPhoneNumber(
                              _phoneNumberController.text)) {
                            setState(() {
                              _phoneError = true;
                            });
                            return;
                          }
                          doEdit(
                              userId,
                              _centerNameController.text,
                              _emailController.text,
                              _phoneNumberController.text,
                              _aboutController.text,
                              selectedCity!);
                        } else {
                          // Handle the case where user ID is not available
                          print('User ID not available');
                        }
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
  Future<CenterAutism?> _getCenter() async {
    try {
      String? userId = await AuthManager.getUserId();
      print('UserId: $userId');

      // Check if userId is not null before calling profileShadowTeacher
      if (userId != null) {
        var result = await profileCenter(userId);
        return result;
      } else {
        print('UserId is null');
        return null;
      }
    } catch (error) {
      // Handle errors here
      print('Error in _getCenter: $error');
      return null;
    }
  }
  Future doEdit(String userId,
      String centerName,
      String email,
      String phone,
      String description,
      String city,)async {
    try {
        var rest = await editProfileCenter(
          userId,
          centerName.trim(),
            email.trim(),
          phone.trim(),
          description.trim(),
          city.trim(),
        );
        if (rest['success']) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => CenterProfile(userId: userId,)));
        } else {
          setState(() {
            _showErrorText = true;
          });
        }
    } catch (error) {
      print('Error in doEditProfile: $error');
      return null;
    }
  }
}
