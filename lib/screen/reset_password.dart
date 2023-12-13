import 'package:flutter/material.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/rest/rest_api_profile_edit.dart';
import 'package:spectrum_speak/units/build_text_field.dart';
import 'package:spectrum_speak/units/custom_button.dart';
import 'package:spectrum_speak/units/validate_input_from_user.dart';

import 'login.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({
    super.key,
    required this.email,
  });
  final String email;
  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _showTextPassword = false;
  bool _showTextPasswordValid = false;
  bool _showErrorText = false;
  String messages() {
    if (_showErrorText) {
      return 'All fields are required.';
    } else if (_showTextPassword) {
      return 'Passwords do not match.';
    } else if (_showTextPasswordValid) {
      return 'Passwords are not valid.';
    } else {
      return 'An error occurred.';
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
              padding: EdgeInsets.only(right: 30, left: 30, top: 70),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
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
                      "Go Back",
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
              height: 350,
              margin: const EdgeInsets.only(left: 10, top: 20, bottom: 20),
              child: Image.asset(
                'images/security.png',
                width: 450.0,
                height: 450.0,
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
                controller: _passwordController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
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
                controller: _confirmPasswordController,
              ),
            ),
            Visibility(
              visible:
                  _showTextPassword || _showTextPasswordValid || _showErrorText,
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
            const SizedBox(
              height: 15,
            ),
            Container(
              width: 200,
              height: 45,
              child: CustomButton(
                foregroundColor: kDarkerColor,
                backgroundColor: kBlue,
                buttonText: '   Done Change',
                icon: Icon(Icons.health_and_safety),
                iconColor: kPrimary,
                onPressed: () async {
                  _showTextPassword = false;
                  _showTextPasswordValid = false;
                  _showErrorText = false;
                  if (_passwordController.text.isEmpty ||
                      _confirmPasswordController.text.isEmpty) {
                    setState(() {
                      _showErrorText = true;
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
                  doReset(_passwordController.text);
                },
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
                "Note: After that you must login",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future doReset(String password) async {
    var rest = await resetPassword(widget.email, password);
    if (rest['success']) {
      AuthManager.clearUserData();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const Login()));
    } else {
      print("doResetError");
    }
  }
}
