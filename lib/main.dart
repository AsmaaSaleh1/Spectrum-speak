import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spectrum_speak/firebase_options.dart';
import 'package:spectrum_speak/screen/add_child.dart';
import 'package:spectrum_speak/screen/edit_center_profile.dart';
import 'package:spectrum_speak/screen/edit_profile.dart';
import 'package:spectrum_speak/screen/edit_shadow_teacher_profile.dart';
import 'package:spectrum_speak/screen/login.dart';
import 'package:spectrum_speak/screen/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:spectrum_speak/screen/sign_up.dart';
import 'package:spectrum_speak/screen/sign_up_shadow_teacher.dart';
import 'package:spectrum_speak/screen/sign_up_specialist.dart';
import 'package:spectrum_speak/screen/welcome.dart';
import 'constant/const_color.dart';

late Size mq;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _initializeFirebase();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SharedPreferences _sharedPreferences;
  @override
  void initState() {
    super.initState();
    //isLogin();
  }
  // void isLogin() async {
  //   _sharedPreferences = await SharedPreferences.getInstance();
  //   Timer(const Duration(minutes: 10), () {
  //     if (_sharedPreferences.getString('userID') == null &&
  //         _sharedPreferences.getString('userEmail') == null) {
  //       Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (_) => const Login()));
  //     } else {
  //       Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (_) => const MainPage()));
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spectrum Speak',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: kDarkBlue,
          iconTheme: const IconThemeData(color: kPrimary),
          titleTextStyle: TextStyle(
            color: kPrimary,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.tinos().fontFamily,
          ),
        ),
        scaffoldBackgroundColor: kPrimary,
        primaryColor: kPrimary,
        iconTheme: IconThemeData(color: kDarkerColor),
        fontFamily: GoogleFonts.tinos().fontFamily,
        textTheme: GoogleFonts.tinosTextTheme(),
      ),
      home: const Scaffold(
        body: Welcome(),
      ),
    );
  }
}

_initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
