import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/modules/parent.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/rest/rest_api_profile.dart';
import 'package:spectrum_speak/rest/rest_api_profile_edit.dart';
import 'package:spectrum_speak/screen/main_page.dart';
import 'package:spectrum_speak/screen/parent_profile.dart';
import 'package:spectrum_speak/units/build_date_text_field.dart';
import 'package:spectrum_speak/units/build_text_field.dart';
import 'package:spectrum_speak/units/custom_button.dart';
import 'package:spectrum_speak/units/build_drop_down_menu.dart';
import 'package:spectrum_speak/units/validate_input_from_user.dart';

import 'add_profile_photo.dart';
import 'login.dart';
import 'otp_screen.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  EmailOTP myAuth = EmailOTP();

  String? selectedCity;
  bool _phoneError = false;
  bool _showDateError = false;
  bool _showErrorText = false;

  @override
  void initState() {
    super.initState();
    // Call your method to fetch user data from the database
    _getParentData().then((parentData) {
      // Update text controllers with fetched data
      setState(() {
        _userNameController.text = parentData!.userName;
        _birthDateController.text = parentData.birthDate;
        _emailController.text = parentData.email;
        _phoneNumberController.text = parentData.phone;
        selectedCity = parentData.city;
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
                      ),
                      child: ClipOval(
                          //child: ProfileImageDisplay(),
                          ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AddProfilePhoto(comeFromSignUp: false),
                          ),
                        );
                      },
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
                    controller: _userNameController,
                  ),
                ),
                const SizedBox(
                  height: 25,
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
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: 300,
                  height: 60,
                  child: CustomTextField(
                    preIcon: null,
                    labelText: "Email",
                    placeholder: "asmaa@gmail.com",
                    isPasswordTextField: false,
                    controller: _emailController,
                    disable: true,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: 300,
                  height: 60,
                  child: CustomTextField(
                    preIcon: null,
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
                  height: 20,
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
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 250,
                height: 50,
                child: CustomButton(
                  foregroundColor: kDarkerColor,
                  backgroundColor: kBlue,
                  buttonText: "Change Password",
                  icon: Icon(Icons.key_sharp),
                  iconColor: kPrimary,
                  onPressed: () async {
                    myAuth.setConfig(
                      appEmail: "asmaatareq1999@gmail.com",
                      appName: "Spectrum Speak",
                      userEmail: _emailController.text,
                      otpLength: 4,
                      otpType: OTPType.digitsOnly,
                    );
                    if (await myAuth.sendOTP() == true) {
                      print("done send");
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('OTP has been sent'),
                        ),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OTPScreen(
                            myAuth: myAuth,
                            email: _emailController.text,
                            comeFromSignUp: false,
                          ),
                        ),
                      );
                    } else {
                      print("error");
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Oops, OTP send failed'),
                        ),
                      );
                    }
                  },
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
                        _phoneError = false;
                        _showDateError = false;
                        _showErrorText = false;
                        if (_userNameController.text.isEmpty ||
                            _birthDateController.text.isEmpty ||
                            _phoneNumberController.text.isEmpty ||
                            selectedCity == null) {
                          setState(() {
                            _showErrorText = true;
                          });
                          return;
                        }

                        if (!isDate(_birthDateController.text)) {
                          setState(() {
                            _showDateError = true;
                          });
                          return;
                        }

                        if (!isValidPhoneNumber(_phoneNumberController.text)) {
                          setState(() {
                            _phoneError = true;
                          });
                          return;
                        }

                        doEditProfile(
                          _userNameController.text,
                          _phoneNumberController.text,
                          _birthDateController.text,
                          selectedCity!,
                        );
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

  Future<Parent?> _getParentData() async {
    try {
      String? userId = await AuthManager.getUserId();
      if (userId != null) {
        Parent? parent = await profileParent(userId);
        return parent;
      } else {
        print('UserId is null');
        return null;
      }
    } catch (error) {
      print('Error in _getParentData: $error');
      return null;
    }
  }

  Future doEditProfile(String userName, String phone, String birthDate,
      String selectedCity) async {
    try {
      String? userID = await AuthManager.getUserId();
      if (userID != null) {
        var rest = await editProfileParent(
          userID,
          userName.trim(),
          phone.trim(),
          birthDate,
          selectedCity.trim(),
        );
        if (rest['success']) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => MainPage(),
            ),
          );
        } else {
          setState(() {
            _showErrorText = true;
          });
        }
      } else {
        print('UserId is null');
        return null;
      }
    } catch (error) {
      print('Error in doEditProfile: $error');
      return null;
    }
  }
}
