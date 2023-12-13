import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/modules/parent.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/rest/rest_api_menu.dart';
import 'package:spectrum_speak/screen/reset_password.dart';
import 'package:spectrum_speak/screen/sign_up_shadow_teacher.dart';
import 'package:spectrum_speak/screen/sign_up_specialist.dart';
import 'package:spectrum_speak/units/custom_button.dart';

import 'add_child.dart';

class Otp extends StatelessWidget {
  const Otp({
    Key? key,
    required this.otpController,
  }) : super(key: key);
  final TextEditingController otpController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextFormField(
        controller: otpController,
        keyboardType: TextInputType.number,
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
        },
        decoration: const InputDecoration(
          hintText: ('0'),
        ),
        onSaved: (value) {},
      ),
    );
  }
}

class OTPScreen extends StatefulWidget {
  const OTPScreen({
    Key? key,
    required this.myAuth,
    required this.email,
    required this.comeFromSignUp,
  }) : super(key: key);
  final EmailOTP myAuth;
  final String email;
  final bool comeFromSignUp;
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otp1Controller = TextEditingController();
  TextEditingController otp2Controller = TextEditingController();
  TextEditingController otp3Controller = TextEditingController();
  TextEditingController otp4Controller = TextEditingController();

  String otpController = "1234";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            widget.comeFromSignUp
                ? Padding(
                    padding: EdgeInsets.only(right: 30, left: 30, top: 70),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              surfaceTintColor: kDarkerColor,
                              title: Text("Confirmation"),
                              content: Text(
                                  "Are you sure you want to skip? Skipping email verification may lead to issues in the future, and you won't be able to verify your email later."),
                              icon: Icon(
                                Icons.warning_amber,
                                size: 45,
                                color: kYellow,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    String? userId =
                                        await AuthManager.getUserId();
                                    String category =
                                        await getUserCategory(userId!);
                                    switch (category) {
                                      case "Parent":
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => const AddChild(
                                              comeFromSignUp: true,
                                            ),
                                          ),
                                        );
                                        break;
                                      case "Specialist":
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                const SignUpSpecialist(),
                                          ),
                                        );
                                        break;
                                      case "ShadowTeacher":
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                const SignUpShadowTeacher(),
                                          ),
                                        );
                                        break;
                                      default:
                                        print("error in category");
                                        break;
                                    }
                                  },
                                  child: Text("Yes"),
                                ),
                              ],
                            );
                          },
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
                            "Skip",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: kDarkerColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Padding(
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
              height: 300,
              margin: const EdgeInsets.only(left: 10, top: 70),
              child: Image.asset(
                'images/mail1.png',
                width: 300.0,
                height: 300.0,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Enter Mary's PIN",
              style: TextStyle(
                color: kDarkerColor,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Otp(
                  otpController: otp1Controller,
                ),
                Otp(
                  otpController: otp2Controller,
                ),
                Otp(
                  otpController: otp3Controller,
                ),
                Otp(
                  otpController: otp4Controller,
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: 200,
              height: 45,
              child: CustomButton(
                foregroundColor: kDarkerColor,
                backgroundColor: kBlue,
                buttonText: '   Confirm',
                icon: Icon(Icons.done_all),
                iconColor: kPrimary,
                onPressed: () async {
                  if (await widget.myAuth.verifyOTP(
                          otp: otp1Controller.text +
                              otp2Controller.text +
                              otp3Controller.text +
                              otp4Controller.text) ==
                      true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "OTP is verified",
                          style: TextStyle(
                            color: kPrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                    if (widget.comeFromSignUp) {
                      String? userId = await AuthManager.getUserId();
                      String category = await getUserCategory(userId!);
                      switch (category) {
                        case "Parent":
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const AddChild(
                                        comeFromSignUp: true,
                                      )));
                          break;
                        case "Specialist":
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SignUpSpecialist(),
                            ),
                          );
                          break;
                        case "ShadowTeacher":
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SignUpShadowTeacher(),
                            ),
                          );
                          break;
                        default:
                          print("error in category");
                          break;
                      }
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResetPassword(
                            email: widget.email,
                          ),
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Invalid OTP",
                          style: TextStyle(
                            color: kPrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
