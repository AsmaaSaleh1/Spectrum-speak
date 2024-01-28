import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spectrum_speak/modules/Questions.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/widgets/custom_slider.dart';
import 'package:spectrum_speak/widgets/top_bar.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../constant/const_color.dart';
import 'Result.dart';

bool quizGuide = true;

class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  bool _lights = false;
  bool showText = false;
  Questions q = Questions();
  List<double> cardSliderValues = List.filled(21, 1.0);
  TutorialCoachMark? tutorialCoachMark;
  List<TargetFocus>? targets;
  GlobalKey switchKey = GlobalKey();
  GlobalKey questionsKey = GlobalKey();
  GlobalKey sliderKey = GlobalKey();
  @override
  void initState() {
    if(AuthManager.firstTime&&quizGuide)
    Future.delayed(const Duration(seconds: 1), () {
      _showTutorialCoachmark();
    });
    super.initState();
    _hideTextAfterDelay();
  }

  void _showTutorialCoachmark() {
    quizGuide = false;
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
      },
    )..show(context: context);
  }

  void _initTarget() {
    targets = [
      // profile
      TargetFocus(
        identify: "switch-key",
        keyTarget: switchKey,
        shape: ShapeLightFocus.RRect,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                text:
                    "Toggle the switch and select the preferred language for the quiz",
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
        identify: "questions-key",
        keyTarget: questionsKey,
        shape: ShapeLightFocus.RRect,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return CoachmarkDesc(
                text:
                    "Read the question carefully and asses how much your child relates to the question from 1 to 5",
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
        identify: "slider-key",
        keyTarget: sliderKey,
        shape: ShapeLightFocus.RRect,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return CoachmarkDesc(
                text:
                    "Hold the swiper and swipe to the left or to the right to submit an answer on a scale from 1 to 5 for this question!",
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

  void _hideTextAfterDelay() {
    // Hide the text after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          showText = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kDarkBlue,
        title: const Text(
          'Spectrum Quiz',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: kPrimary,
          ),
        ),
      ),
      backgroundColor: kPrimary,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoSwitch(
                  key: switchKey,
                  value: _lights,
                  onChanged: (bool value) {
                    setState(() {
                      _lights = value;
                    });
                  },
                ),
                Text(
                  _lights ? 'Arabic' : 'English',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: kDarkBlue,
                  ),
                ),
              ],
            ),
            Padding(
              padding: _lights
                  ? EdgeInsets.only(left: 35, top: 20, bottom: 20)
                  : EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
              child: _lights
                  ? Center(
                      child: Text("أجب عن الأسئلة التالية بمقياس من 1 إلى 5:",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: GoogleFonts.amiri().fontFamily,
                            fontWeight: FontWeight.w600,
                            fontSize: 19,
                            color: kDarkBlue,
                          )))
                  : Text(
                      "Answer the following questions on a scale from 1 to 5",
                      textDirection:
                          !_lights ? TextDirection.ltr : TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: !_lights
                            ? GoogleFonts.heebo().fontFamily
                            : GoogleFonts.amiri().fontFamily,
                        fontWeight: FontWeight.w600,
                        fontSize: 19,
                        color: kDarkBlue,
                      ),
                    ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 50),
              width: MediaQuery.of(context).size.width,
              height: 400,
              child: Swiper(
                key: questionsKey,
                layout: SwiperLayout.STACK,
                itemWidth: 350,
                itemHeight: 2000,
                loop: false,
                duration: 200,
                scrollDirection: Axis.horizontal,
                itemCount: 21,
                onTap: (index) {
                  setState(() {
                    showText = true;
                    _hideTextAfterDelay();
                  });
                },
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: kYellow,
                          width: 2.0,
                        ),
                        color: kDarkerBlue),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 18, right: 18, top: 30, bottom: 50),
                          child: Text(
                            _lights
                                ? q.arabicQuestions[index]
                                : q.englishQuestions[index],
                            textDirection:
                                _lights ? TextDirection.rtl : TextDirection.ltr,
                            style: _lights
                                ? TextStyle(
                                    fontFamily: GoogleFonts.amiri().fontFamily,
                                    color: kPrimary,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 22)
                                : TextStyle(
                                    fontFamily: GoogleFonts.heebo().fontFamily,
                                    color: kPrimary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22),
                          ),
                        ),
                        index == 0
                            ? CustomSlider(
                                key: sliderKey,
                                value: cardSliderValues[index],
                                onChanged: (newRating) {
                                  setState(() {
                                    cardSliderValues[index] = newRating;
                                  });
                                },
                                min: 1,
                                max: 5,
                              )
                            : CustomSlider(
                                value: cardSliderValues[index],
                                onChanged: (newRating) {
                                  setState(() {
                                    cardSliderValues[index] = newRating;
                                  });
                                },
                                min: 1,
                                max: 5,
                              ),
                        if (index == 20)
                          Padding(
                            padding: EdgeInsets.all(20.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  print("Autism Level " +
                                      q
                                          .calculateAutismLevel(
                                              cardSliderValues)
                                          .toString());
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Result(
                                            result: q.calculateAutismLevel(
                                                cardSliderValues))),
                                  );
                                },
                                child: Text('Submit',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      fontFamily: GoogleFonts.heebo.toString(),
                                      color: kDarkerBlue,
                                    )),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      kLighterYellow, // Background color// Text color
                                  elevation: 5, // Shadow elevation
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 24), // Button padding
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        13), // Button border shape
                                  ),
                                )),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            AnimatedOpacity(
              duration: Duration(seconds: 1),
              opacity: showText ? 1.0 : 0.0,
              child: Padding(
                padding: !_lights
                    ? EdgeInsets.only(top: 40, left: 50)
                    : EdgeInsets.only(top: 40, left: 130),
                child: Text(
                  !_lights
                      ? 'Swipe for the next question!'
                      : 'اسحب للسؤال التالي!',
                  textDirection:
                      _lights ? TextDirection.rtl : TextDirection.ltr,
                  style: TextStyle(
                    fontFamily: !_lights
                        ? GoogleFonts.heebo().fontFamily
                        : GoogleFonts.amiri().fontFamily,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: kDarkBlue,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
