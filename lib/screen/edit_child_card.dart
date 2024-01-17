import 'package:flutter/material.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/modules/child.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/rest/rest_api_profile.dart';
import 'package:spectrum_speak/rest/rest_api_profile_edit.dart';
import 'package:spectrum_speak/screen/parent_profile.dart';
import 'package:spectrum_speak/units/build_date_text_field.dart';
import 'package:spectrum_speak/units/build_drop_down_menu.dart';
import 'package:spectrum_speak/units/build_text_field.dart';
import 'package:spectrum_speak/units/custom_button.dart';
import 'package:spectrum_speak/units/validate_input_from_user.dart';

import 'login.dart';

class EditChildCard extends StatefulWidget {
  final String childId;
  const EditChildCard({super.key, required this.childId});

  @override
  State<EditChildCard> createState() => _EditChildCardState();
}

class _EditChildCardState extends State<EditChildCard> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  String? selectedGender;
  String? degreeOfAutism;
  bool _showDateError = false;
  bool _showErrorText = false;

  @override
  void initState() {
    super.initState();
    // Call your method to fetch user data from the database
    _getChildData().then((childData) {
      // Update text controllers with fetched data
      setState(() {
        _userNameController.text = childData!.childName;
        _birthDateController.text = childData.birthDate;
        selectedGender = childData.gender;
        degreeOfAutism = childData.degreeOfAutism;
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
                    padding: const EdgeInsets.only(top: 110.0),
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
                    labelText: "Child Name",
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
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 15),
                  width: 300,
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
                      onPressed: () async{
                        String? userId = await AuthManager.getUserId();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => ParentProfile(userID: userId!,),),);
                      },
                      buttonText: 'Cancel',
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
                        _showDateError = false;
                        _showErrorText = false;
                        if (_userNameController.text.isEmpty ||
                            _birthDateController.text.isEmpty ||
                            selectedGender == null ||
                            degreeOfAutism == null) {
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
                        doEditCard(
                          _userNameController.text,
                          _birthDateController.text,
                          selectedGender!,
                          degreeOfAutism!,
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

  Future<Child?> _getChildData() async {
    try {
      Child? child = await getChildByID(widget.childId);
      return child;
    } catch (error) {
      print('Error in _getChildData: $error');
      return null;
    }
  }

  Future doEditCard(
    String childName,
    String birthDate,
    String gender,
    String degreeOfAutism,
  ) async {
    try {
      String? userID = await AuthManager.getUserId();
      if (userID != null) {
        var rest = await editChildCard(widget.childId, childName.trim(),
            birthDate.trim(), gender.trim(), degreeOfAutism.trim());
        if (rest['success']) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => ParentProfile(
                userID: userID,
              ),
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
