import 'package:flutter/material.dart';
import 'package:spectrum_speak/widgets/card_review.dart';

import 'package:spectrum_speak/widgets/stack_container_specialist.dart';

import 'package:spectrum_speak/widgets/specialist_information.dart';

import 'package:spectrum_speak/units/review_add_from_user.dart';

class SpecialistProfile extends StatefulWidget {
  const SpecialistProfile({Key? key}) : super(key: key);

  @override
  State<SpecialistProfile> createState() => _SpecialistProfileState();
}

class _SpecialistProfileState extends State<SpecialistProfile> {
  double userRating = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StackContainerSpecialist(),
            SpecialistInformation(),
            AddReview(
              image: 'images/prof.png',
              name: 'User Name',
              //comment: 'xx',
              userRating: userRating,
              onRating: (double newRating) {
                print(newRating);
                setState(() {
                  userRating = newRating;
                });
              },
            ),
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
