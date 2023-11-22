import 'package:flutter/material.dart';
import 'package:spectrum_speak/widgets/top_bar.dart';
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TopBar(
      body: Text("MAIN"),
    );
  }
}
