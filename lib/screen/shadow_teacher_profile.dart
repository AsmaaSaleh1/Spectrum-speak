import 'package:flutter/material.dart';

import 'package:spectrum_speak/widgets/stack_container_shadow_teacher.dart';

import 'package:spectrum_speak/widgets/shadow_teacher_information.dart';
import 'package:spectrum_speak/widgets/top_bar.dart';

class ShadowTeacherProfile extends StatefulWidget {
  const ShadowTeacherProfile({Key? key}) : super(key: key);

  @override
  State<ShadowTeacherProfile> createState() => _ShadowTeacherProfileState();
}
//TODO: add the availability
class _ShadowTeacherProfileState extends State<ShadowTeacherProfile> {
  @override
  Widget build(BuildContext context) {
    return const TopBar(
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
