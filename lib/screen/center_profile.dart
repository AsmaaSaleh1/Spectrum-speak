import 'package:flutter/material.dart';
import 'package:spectrum_speak/const.dart';
import 'package:spectrum_speak/units/review_add_from_user.dart';
import 'package:spectrum_speak/widgets/card_review.dart';
import 'package:spectrum_speak/widgets/stack_container_center.dart';
import 'package:spectrum_speak/widgets/center_information.dart';
import 'package:spectrum_speak/widgets/top_bar.dart';

class CenterProfile extends StatefulWidget {
  const CenterProfile({Key? key}) : super(key: key);

  @override
  State<CenterProfile> createState() => _CenterProfileState();
}

class _CenterProfileState extends State<CenterProfile> {
  bool isMore = false;
  double userRating = 0.0;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        double screenWidth = constraints.maxWidth;
        double linePadding;
        if (screenWidth >= 1200) {
          linePadding =110;
        } else if (screenWidth >= 800) {
          linePadding =70;
        } else {
          linePadding =20;
        }
        return TopBar(
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
                Divider(
                  color: kDarkerColor, // You can customize the color
                  thickness: 2.0, // You can customize the thickness
                  indent: linePadding,
                  endIndent: linePadding,
                ),
                AddReview(
                  image: 'images/prof.png',
                  name: 'User Name',
                  //comment: 'xx',
                  userRating: userRating,
                  onRating: (double newRating) {
                    setState(() {
                      userRating = newRating;
                    });
                  },
                ),
                Divider(
                  color: kDarkerColor, // You can customize the color
                  thickness: 2.0, // You can customize the thickness
                  indent: linePadding,
                  endIndent: linePadding,
                ),
                Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: Text(
                    "Review",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: kDarkerColor,
                    ),
                  ),
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
      });
}
