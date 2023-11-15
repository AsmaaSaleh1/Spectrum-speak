import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spectrum_speak/screen/center_profile.dart';
import 'package:spectrum_speak/screen/main_page.dart';
import 'package:spectrum_speak/screen/search_page.dart';
import 'package:spectrum_speak/screen/edit_profile.dart';
import 'package:spectrum_speak/screen/parent_profile.dart';
import 'package:spectrum_speak/widgets/card_specialist.dart';
import 'package:spectrum_speak/units/custom_clipper_puzzle.dart';
import 'package:spectrum_speak/widgets/top_bar.dart';

import 'const.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Profile',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: kDarkBlue,
            iconTheme: IconThemeData(color: kDarkerColor),
          ),
          scaffoldBackgroundColor: kPrimary,
          primaryColor: kPrimary,
          iconTheme: IconThemeData(color: kDarkerColor),
          fontFamily: GoogleFonts.tinos().fontFamily,
          textTheme: GoogleFonts.tinosTextTheme(),
        ),
        home: const Scaffold(
          body:MainPage(),
        )
    );
  }
}