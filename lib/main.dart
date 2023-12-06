
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spectrum_speak/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:spectrum_speak/screen/add_profile_photo.dart';
import 'package:spectrum_speak/screen/parent_profile.dart';
import 'package:spectrum_speak/screen/welcome.dart';
import 'constant/const_color.dart';

late Size mq;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //_initializeFirebase();
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
  }
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

// _initializeFirebase() async {
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
// }
