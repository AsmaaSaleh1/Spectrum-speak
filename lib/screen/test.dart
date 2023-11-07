import 'package:flutter/material.dart';
import 'package:spectrum_speak/const.dart';

import '../units/custom_clipper_puzzle.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 100,
          height: 100,
          child: Stack(
            children: [
              ClipPath(
                clipper: CustomClipperTest(),
                child: Container(
                  color: kDarkBlue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
