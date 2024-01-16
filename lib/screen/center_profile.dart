import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/rest/rest_api_menu.dart';
import 'package:spectrum_speak/rest/rest_api_profile.dart';
import 'package:spectrum_speak/rest/rest_api_rate.dart';
import 'package:spectrum_speak/units/review_add_from_user.dart';
import 'package:spectrum_speak/widgets/card_review.dart';
import 'package:spectrum_speak/widgets/stack_container_center.dart';
import 'package:spectrum_speak/widgets/center_information.dart';

import 'login.dart';

class CenterProfile extends StatefulWidget {
  final String userId;
  const CenterProfile({
    super.key,
    required this.userId,
  });

  @override
  State<CenterProfile> createState() => _CenterProfileState();
}

class _CenterProfileState extends State<CenterProfile> {
  double userRating = 0.0;
  String name = "";
  List<dynamic> reviews = [];
  String centerID = "";
  String userIdLogin = "";

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    getCenterID();
    getName();
    getID();
    loadReviews();
  }

  Future<void> getCenterID() async {
    try {
      String? result = await _getSpecialist(widget.userId);
      print(widget.userId);
      if (result != null) {
        setState(() {
          centerID = result;
          print(centerID);
        });
      }
    } catch (error) {
      // Handle errors here
      print('Error in getSpecialistID: $error');
    }
  }

  Future<void> loadReviews() async {
    var reviewsData = await getReviews(widget.userId);
    setState(() {
      reviews = reviewsData;
    });
  }

  // Method to check if the user is logged in
  Future<void> checkLoginStatus() async {
    bool isLoggedIn = await AuthManager.isUserLoggedIn();

    if (!isLoggedIn) {
      // If the user is not logged in, navigate to the login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
  }

  Future getName() async {
    try {
      String? loginID = await AuthManager.getUserId();
      var data = await getUserName(loginID!);
      if (data != null) {
        setState(() {
          name = data;
        });
      }
      print(name);
    } catch (e) {
      print("error$e");
    }
  }

  Future getID() async {
    try {
      String? userId = await AuthManager.getUserId();
      if (userId != null) {
        setState(() {
          userIdLogin = userId;
        });
      }
    } catch (e) {
      print("error in user ID");
    }
    return null;
  }

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
          return FutureBuilder<bool?>(
              future: checkCenterRate(userIdLogin, centerID),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // You can return a loading indicator here if needed
                  return Container(
                    color: kPrimary,
                    child: Container(
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        backgroundColor: kDarkBlue,
                        color: kDarkBlue,
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  // Handle the error
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  // Build your UI with the fetched data
                  bool checkCenter = snapshot.data!;
                  return Scaffold(
                    appBar: AppBar(
                      title: Text('Center Profile'),
                    ),
                    body: Stack(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              StackContainerCenter(
                                userId: widget.userId,
                              ),
                              CenterInformation(
                                userId: widget.userId,
                              ),
                              Visibility(
                                visible: !checkCenter,
                                child: Divider(
                                  color:
                                      kDarkerColor, // You can customize the color
                                  thickness:
                                      2.0, // You can customize the thickness
                                  indent: linePadding,
                                  endIndent: linePadding,
                                ),
                              ),
                              Visibility(
                                visible: !checkCenter,
                                child: AddReview(
                                  image: 'images/prof.png',
                                  name: name,
                                  userRating: userRating,
                                  onRating: (double newRating) {
                                    setState(() {
                                      userRating = newRating;
                                    });
                                  },
                                  specialistID: "",
                                  centerID: centerID,
                                  isCenter: true,
                                  ID: widget.userId.toString(),
                                ),
                              ),
                              Divider(
                                color:
                                    kDarkerColor, // You can customize the color
                                thickness:
                                    2.0, // You can customize the thickness
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
                              if (reviews.isNotEmpty)
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: reviews.map((review) {
                                      return CardReview(
                                        ID: widget.userId.toString(),
                                        userId: review["UserID"].toString(),
                                        rateId: review["RateID"].toString(),
                                        userName: review["UserName"] ??
                                            "", // Replace "UserName" with the actual key in your review data
                                        date: review["Date"] ?? "",
                                        comment: review["Comment"] ?? "",
                                        rate: review["Rate"].toString(),
                                        isCenter: true,
                                        userIdLogin: userIdLogin,
                                      );
                                    }).toList(),
                                  ),
                                ),
                              if (reviews.isEmpty)
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    "No Reviews Found",
                                    style: TextStyle(
                                      color: kDarkerColor.withOpacity(0.7),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                                  kDarkerColor.withOpacity(0.5),
                                  kDarkerColor.withOpacity(0.3),
                                  kDarkerColor.withOpacity(0.1),
                                  kDarkerColor.withOpacity(0.0),
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
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
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
                } else {
                  // Return a default UI if no data is available
                  return const Text('No data available');
                }
              });
        },
      );

  Future<dynamic> getReviews(String userID) async {
    try {
      var data = await getReviewCenter(userID);
      print(data);
      return data;
    } catch (e) {
      print("error$e");
    }
  }

  Future<String?> _getSpecialist(String userID) async {
    try {
      // Check if userId is not null before calling profileShadowTeacher
      var result = await profileSpecialist(userID);
      print(result?.specialistID);
      return result?.centerID.toString();
    } catch (error) {
      // Handle errors here
      print('Error in _getSpecialist: $error');
      return null;
    }
  }

  Future<bool?> checkCenterRate(
    String userID,
    String centerID,
  ) async {
    try {
      bool? checkCenter = await checkIfUserRateCenterBefore(userID, centerID);
      return checkCenter;
    } catch (e) {
      print("error in checkCenterRate");
    }
    return null;
  }
}
