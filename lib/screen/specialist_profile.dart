import 'package:flutter/material.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/rest/rest_api_menu.dart';
import 'package:spectrum_speak/rest/rest_api_profile.dart';
import 'package:spectrum_speak/rest/rest_api_rate.dart';
import 'package:spectrum_speak/widgets/card_review.dart';

import 'package:spectrum_speak/widgets/stack_container_specialist.dart';

import 'package:spectrum_speak/widgets/specialist_information.dart';

import 'package:spectrum_speak/units/review_add_from_user.dart';
import 'package:spectrum_speak/widgets/top_bar.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'login.dart';

bool spprofileGuide = true;

class SpecialistProfile extends StatefulWidget {
  final String userId;
  const SpecialistProfile({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<SpecialistProfile> createState() => _SpecialistProfileState();
}

class _SpecialistProfileState extends State<SpecialistProfile> {
  double userRating = 0.0;
  bool x = false; // Set your boolean value here

  List<dynamic> reviews = [];
  String name = "";
  String userIdLogin = "";
  String specialistID = "";
  String category = '';
  TutorialCoachMark? tutorialCoachMark;
  List<TargetFocus>? targets;
  GlobalKey bookSessionKey = GlobalKey();
  GlobalKey rateKey = GlobalKey();
  void _showTutorialCoachmark() {
    spprofileGuide = true;
    _initTarget();
    tutorialCoachMark = TutorialCoachMark(
      targets: targets!,
      pulseEnable: false,
      colorShadow: Color.fromARGB(110, 14, 95, 136),
      onClickTarget: (target) {
        print("${target.identify}");
      },
      hideSkip: true,
      alignSkip: Alignment.topRight,
      onFinish: () {
        print("Finish");
      },
    )..show(context: context);
  }

  void _initTarget() {
    targets = [
      // profile
      TargetFocus(
        identify: "bookSession-key",
        keyTarget: bookSessionKey,
        shape: ShapeLightFocus.RRect,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                text:
                    "Tap here to book a session with the specialist for your child",
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
      TargetFocus(
        identify: "rate-key",
        keyTarget: rateKey,
        shape: ShapeLightFocus.RRect,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return CoachmarkDesc(
                text:
                    "Rate this specialist after your experience with them and spread your feedback across the spectrum🌈",
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
    ];
  }

  @override
  void initState() {
    if (AuthManager.firstTime &&
        spprofileGuide &&
        AuthManager.getCategory() == 'Parent')
      Future.delayed(const Duration(seconds: 1), () {
        _showTutorialCoachmark();
      });
    super.initState();
    checkLoginStatus();
    loadReviews(); // Call the method to load reviews
    getName();
    getID();
    getSpecialistID();
    print('user categy $category');
  }

  Future<void> getCategory() async {
    category = await getUserCategory('${AuthManager.u.UserID}');
  }

  Future<void> getSpecialistID() async {
    try {
      String? result = await _getSpecialist(widget.userId);
      if (result != null) {
        setState(() {
          specialistID = result;
        });
      }
    } catch (error) {
      // Handle errors here
      print('Error in getSpecialistID: $error');
    }
  }

  Future<void> loadReviews() async {
    var reviewsData = await getReviews(widget.userId);
    if (reviewsData != null) {
      setState(() {
        reviews = reviewsData;
      });
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
              future: checkSpecialistRate(userIdLogin, specialistID),
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
                  bool checkSpecialist = snapshot.data!;
                  return Scaffold(
                    appBar: AppBar(
                      title: Text('Profile'),
                    ),
                    body: Stack(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              StackContainerSpecialist(
                                key: bookSessionKey,
                                userId: widget.userId,
                                category: category,
                              ),
                              SpecialistInformation(
                                userId: widget.userId,
                              ),
                              Visibility(
                                visible: widget.userId != userIdLogin,
                                child: Visibility(
                                  visible: !checkSpecialist,
                                  child: Divider(
                                    color: kDarkerColor,
                                    thickness: 2.0,
                                    indent: linePadding,
                                    endIndent: linePadding,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: widget.userId != userIdLogin,
                                child: Visibility(
                                  visible: !checkSpecialist,
                                  child: AddReview(
                                    key: rateKey,
                                    image: 'images/prof.png',
                                    name: name,
                                    userRating: userRating,
                                    onRating: (double newRating) {
                                      setState(() {
                                        userRating = newRating;
                                      });
                                    },
                                    specialistID: specialistID,
                                    centerID: "",
                                    isCenter: false,
                                    ID: widget.userId.toString(),
                                  ),
                                ),
                              ),
                              Divider(
                                color: kDarkerColor,
                                thickness: 2.0,
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
                                        userName: review["UserName"] ?? "",
                                        date: review["Date"] ?? "",
                                        comment: review["Comment"] ?? "",
                                        rate: review["Rate"].toString(),
                                        isCenter: false,
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
                              const SizedBox(
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
                            height: 80,
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
      var data = await getReviewSpecialist(userID);
      return data;
    } catch (e) {
      print("error$e");
    }
  }

  Future<String?> _getSpecialist(String userID) async {
    try {
      // Check if userId is not null before calling profileShadowTeacher
      var result = await profileSpecialist(userID);
      return result?.specialistID.toString();
    } catch (error) {
      // Handle errors here
      print('Error in _getSpecialist: $error');
      return null;
    }
  }

  Future<bool?> checkSpecialistRate(
    String userID,
    String specialistID,
  ) async {
    try {
      bool? checkSpecialist =
          await checkIfUserRateSpecialistBefore(userID, specialistID);
      return checkSpecialist;
    } catch (e) {
      print("error in checkSpecialistRate $e");
    }
    return null;
  }
}
