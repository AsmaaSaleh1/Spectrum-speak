import 'package:flutter/material.dart';

import 'package:spectrum_speak/widgets/stack_container_shadow_teacher.dart';

import 'package:spectrum_speak/widgets/shadow_teacher_information.dart';

class ShadowTeacherProfile extends StatefulWidget {
  const ShadowTeacherProfile({Key? key}) : super(key: key);

  @override
  State<ShadowTeacherProfile> createState() => _ShadowTeacherProfileState();
}

class _ShadowTeacherProfileState extends State<ShadowTeacherProfile> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StackContainerShadowTeacher(),
            ShadowTeacherInformation(),
          ],
        ),
      ),
    );
  }
}