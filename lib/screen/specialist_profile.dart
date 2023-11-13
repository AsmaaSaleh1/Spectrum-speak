import 'package:flutter/material.dart';
import 'package:spectrum_speak/widgets/card_review.dart';

import 'package:spectrum_speak/widgets/stack_container_specialist.dart';

import 'package:spectrum_speak/widgets/specialist_information.dart';

class SpecialistProfile extends StatefulWidget {
  const SpecialistProfile({Key? key}) : super(key: key);

  @override
  State<SpecialistProfile> createState() => _SpecialistProfileState();
}

class _SpecialistProfileState extends State<SpecialistProfile> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StackContainerSpecialist(),
            SpecialistInformation(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  CardReview(),
                  CardReview(),
                  // Add more CardItems as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
