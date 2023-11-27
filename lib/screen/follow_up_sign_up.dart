import 'package:flutter/material.dart';

import 'package:spectrum_speak/constant/const_color.dart';
class FollowUpSignUp extends StatefulWidget {
  const FollowUpSignUp({super.key});

  @override
  State<FollowUpSignUp> createState() => _FollowUpSignUpState();
}

class _FollowUpSignUpState extends State<FollowUpSignUp> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: kPrimary,
        body: SingleChildScrollView(
          child: Text('Hi'),
        )
    );
  }
}