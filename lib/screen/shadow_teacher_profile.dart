import 'package:flutter/material.dart';
import 'package:spectrum_speak/const.dart';

import 'package:spectrum_speak/widgets/stack_container_shadow_teacher.dart';

import 'package:spectrum_speak/widgets/shadow_teacher_information.dart';
import 'package:spectrum_speak/widgets/top_bar.dart';

class ShadowTeacherProfile extends StatefulWidget {
  const ShadowTeacherProfile({super.key});

  @override
  State<ShadowTeacherProfile> createState() => _ShadowTeacherProfileState();
}

class _ShadowTeacherProfileState extends State<ShadowTeacherProfile> {
  @override
  Widget build(BuildContext context) {
    return TopBar(
      body: Stack(
        children: [
          const SingleChildScrollView(
            child: Column(
              children: <Widget>[
                StackContainerShadowTeacher(
                  isTeacherAvailable: true,
                ),
                ShadowTeacherInformation(),
                SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80, // Adjust the height as needed
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    kPrimary.withOpacity(0.8),
                    kPrimary.withOpacity(0.5),
                    kPrimary.withOpacity(0.1),
                    kPrimary.withOpacity(0.0)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
