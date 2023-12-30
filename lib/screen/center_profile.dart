import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/units/review_add_from_user.dart';
import 'package:spectrum_speak/widgets/card_review.dart';
import 'package:spectrum_speak/widgets/stack_container_center.dart';
import 'package:spectrum_speak/widgets/center_information.dart';
import 'package:spectrum_speak/widgets/top_bar.dart';

class CenterProfile extends StatefulWidget {
  final String CenterID;
  const CenterProfile({super.key, required this.CenterID});

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
          linePadding = 110;
        } else if (screenWidth >= 800) {
          linePadding = 70;
        } else {
          linePadding = 20;
        }
        return TopBar(
          body: Stack(
            children: [
              SingleChildScrollView(
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
                    const SizedBox(height: 80.0),
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
              Positioned(
                bottom: 20.0,
                right: 20.0,
                child: FloatingActionButton(
                  onPressed: () {
                    // Handle the message button press
                    print('Message button pressed');
                  },
                  shape: const CircleBorder(),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  backgroundColor: kDarkBlue,
                  child: const Icon(
                    FontAwesomeIcons.message,
                    color: kPrimary,
                    size: 30,
                  ), // Customize the button color
                ),
              ),
            ],
          ),
        );
      });
}
