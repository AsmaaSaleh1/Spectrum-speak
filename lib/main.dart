import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spectrum_speak/screen/edit_profile.dart';
import 'package:spectrum_speak/screen/profile.dart';
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
          appBarTheme: const AppBarTheme(
            backgroundColor: kDarkBlue,
            iconTheme: IconThemeData(color: kBlue),
          ),
          scaffoldBackgroundColor: kPrimary,
          primaryColor: kPrimary,
          iconTheme: const IconThemeData(color: kBlue),
          fontFamily: GoogleFonts.tinos().fontFamily,
          textTheme: GoogleFonts.tinosTextTheme(),
        ),
        home: const Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: TopBar(),
          ),
          body: Profile(),
          //EditProfile(),
        ));
  }
}
