import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/rest/rest_api_signUp.dart';
import 'package:spectrum_speak/units/build_text_field.dart';
import 'package:spectrum_speak/units/custom_button.dart';
import 'package:spectrum_speak/units/validate_input_from_user.dart';

import 'otp_screen.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _emailController = TextEditingController();

  bool _validEmail = false;
  bool _existEmail = false;
  bool _emptyEmail = false;
  EmailOTP myAuth = EmailOTP();
  String messages() {
    if (_validEmail) {
      return "The provided email address is not valid.";
    } else if (_existEmail) {
      return "No account found with this email address.";
    } else if (_emptyEmail) {
      return "Please provide the email address you used to log in.";
    } else {
      return "An error occurred.";
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
              padding: EdgeInsets.only(right: 30, left: 15, top: 55),
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
              height: 450,
              margin: const EdgeInsets.only(left: 10, top: 50),
              child: Image.asset(
                'images/mailbox.png',
                width: 450.0,
                height: 450.0,
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 5),
              width: 340,
              height: 60,
              child: Text(
                'Enter the email address associated with your account to receive a verification code.',
                style: TextStyle(
                  color: kDarkerColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 5),
              width: 320,
              height: 50,
              child: CustomTextField(
                preIcon: Icons.mail,
                labelText: "Email Address",
                placeholder: "Email Address",
                isPasswordTextField: false,
                controller: _emailController,
              ),
            ),
            Visibility(
              visible: _validEmail || _existEmail || _emptyEmail,
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
              height: 15,
            ),
            Container(
              width: 200,
              height: 45,
              child: CustomButton(
                foregroundColor: kDarkerColor,
                backgroundColor: kBlue,
                buttonText: '   Send Email',
                icon: Icon(Icons.mail),
                iconColor: kPrimary,
                onPressed: () async {
                  _emptyEmail = false;
                  _validEmail = false;
                  _existEmail = false;
                  if (_emailController.text.isEmpty) {
                    setState(() {
                      _emptyEmail = true;
                    });
                    return;
                  }
                  if (!isValidEmail(_emailController.text)) {
                    setState(() {
                      _validEmail = true;
                    });
                    return;
                  }
                  if (!await isEmailAlreadyExists(_emailController.text)) {
                    setState(() {
                      _existEmail = true;
                    });
                    return;
                  }
                  myAuth.setConfig(
                    appEmail: "asmaatareq1999@gmail.com",
                    appName: "Spectrum Speak",
                    userEmail: _emailController.text,
                    otpLength: 4,
                    otpType: OTPType.digitsOnly,
                  );

                  if (await myAuth.sendOTP()) {
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
                  } else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Oops, OTP send failed'),
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
