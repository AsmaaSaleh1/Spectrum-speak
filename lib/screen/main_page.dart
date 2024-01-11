import 'package:flutter/material.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
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
  Widget build(BuildContext context) {
    return TopBar(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("MAIN"),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
