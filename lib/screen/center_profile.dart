import 'package:flutter/material.dart';
import 'package:spectrum_speak/units/review_add_from_user.dart';
import 'package:spectrum_speak/widgets/card_review.dart';
import 'package:spectrum_speak/widgets/stack_container_center.dart';
import 'package:spectrum_speak/widgets/center_information.dart';

class CenterProfile extends StatefulWidget {
  const CenterProfile({Key? key}) : super(key: key);

  @override
  State<CenterProfile> createState() => _CenterProfileState();
}

class _CenterProfileState extends State<CenterProfile> {
  bool isMore = false;
  double userRating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const StackContainerCenter(),
            CenterInformation(
              about:
              "Lorem ipsum comment Lorem ipsum comment Lorem ipsum comment Lorem ipsum comment Lorem ipsum comment Lorem ipsum comment Lorem ipsum comment Lorem ipsum comment",
              onTap: () => setState(() {
                isMore = !isMore;
              }),
              isLess: isMore,
            ),
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
            const SingleChildScrollView(
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
