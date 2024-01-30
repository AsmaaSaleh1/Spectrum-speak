import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/modules/Booking.dart';
import 'package:spectrum_speak/modules/Event.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/rest/rest_api_booking.dart';
import 'package:spectrum_speak/rest/rest_api_center.dart';
import 'package:spectrum_speak/rest/rest_api_login.dart';
import 'package:spectrum_speak/rest/rest_api_menu.dart';
import 'package:spectrum_speak/screen/calendar_grid.dart';
import 'package:spectrum_speak/screen/search_page.dart';
import 'package:spectrum_speak/screen/spectrum_bot.dart';
import 'package:spectrum_speak/units/custom_clipper_Main_square.dart';
import 'package:spectrum_speak/units/custom_clipper_main.dart';
import 'package:spectrum_speak/units/custom_clipper_main_upper.dart';
import 'package:spectrum_speak/units/custom_main_button.dart';
import 'package:spectrum_speak/widgets/card_booking_main.dart';
import 'package:spectrum_speak/widgets/card_event_main.dart';
import 'package:spectrum_speak/widgets/top_bar.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'login.dart';

bool mainPageGuide = true;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String category = "";
  String userName = "";
  String city = "";
  List<Booking> bookingList = [];
  List<Event> eventList = [];
  TutorialCoachMark? tutorialCoachMark;
  List<TargetFocus>? targets;
  GlobalKey spectrumKey = GlobalKey();
  GlobalKey searchKey = GlobalKey();
  GlobalKey profileKey = GlobalKey();
  @override
  initState() {
    if (AuthManager.firstTime && mainPageGuide)
      Future.delayed(const Duration(seconds: 3), () {
        _showTutorialCoachmark();
      });
    super.initState();
    checkLoginStatus();
    getData();
  }

  void _showTutorialCoachmark() {
    mainPageGuide = false;
    _initTarget();
    tutorialCoachMark = TutorialCoachMark(
      targets: targets!,
      pulseEnable: false,
      colorShadow: tutorialColor,
      onClickTarget: (target) {
        print("${target.identify}");
      },
      hideSkip: true,
      alignSkip: Alignment.topRight,
      onFinish: () {
        print("Finish");
        Future.delayed(const Duration(seconds: 1), () {
          showTut(context);
        });
      },
    )..show(context: context);
  }

  void _initTarget() {
    targets = [
      // profile
      TargetFocus(
        identify: "profile-key",
        keyTarget: profileKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                next: "Start👏",
                text:
                    "Hello there!👋This is your Spectrum Speak Buddy🤖! I'll be here to assist you on how to use Spectrum Speak to the fullest and to introduce you to its features! Let's get started💪",
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
        identify: "spectrum-key",
        keyTarget: spectrumKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                text:
                    "Tap here to chat with SpectrumBot and ask questions and get answers right away😁",
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
        identify: "search-key",
        keyTarget: searchKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                text: "Tap here to search for fellow SpectrumSpeakers💫",
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

  Future<List<Widget>?> getBookingWidgets() async {
    return bookingList
        .map(
          (book) => CardBooking(
            booking: book,
            category: category,
          ),
        )
        .toList();
  }

  Future<List<Widget>?> getEventsWidgets() async {
    return eventList
        .map(
          (event) => CardEvent(
            events: event,
            category: category,
          ),
        )
        .toList();
  }

  Future getData() async {
    try {
      String? userId = await AuthManager.getUserId();

      if (userId != null) {
        String cat = await getUserCategory(userId);
        String user = await getUserName(userId);
        String cit = await getCity(userId);
        setState(() {
          userName = user;
          category = cat;
          city = cit;
        });
        if (category != '') {
          var listBook = await getBookingsForSevenDay(userId, category);
          var listEvent = await getEventsForSevenDay(city);
          setState(() {
            bookingList = listBook;
            eventList = listEvent;
          });
        } else {
          print("Error: Empty category in getData class main page");
        }
      } else {
        print("Error: Null userID in getData class main page");
      }
    } catch (e) {
      print("Error in getData class main page: $e");
    }
  }

  Future<void> updateData() async {
    if (category != '') {
      var listBook =
          await getBookingsForSevenDay(AuthManager.u.UserID.toString(), category);
      var listEvent = await getEventsForSevenDay(city);
      setState(() {
        bookingList = listBook;
        eventList = listEvent;
      });
    }
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
          double screenHeight = constraints.minHeight;
          double linePadding;
          if (screenWidth >= 1200) {
            linePadding = 110;
          } else if (screenWidth >= 800) {
            linePadding = 70;
          } else {
            linePadding = 20;
          }
          return TopBar(
            callback: getData,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        child: ClipPath(
                          clipper: MyCustomClipperMainSquare(),
                          child: Container(
                            color: kYellow,
                            height: kIsWeb ? 500 :screenWidth,
                            width: screenWidth,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        height: screenWidth,
                        width: screenWidth,
                        child: ClipPath(
                          clipper: MyCustomClipperMainUpper(),
                          child: Container(
                            height: 300.0,
                            color: kGreen,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        height: screenWidth,
                        width: screenWidth,
                        child: ClipPath(
                          clipper: MyCustomClipperMain(),
                          child: Container(
                            height: 300.0,
                            color: kBlue,
                          ),
                        ),
                      ),
                      if (kIsWeb)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: Text(
                                  'Welcome Back,\n $userName💫',
                                  style: TextStyle(
                                    color: kDarkerColor,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Container(
                                  height: screenHeight / 2.3,
                                  child: Image.asset(
                                    'images/borderPuzzle.png',
                                    width: screenHeight / 2.3,
                                    height: screenHeight / 2.3,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                      if(!kIsWeb)
                      Positioned(
                        bottom: screenWidth / 2,
                        left: linePadding,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              // key:profileKey,
                              // key: AuthManager.firstTime?profileKey:null,
                              child: Text(
                                key:profileKey,
                                'Welcome Back,\n $userName💫',
                                style: TextStyle(
                                  color: kDarkerColor,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Container(
                                height: screenWidth / 3,
                                child: Image.asset(
                                  'images/borderPuzzle.png',
                                  width: screenWidth / 3,
                                  height: screenWidth / 3,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!kIsWeb)
                          Positioned(
                            bottom: screenWidth / 40,
                            top: screenWidth / 1.5,
                            left:
                                (screenWidth - (linePadding * 2) - (120 * 3)) /
                                    2,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Container(
                                    width: 120,
                                    height: 120,
                                    child: CustomMainButton(
                                      foregroundColor: kPrimary,
                                      backgroundColor: kBlue,
                                      onPressed: () {},
                                      buttonText: 'Calender',
                                      icon: const Icon(
                                        FontAwesomeIcons.calendar,
                                        size: 35.0,
                                      ),
                                      iconColor: kPrimary,
                                    ),
                                  ),
                                  SizedBox(
                                    width: linePadding,
                                  ),
                                  Container(
                                    key:spectrumKey,
                                    width: 120,
                                    height: 120,
                                    child: CustomMainButton(
                                      foregroundColor: kPrimary,
                                      backgroundColor: kBlue,
                                      onPressed: () {},
                                      buttonText: 'Spectrum\n     Bot',
                                      icon: const Icon(
                                        FontAwesomeIcons.brain,
                                        size: 35.0,
                                      ),
                                      iconColor: kPrimary,
                                    ),
                                  ),
                                  SizedBox(
                                    width: linePadding,
                                  ),
                                  Container(
                                    key:searchKey,
                                    width: 120,
                                    height: 120,
                                    child: CustomMainButton(
                                      foregroundColor: kPrimary,
                                      backgroundColor: kBlue,
                                      onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const Search(),
                                        ),
                                      ),
                                      buttonText: 'Search',
                                      icon: const Icon(
                                        FontAwesomeIcons.magnifyingGlass,
                                        size: 35.0,
                                      ),
                                      iconColor: kPrimary,
                                    ),
                                  ),
                                ],
                            ),
                          )
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (category != "ShadowTeacher")
                  Row(
                    children: [
                      SizedBox(
                        width: linePadding,
                      ),
                      Icon(
                        FontAwesomeIcons.bookBookmark,
                        size: 28,
                        color: kDarkerColor,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Sessions Of The Week",
                        style: TextStyle(
                          color: kDarkerColor,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  if (category != "ShadowTeacher")
                  FutureBuilder<List<Widget>?>(
                    future: getBookingWidgets(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Stack(
                          children: [
                            Visibility(
                              visible: snapshot.data != null &&
                                  snapshot.data!.isNotEmpty,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: snapshot.data ??
                                      [], // Provide a default value when null
                                ),
                              ),
                            ),
                            Visibility(
                              visible: snapshot.data == null &&
                                  snapshot.data!.isEmpty,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "No Sessions For This Week",
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                    color: kBlue,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: linePadding,
                      ),
                      Icon(
                        FontAwesomeIcons.businessTime,
                        size: 28,
                        color: kDarkerColor,
                      ),
                      SizedBox(
                        width: linePadding,
                      ),
                      Text(
                        "Events near you this week📍",
                        style: TextStyle(
                          color: kDarkerColor,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  FutureBuilder<List<Widget>?>(
                    future: getEventsWidgets(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
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
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Stack(
                          children: [
                            Visibility(
                              visible: snapshot.data != null ||
                                  snapshot.data!.isNotEmpty,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: snapshot.data ??
                                      [], // Provide a default value when null
                                ),
                              ),
                            ),
                            Visibility(
                              visible: snapshot.data == null ||
                                  snapshot.data!.isEmpty,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "No Events For This Week",
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                    color: kBlue,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  Divider(
                    color: kDarkBlue,
                    thickness: 2.0,
                    indent: linePadding,
                    endIndent: linePadding,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.symmetric(horizontal: linePadding * 1.5),
                    child: Text(
                      "Be The Reason",
                      style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                        color: kYellow.withGreen(180),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.symmetric(horizontal: linePadding * 1.5),
                    child: Text(
                      "Someone Smiles Today!",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: kDarkBlue,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.symmetric(horizontal: linePadding * 1.5),
                    child: Text(
                      "Join us in creating brighter futures and fostering a world where every child on the autism spectrum receives the support they deserve. Your support makes a meaningful difference.",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.symmetric(horizontal: linePadding * 1.5),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "For further details, please don't hesitate to reach out to us through the following channels:",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: kDarkerColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.symmetric(
                        horizontal: linePadding*0.8  + 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  Icons.email,
                                  size: 30,
                                  color: kDarkBlue,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Email:',
                                      style: TextStyle(
                                        color: kDarkerColor,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'spectrumspeak2024@gmail.com',
                                      style: TextStyle(
                                        color: kDarkerColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: 30,
                                  color: kDarkBlue,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Phone:',
                                      style: TextStyle(
                                        color: kDarkerColor,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '+(970) 592-676-710',
                                      style: TextStyle(
                                        color: kDarkerColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        Container(
                          height: screenWidth / 5,
                          child: Image.asset(
                            'images/donation_img.png',
                            width: screenWidth / 5,
                            height: screenWidth / 5,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          );
        },
      );
}