import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/units/build_search_text_field.dart';
import 'package:spectrum_speak/widgets/top_bar.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/units/build_tab.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

bool searchGuide = false;

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TopBar(
        body: SearchToCall(),
        cameFromSearch:true,
      ),
    );
  }
}

class SearchToCall extends StatefulWidget {
  const SearchToCall({super.key});

  @override
  State<SearchToCall> createState() => _SearchToCallState();
}

class _SearchToCallState extends State<SearchToCall> {
  SearchEnum selectedSearch = SearchEnum.specialist;
  final TextEditingController _searchController = TextEditingController();
  StreamController<double> controller = StreamController<double>();
  TutorialCoachMark? tutorialCoachMark;
  List<TargetFocus>? targets;
  GlobalKey searchKey = GlobalKey();
  GlobalKey viewInfoKey = GlobalKey();
  @override
  void initState() {
    // if (AuthManager.firstTime && searchGuide)
    //   Future.delayed(const Duration(seconds: 1), () {
    //     _showTutorialCoachmark();
    //   });
    super.initState();
    onSearchTypeChanged(selectedSearch);
  }

  void _showTutorialCoachmark() {
    searchGuide = false;
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
        identify: "search-key",
        keyTarget: searchKey,
        shape: ShapeLightFocus.RRect,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              print('builder here');
              return CoachmarkDesc(
                text:
                    "Here you can type in the name of the specialist, center or shadow teacher that you're looking for🔎",
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
        identify: "viewInfo-key",
        keyTarget: viewInfoKey,
        shape: ShapeLightFocus.RRect,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              print('builder here');
              return CoachmarkDesc(
                text:
                    "Here you can view specialists👩‍⚕️ centers🏢 shadow teachers🧑‍🏫! Filter them by the desired city or the desired specialist",
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

  void onSearchTypeChanged(SearchEnum newValue) {
    setState(() {
      selectedSearch = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          FontAwesomeIcons.magnifyingGlass,
                          size: 40.0,
                          color: kDarkBlue,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Search",
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: kDarkerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                CustomSearchTextField(
                  // key: searchKey,
                  labelText: "Search",
                  placeholder: "eg: Al-Amal center",
                  controller: _searchController,
                  onTextChanged: (text) {
                    setState(() {
                      _searchController.text = text;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: MyTab(
                    // key: viewInfoKey,
                    selectedSearch: selectedSearch,
                    namePrefix: _searchController.text,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Add the gradient at the bottom of the stack
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
      ],
    );
  }
}
