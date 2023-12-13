import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/modules/parent.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/rest/rest_api_login.dart';
import 'package:spectrum_speak/rest/rest_api_signUp.dart';
import 'package:spectrum_speak/screen/add_child.dart';
import 'package:spectrum_speak/screen/sign_up_shadow_teacher.dart';
import 'package:spectrum_speak/screen/sign_up_specialist.dart';
import 'package:spectrum_speak/units/build_date_text_field.dart';
import 'package:spectrum_speak/units/build_drop_down_menu.dart';
import 'package:spectrum_speak/units/build_radio_button.dart';
import 'package:spectrum_speak/units/build_text_field.dart';
import 'package:spectrum_speak/units/validate_input_from_user.dart';
import 'login.dart';
import 'otp_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  EmailOTP myAuth = EmailOTP();
  UserCategory _selectedCategory = UserCategory.Parent;
  bool _showTextPassword = false;
  bool _showTextPasswordValid = false;
  bool _showErrorText = false;
  bool _validEmail = false;
  bool _existEmail = false;
  bool _phoneError = false;
  bool _showDateError = false;
  String? selectedCity;
  String messages() {
    if (_validEmail) {
      return "Not valid Email";
    } else if (_existEmail) {
      return "Already exist email";
    } else if (_showTextPassword) {
      return 'Passwords do not match';
    } else if (_showTextPasswordValid) {
      return 'Passwords not valid';
    } else {
      return "Error";
    }
  }

  @override
  void initState() {
    super.initState();
  }

  void resetErrorFlags() {
    setState(() {
      _showErrorText = false;
      _showTextPassword = false;
      _showTextPasswordValid = false;
      _validEmail = false;
      _existEmail = false;
      _phoneError = false;
      _showDateError = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
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
                'Sign Up',
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
                  preIcon: Icons.mail,
                  labelText: "Email Address",
                  placeholder: "Asmaa@gmail.com",
                  isPasswordTextField: false,
                  controller: _emailController),
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
                    preIcon: Icons.person,
                    labelText: "User Name",
                    placeholder: "Asmaa",
                    isPasswordTextField: false,
                    controller: _usernameController)),
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
                    controller: _phoneNumberController)),
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
              margin: const EdgeInsets.only(bottom: 15),
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
                margin: const EdgeInsets.only(bottom: 15),
                width: 280,
                height: 50,
                child: CustomTextField(
                    preIcon: Icons.lock_outline,
                    labelText: "Password",
                    placeholder: "**********",
                    isPasswordTextField: true,
                    controller: _passwordController)),
            Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 15),
                width: 280,
                height: 50,
                child: CustomTextField(
                    preIcon: Icons.lock_reset_outlined,
                    labelText: "Confirm Password",
                    placeholder: "**********",
                    isPasswordTextField: true,
                    controller: _confirmPasswordController)),
            Visibility(
              visible: _showTextPassword || _showTextPasswordValid,
              child: Container(
                margin: const EdgeInsets.only(left: 40),
                alignment: Alignment.center,
                child: Text(
                  messages(),
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Container(
              width: 280,
              height: 110,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade700),
              ),
              child: Text(
                "Password must contain the following\n"
                "  *A lowercase letter\n"
                "  *An uppercase letter\n"
                "  *A number\n"
                "  *Minimum 8 characters\n",
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 13,
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
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(left: 10, bottom: 5),
              width: 280,
              child: Text(
                "Choose Category",
                style: TextStyle(
                  color: kDarkerColor,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 10, bottom: 15),
              width: 280,
              child: RadioButtonSearch(
                selected: _selectedCategory,
                onTypeChanged: (search) {
                  setState(
                    () {
                      _selectedCategory = search;
                    },
                  );
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
            ElevatedButton(
              onPressed: () async {
                print(
                    "Selected category in RadioButtonSearch: $_selectedCategory");
                resetErrorFlags();
                if (_emailController.text.isEmpty ||
                    _usernameController.text.isEmpty ||
                    _birthDateController.text.isEmpty ||
                    _phoneNumberController.text.isEmpty ||
                    _passwordController.text.isEmpty ||
                    _confirmPasswordController.text.isEmpty ||
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

                if (await isEmailAlreadyExists(_emailController.text)) {
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

                if (!isDate(_birthDateController.text)) {
                  setState(() {
                    _showDateError = true;
                  });
                  return;
                }

                if (_passwordController.text !=
                    _confirmPasswordController.text) {
                  setState(() {
                    _showTextPassword = true;
                  });
                  return;
                }

                if (!isPasswordValid(_passwordController.text)) {
                  setState(() {
                    _showTextPasswordValid = true;
                  });
                  return;
                }

                // If all conditions are met, proceed with signup
                doSignUp(
                  _emailController.text,
                  _usernameController.text,
                  _phoneNumberController.text,
                  _passwordController.text,
                  _birthDateController.text,
                  selectedCity!,
                  _selectedCategory,
                );
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
                'Sign Up',
                style: TextStyle(
                  color: kDarkerColor,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  margin: const EdgeInsets.only(top: 20, right: 20),
                  width: 150,
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: kYellow)),
                  ),
                  child: const Text(
                    ' ',
                    style: TextStyle(
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 33),
                  child: Text(
                    'OR',
                    style: TextStyle(
                      color: kDarkerColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  margin: const EdgeInsets.only(left: 20, top: 20),
                  width: 150,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: kYellow),
                    ),
                  ),
                  child: const Text(
                    ' ',
                    style: TextStyle(
                      color: Colors.deepOrange,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Login()));
              },
              child: Text(
                'Do you have an account? Log in',
                style: TextStyle(
                  color: kDarkerColor,
                  decoration: TextDecoration.underline,
                  fontSize: 15,
                  //fontFamily: 'Poppins',
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

  doLoginForSignUp(
      String email, String password, UserCategory selectedCategory) async {
    var rest = await userLogin(email.trim(), password.trim());
    if (rest['success']) {
      String userEmail = rest['data'][0]['Email'];
      String userID = rest['data'][0]['UserID'].toString();
      await AuthManager.storeUserData(userID, userEmail);
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
              comeFromSignUp: true,
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
    } else {
      setState(() {
        _showErrorText = true;
      });
    }
  }

  doSignUp(
      String email,
      String userName,
      String phone,
      String password,
      String birthDate,
      String selectedCity,
      UserCategory selectedCategory) async {
    var rest = await userSignUp(
        email.trim(),
        userName.trim(),
        phone.trim(),
        password.trim(),
        birthDate,
        selectedCity.trim(),
        selectedCategory.toString().split('.').last.trim());
    print("Selected category in SignUp: $selectedCategory");
    if (rest['success']) {
      doLoginForSignUp(email, password, selectedCategory);
    } else {
      setState(() {
        _showErrorText = true;
      });
    }
  }
}
