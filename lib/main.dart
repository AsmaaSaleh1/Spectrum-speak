import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spectrum_speak/firebase_options.dart';
import 'package:spectrum_speak/screen/chat.dart';
import 'package:spectrum_speak/screen/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:spectrum_speak/screen/splash_screen_chat.dart';
import 'firebase_options.dart';
import 'const.dart';
late Size mq;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _initializeFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        body: SplashChatScreen(),
      ),
    );
  }
}

_initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}