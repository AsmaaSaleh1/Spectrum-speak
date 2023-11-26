import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:spectrum_speak/const.dart';
import 'package:spectrum_speak/units/build_drop_down_menu.dart';
import 'package:spectrum_speak/units/build_radio_button.dart';
import 'package:spectrum_speak/units/build_text_field.dart';
import 'login.dart';
import 'follow_up_sign_up.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  Category _selected = Category.parent;
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  bool showText = false;
  String? selectedCity;
  @override
  void initState() {
    super.initState();
    _obscureText1 = true;
    _obscureText2 = true;
  }
  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  bool confirmation() {
    if (_confirmPasswordController.text == _passwordController.text) {
      return true;
    }
    return false;
  }

  void noMatch() {
    setState(() {
      showText = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isObscurePassword = true;
    return Scaffold(
      backgroundColor: kPrimary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
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
                child: buildTextField(Icons.mail, "Email Address",
                    "Asmaa@gmail.com", false, isObscurePassword)),
            Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 15),
                width: 280,
                height: 50,
                child: buildTextField(Icons.person, "User Name", "Asmaa", false,
                    isObscurePassword)),
            Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 15),
                width: 280,
                height: 50,
                child: buildTextField(Icons.phone, "Phone Number", "0592777777",
                    false, isObscurePassword)),
            Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 15),
                width: 280,
                height: 50,
                child: buildTextField(Icons.lock_outline, "Password",
                    "**********", true, isObscurePassword)),
            Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 15),
                width: 280,
                height: 50,
                child: buildTextField(Icons.lock_reset_outlined,
                    "Confirm Password", "**********", true, isObscurePassword)),
            showText
                ? Container(
                    margin: const EdgeInsets.only(left: 40),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Passwords do not match',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                        //fontFamily: 'Poppins'
                      ),
                    ),
                  )
                : Container(child: null),
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
              margin: const EdgeInsets.only(left:10, bottom: 5),
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
              margin: const EdgeInsets.only(left:10, bottom: 15),
              width: 280,
              child: RadioButtonSearch(
                selected: _selected,
                onTypeChanged: (search) {
                  setState(
                    () {
                      _selected = search;
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (confirmation() == true) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const FollowUpSignUp()));
                } else {
                  noMatch();
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
}
