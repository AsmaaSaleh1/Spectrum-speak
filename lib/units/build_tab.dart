import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/widgets/card_specialist.dart';
import 'package:spectrum_speak/widgets/card_center.dart';
import 'package:spectrum_speak/widgets/card_shadow_teacher.dart';

import 'package:spectrum_speak/const.dart';
import 'build_drop_down_menu.dart';

enum Search { center, specialist, shadowTeacher }

class MyTab extends StatefulWidget {
  final Search selectedSearch;

  const MyTab({
    required this.selectedSearch,
    Key? key,
  }) : super(key: key);

  @override
  State<MyTab> createState() => _MyTabState();
}

class _MyTabState extends State<MyTab> {
  Search selectedSearch = Search.center;
  String? selectedCity;
  String? selectedSpecialist;
  String? selectedGender;

  void onSearchTypeChanged(Search newValue) {
    setState(() {
      selectedSearch = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Color> cardColors = [
      kBlue,
      kRed,
      kGreen,
      kYellow,
      kBlue,
      kRed,
      kGreen,
      kYellow,
      kBlue,
      kRed,
      kGreen,
      kYellow
    ];
    List<Widget> specialistCards = [];
    List<Widget> centerCards = [];
    List<Widget> shadowTeacherCards = [];

    for (Color color in cardColors) {
      if (selectedSearch == Search.specialist) {
        specialistCards.add(CardSpecialist(cardColor: color));
      } else if (selectedSearch == Search.center) {
        centerCards.add(CenterCard(cardColor: color));
      } else if (selectedSearch == Search.shadowTeacher) {
        shadowTeacherCards.add(CardShadowTeacher(cardColor: color));
      }
    }
    return DefaultTabController(
        length: 3,
        child: Column(
          children: <Widget>[
            TabBar(
              onTap: (index) {
                switch (index) {
                  case 0:
                    onSearchTypeChanged(Search.specialist);
                    break;
                  case 1:
                    onSearchTypeChanged(Search.center);
                    break;
                  case 2:
                    onSearchTypeChanged(Search.shadowTeacher);
                    break;
                }
              },
              padding: EdgeInsets.zero,
              indicatorPadding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              indicator: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: kDarkBlue, // Change the indicator color
                    width: 3.0, // Set the width of the line
                  ),
                ),
              ),
              labelColor: kDarkBlue, // Change the selected tab label color
              unselectedLabelColor:
                  kDarkerColor, // Change the unselected tab label color
              tabs: <Widget>[
                Tab(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        const Text('Specialist'),
                        Icon(
                          FontAwesomeIcons.userDoctor,
                          size: 15.0,
                          color: kDarkerColor,
                        ),
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        const Text('Center'),
                        Icon(
                          FontAwesomeIcons.buildingUser,
                          size: 15.0,
                          color: kDarkerColor,
                        ),
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        const Text('Shadow Teacher'),
                        Icon(
                          FontAwesomeIcons.graduationCap,
                          size: 15.0,
                          color: kDarkerColor,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Container(
                height: 5200, //TODO: make it not fixed
                child: TabBarView(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Wrap(
                              direction: Axis.horizontal,
                              alignment: WrapAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 10,top: 20,right: 10,bottom: 0),
                                      child: Icon(
                                        FontAwesomeIcons.locationDot,
                                        size: 30.0,
                                        color: kRed,
                                      ),
                                    ),
                                    CustomDropDown(
                                      items: const [
                                        'All',
                                        'Nablus',
                                        'Ramallah',
                                        'Jerusalem',
                                        'Bethlehem',
                                        'Qalqilya',
                                        'Hebron',
                                        'Jenin',
                                        'Tulkarm',
                                      ],
                                      selectedValue: selectedCity,
                                      hint: 'Select City',
                                      onChanged: (String? value) {
                                        setState(() {
                                          selectedCity = value;
                                        }
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 30,),
                                Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 10,top: 20,right: 10,bottom: 0),
                                      child: Icon(
                                        FontAwesomeIcons.userDoctor,
                                        size: 30.0,
                                        color: kGreen,
                                      ),
                                    ),
                                    CustomDropDown(
                                      items: const[
                                        'Audio & Speech',
                                        'Rehabilitation',
                                        'Psychiatrists'
                                      ],
                                      selectedValue: selectedSpecialist,
                                      hint: 'Select Category',
                                      onChanged: (String? value) {
                                        setState(() {
                                          selectedSpecialist = value;
                                        }
                                        );
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Wrap(
                            spacing: 50.0, // Horizontal spacing between items
                            runSpacing: 30.0, // Vertical spacing between lines
                            children:
                                specialistCards, // Use the list of cards here
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child:Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 10,top: 20,right: 10,bottom: 0),
                                  child: Icon(
                                    FontAwesomeIcons.locationDot,
                                    size: 30.0,
                                    color: kRed,
                                  ),
                                ),
                                CustomDropDown(
                                  items: const [
                                    'All',
                                    'Nablus',
                                    'Ramallah',
                                    'Jerusalem',
                                    'Bethlehem',
                                    'Qalqilya',
                                    'Hebron',
                                    'Jenin',
                                    'Tulkarm',
                                  ],
                                  selectedValue: selectedCity,
                                  hint: 'Select City',
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedCity = value;
                                    }
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Wrap(
                            spacing: 50.0, // Horizontal spacing between items
                            runSpacing: 30.0, // Vertical spacing between lines
                            children: centerCards, // Use the list of cards here
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child:Wrap(
                              alignment: WrapAlignment.start,
                              direction: Axis.horizontal,
                              children: [
                                Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 10,top: 20,right: 10,bottom: 0),
                                      child: Icon(
                                        FontAwesomeIcons.locationDot,
                                        size: 30.0,
                                        color: kRed,
                                      ),
                                    ),
                                    CustomDropDown(
                                      items: const [
                                        'All',
                                        'Nablus',
                                        'Ramallah',
                                        'Jerusalem',
                                        'Bethlehem',
                                        'Qalqilya',
                                        'Hebron',
                                        'Jenin',
                                        'Tulkarm',
                                      ],
                                      selectedValue: selectedCity,
                                      hint: 'Select City',
                                      onChanged: (String? value) {
                                        setState(() {
                                          selectedCity = value;
                                        }
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 30,),
                                Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 10,top: 20,right: 10,bottom: 0),
                                      child: Icon(
                                        FontAwesomeIcons.venusMars,
                                        size: 30.0,
                                        color: kBlue,
                                      ),
                                    ),
                                    CustomDropDown(
                                      items: const [
                                        'Male',
                                        'Female',
                                      ],
                                      selectedValue: selectedGender,
                                      hint: 'Select Gender',
                                      onChanged: (String? value) {
                                        setState(() {
                                          selectedGender = value;
                                        }
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Wrap(
                            spacing: 50.0, // Horizontal spacing between items
                            runSpacing: 30.0, // Vertical spacing between lines
                            children:
                            shadowTeacherCards, // Use the list of cards here
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
