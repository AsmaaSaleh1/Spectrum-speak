import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/units/custom_button.dart';
import 'package:spectrum_speak/units/custom_clipper.dart';
import 'package:spectrum_speak/units/custom_clipper_Main_square.dart';
import 'package:spectrum_speak/units/custom_clipper_main.dart';
import 'package:spectrum_speak/units/custom_clipper_main_upper.dart';
import 'package:spectrum_speak/units/custom_clipper_puzzle.dart';
import 'package:spectrum_speak/units/custom_main_button.dart';
import 'package:spectrum_speak/widgets/top_bar.dart';

import 'login.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
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
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double screenWidth = constraints.maxWidth;
          double linePadding;
          if (screenWidth >= 1200) {
            linePadding = 110;
          } else if (screenWidth >= 800) {
            linePadding = 70;
          } else {
            linePadding = 20;
          }
          return TopBar(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        child: ClipPath(
                          clipper: MyCustomClipperMainSquare(),
                          child: Container(
                            color: kYellow,
                            height: screenWidth,
                            width: screenWidth,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        height: screenWidth,
                        width: screenWidth,
                        child: ClipPath(
                          clipper: MyCustomClipperMainUpper(),
                          child: Container(
                            height: 300.0,
                            color: kGreen,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        height: screenWidth,
                        width: screenWidth,
                        child: ClipPath(
                          clipper: MyCustomClipperMain(),
                          child: Container(
                            height: 300.0,
                            color: kBlue,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: screenWidth / 2,
                        left: linePadding,
                        right: 0,
                        child: Row(
                          children: [
                            Container(
                              child: Text(
                                'Welcome Back,\n Asmaa!!',
                                style: TextStyle(
                                  color: kDarkerColor,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Container(
                                height: screenWidth / 3,
                                child: Image.asset(
                                  'images/spectrumSpeakWithoutWard.png',
                                  width: screenWidth / 3,
                                  height: screenWidth / 3,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: screenWidth / 40,
                        left: (screenWidth-(linePadding*2)-(120*3))/2 ,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                child: CustomMainButton(
                                  foregroundColor: kPrimary,
                                  backgroundColor: kBlue,
                                  onPressed: () {},
                                  buttonText: 'To-DO',
                                  icon: const Icon(
                                    FontAwesomeIcons.clipboardList,
                                    size: 35.0,
                                  ),
                                  iconColor: kPrimary,
                                ),
                              ),
                              SizedBox(width: linePadding,),
                              Container(
                                width: 120,
                                height: 120,
                                child: CustomMainButton(
                                  foregroundColor: kPrimary,
                                  backgroundColor: kBlue,
                                  onPressed: () {},
                                  buttonText: 'Spectrum\nBot',
                                  icon: const Icon(
                                    FontAwesomeIcons.brain,
                                    size: 35.0,
                                  ),
                                  iconColor: kPrimary,
                                ),
                              ),
                              SizedBox(width: linePadding,),
                              Container(
                                width: 120,
                                height: 120,
                                child: CustomMainButton(
                                  foregroundColor: kPrimary,
                                  backgroundColor: kBlue,
                                  onPressed: () {},
                                  buttonText: 'To-DO',
                                  icon: const Icon(
                                    Icons.edit,
                                    size: 35.0,
                                  ),
                                  iconColor: kPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      SizedBox(width: linePadding,),
                      Icon(
                        FontAwesomeIcons.businessTime,
                        size: 28,
                        color: kDarkerColor,
                      ),
                      SizedBox(width: linePadding,),
                      Text(
                        "Week Centers Events",
                        style: TextStyle(
                          color: kDarkerColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
}
