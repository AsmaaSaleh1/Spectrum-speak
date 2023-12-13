import 'package:flutter/material.dart';
import 'package:spectrum_speak/constant/const_color.dart';
class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: Padding(
          padding: EdgeInsets.only(top: 80),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              height: 450,
              margin: const EdgeInsets.only(left: 10, top: 50),
              child: Image.asset('images/mail2.png',
                  width: 450.0, height: 450.0),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 5),
              width: 340,
              height: 50,
              child: Text(
                'Enter your Email account to get code.',
                style: TextStyle(
                    color: kDarkerColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
