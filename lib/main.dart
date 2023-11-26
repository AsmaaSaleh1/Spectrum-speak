import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spectrum_speak/firebase_options.dart';
import 'package:spectrum_speak/screen/add_child.dart';
import 'package:spectrum_speak/screen/login.dart';
import 'package:spectrum_speak/screen/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:spectrum_speak/screen/sign_up.dart';
import 'package:spectrum_speak/screen/sign_up_shadow_teacher.dart';
import 'package:spectrum_speak/screen/sign_up_specialist.dart';
import 'package:spectrum_speak/screen/welcome.dart';
import 'const.dart';
late Size mq;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _initializeFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        body: AddChild(),
      ),
    );
  }
}

_initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}