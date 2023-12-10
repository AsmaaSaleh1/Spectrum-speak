import 'package:flutter/material.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/modules/shadow_teacher.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/rest/rest_api_profile.dart';
import 'package:spectrum_speak/screen/shadow_teacher_profile.dart';
import 'package:spectrum_speak/units/build_date_text_field.dart';
import 'package:spectrum_speak/units/build_text_field.dart';
import 'package:spectrum_speak/units/custom_button.dart';

import 'package:spectrum_speak/units/build_drop_down_menu.dart';
import 'package:spectrum_speak/units/validate_input_from_user.dart';

class EditShadowTeacherProfile extends StatefulWidget {
  const EditShadowTeacherProfile({super.key});

  @override
  State<EditShadowTeacherProfile> createState() =>
      _EditShadowTeacherProfileState();
}

class _EditShadowTeacherProfileState extends State<EditShadowTeacherProfile> {
  String? selectedGender;
  String? availability;
  String? selectedCity;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _qualificationController =
      TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  bool _phoneError = false;
  bool _showDateError = false;
  bool _showErrorText = false;
  bool _showSalaryError = false;

  @override
  void initState() {
    super.initState();
    // Call your method to fetch user data from the database
    _getShadowTeacherData().then((teacherData) {
      // Update text controllers with fetched data
      setState(() {
        _userNameController.text = teacherData!.userName;
        _birthDateController.text = teacherData.birthDate;
        _emailController.text = teacherData.email;
        _phoneNumberController.text = teacherData.phone;
        selectedCity = teacherData.city;
        _qualificationController.text = teacherData.qualification;
        _salaryController.text = teacherData.salary.toString();
        availability = teacherData.availability;
        selectedGender = teacherData.gender;
      });
    });
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
                    labelText: "Teacher Name",
                    placeholder: "Asmaa",
                    isPasswordTextField: false,
                    controller: _userNameController,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 300,
                  height: 60,
                  child: CustomTextField(
                    preIcon: null,
                    labelText: "Academic Qualification",
                    placeholder: "Master of special Education",
                    isPasswordTextField: false,
                    controller: _qualificationController,
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                    controller: _emailController,
                    disable: true,
                  ),
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
                      controller: _phoneNumberController),
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
                SizedBox(
                  width: 300,
                  height: 60,
                  child: CustomTextField(
                    preIcon: null,
                    labelText: "Salary",
                    placeholder: "1000\$ (in one month)",
                    isPasswordTextField: false,
                    controller: _salaryController,
                  ),
                ),
                Visibility(
                  visible: _showSalaryError,
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: const Text(
                      'Please enter a valid price (maximum 99999.99)',
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
                SizedBox(
                  width: 300,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      const SizedBox(
                        width: 20,
                      ),
                      CustomDropDown(
                        items: const [
                          'Available',
                          'Not Available',
                        ],
                        selectedValue: availability,
                        hint: 'availability',
                        onChanged: (String? value) {
                          setState(() {
                            availability = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 300,
                  height: 60,
                  alignment: AlignmentDirectional.center,
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
            Center(
              child: Visibility(
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
            ),
            const SizedBox(
              height: 5,
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
                        _phoneError = false;
                        _showDateError = false;
                        _showErrorText = false;
                        _showSalaryError = false;
                        if (_userNameController.text.isEmpty ||
                            _birthDateController.text.isEmpty ||
                            _phoneNumberController.text.isEmpty ||
                            _qualificationController.text.isEmpty ||
                            _salaryController.text.isEmpty ||
                            availability == null ||
                            selectedGender == null ||
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

                        if (!isDecimal(_salaryController.text)) {
                          setState(() {
                            _showSalaryError = true;
                          });
                          return;
                        }

                        doEditProfile(
                          _userNameController.text,
                          _phoneNumberController.text,
                          _birthDateController.text,
                          selectedCity!,
                          _qualificationController.text,
                          double.parse(_salaryController.text),
                          selectedGender!,
                          availability!
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

  Future<ShadowTeacher?> _getShadowTeacherData() async {
    try {
      String? userId = await AuthManager.getUserId();
      if (userId != null) {
        ShadowTeacher? shadowTeacher = await profileShadowTeacher(userId);
        return shadowTeacher;
      } else {
        print('UserId is null');
        return null;
      }
    } catch (error) {
      print('Error in _getParentData: $error');
      return null;
    }
  }

  Future doEditProfile(
      String userName,
      String phone,
      String birthDate,
      String selectedCity,
      String AcademicQualification,
      double salary,
      String gender,
      String availability) async {
    try {
      String? userID = await AuthManager.getUserId();
      if (userID != null) {
        var rest = await editProfileShadowTeacher(
          userID,
          userName.trim(),
          phone.trim(),
          birthDate,
          selectedCity.trim(),
          AcademicQualification.trim(),
          salary,
          gender.trim(),
          availability.trim()
        );
        if (rest['success']) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => ShadowTeacherProfile()));
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
