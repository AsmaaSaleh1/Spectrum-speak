import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/rest/rest_api_search.dart';
import 'package:spectrum_speak/widgets/card_specialist.dart';
import 'package:spectrum_speak/widgets/card_center.dart';
import 'package:spectrum_speak/widgets/card_shadow_teacher.dart';

import 'package:spectrum_speak/constant/const_color.dart';
import 'build_drop_down_menu.dart';

enum SearchEnum { center, specialist, shadowTeacher }

class MyTab extends StatefulWidget {
  final SearchEnum selectedSearch;
  final String namePrefix;
  const MyTab({
    required this.selectedSearch,
    required this.namePrefix,
    super.key,
  });

  @override
  State<MyTab> createState() => _MyTabState();
}

List<Widget> specialistCards = [];
List<Widget> centerCards = [];
List<Widget> shadowTeacherCards = [];

class _MyTabState extends State<MyTab> {
  SearchEnum selectedSearch = SearchEnum.specialist;
  String? selectedCity;
  String? selectedSpecialist;
  String? selectedGender;
  bool isMore = false;

  List<dynamic> specialistData = [];
  List<dynamic> centerData = [];
  List<dynamic> shadowTeacherData = [];
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
  @override
  void initState() {
    super.initState();
    calculateTotalHeight();
  }

  @override
  void didUpdateWidget(covariant MyTab oldWidget) {
    if (widget.namePrefix != oldWidget.namePrefix) {
      // The namePrefix has changed, perform your desired action here
      print('Accepted new namePrefix: ${widget.namePrefix}');
      getResults(); // You can also call getResults if needed
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: <Widget>[
          TabBar(
            onTap: (index) {
              switch (index) {
                case 0:
                  onSearchTypeChanged(SearchEnum.specialist);
                  getResults();
                  break;
                case 1:
                  onSearchTypeChanged(SearchEnum.center);
                  getResults();
                  break;
                case 2:
                  onSearchTypeChanged(SearchEnum.shadowTeacher);
                  getResults();
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
                      const SizedBox(
                        height: 8,
                      ),
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
                      const SizedBox(
                        height: 8,
                      ),
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
                      const SizedBox(
                        height: 8,
                      ),
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
            child: SizedBox(
              height: calculateTotalHeight(),
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
                                    padding: EdgeInsets.only(
                                        left: 10,
                                        top: 20,
                                        right: 10,
                                        bottom: 0),
                                    child: Icon(
                                      FontAwesomeIcons.locationDot,
                                      size: 22.0,
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
                                    onChanged: onCityChanged,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: 10,
                                        top: 20,
                                        right: 10,
                                        bottom: 0),
                                    child: Icon(
                                      FontAwesomeIcons.userDoctor,
                                      size: 22.0,
                                      color: kGreen,
                                    ),
                                  ),
                                  CustomDropDown(
                                    items: const [
                                      'All',
                                      'Audio & Speech',
                                      'Rehabilitation',
                                      'Psychiatrists'
                                    ],
                                    selectedValue: selectedSpecialist,
                                    hint: 'Select Category',
                                    onChanged: onSpecialistChanged,
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
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(
                                    left: 10, top: 20, right: 10, bottom: 0),
                                child: Icon(
                                  FontAwesomeIcons.locationDot,
                                  size: 22.0,
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
                                onChanged: onCityChanged,
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
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            direction: Axis.horizontal,
                            children: [
                              Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: 10,
                                        top: 20,
                                        right: 10,
                                        bottom: 0),
                                    child: Icon(
                                      FontAwesomeIcons.locationDot,
                                      size: 22.0,
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
                                    onChanged: onCityChanged,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: 10,
                                        top: 20,
                                        right: 10,
                                        bottom: 0),
                                    child: Icon(
                                      FontAwesomeIcons.venusMars,
                                      size: 22.0,
                                      color: kBlue,
                                    ),
                                  ),
                                  CustomDropDown(
                                    items: const [
                                      'All',
                                      'Male',
                                      'Female',
                                    ],
                                    selectedValue: selectedGender,
                                    hint: 'Select Gender',
                                    onChanged: onGenderChanged,
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
      ),
    );
  }

  void onSearchTypeChanged(SearchEnum newValue) {
    setState(() {
      selectedSearch = newValue;
    });
  }

  void onCityChanged(String? value) {
    setState(() {
      selectedCity = value;
    });
    getResults();
  }

  void onSpecialistChanged(String? value) {
    setState(() {
      selectedSpecialist = value;
    });
    getResults();
  }

  void onGenderChanged(String? value) {
    setState(() {
      selectedGender = value;
    });
    getResults();
  }

  Future<void> getSpecialists(
      String namePrefix, String selectedCity, String specialistCategory) async {
    try {
      var data =
          await searchSpecialist(namePrefix, selectedCity, specialistCategory);
      setState(() {
        specialistData = data;
        specialistCards = specialistData.asMap().entries.map((entry) {
          int index = entry.key;
          return CardSpecialist(
            userId: entry.value['UserID'].toString(),
            cardColor: cardColors[index % cardColors.length],
            username: entry.value['Username'] ?? '',
            city: entry.value['City'] ?? '',
            price: entry.value['Price'].toString(),
            centerName: entry.value['CenterName'] ?? '',
            category: entry.value['SpecialistCategory'] ?? '',
            // Pass other fields as needed
          );
        }).toList();
      });
    } catch (error) {
      print('Error fetching specialist data: $error');
    }
  }

  Future<void> getCenter(String namePrefix, String selectedCity) async {
    try {
      var data = await searchCenter(namePrefix, selectedCity);
      setState(() {
        centerData = data;
        centerCards = centerData.asMap().entries.map((entry) {
          int index = entry.key;
          return CenterCard(
            userId: entry.value['UserID'].toString(),
            cardColor: cardColors[index % cardColors.length],
            about: entry.value['Description'] ?? '',
            centerName: entry.value['CenterName'] ?? '',
            city: entry.value['City'] ?? '',
            onTap: () => setState(() {
              isMore = !isMore;
            }),
            isLess: isMore,
            // Pass other fields as needed
          );
        }).toList();
      });
    } catch (error) {
      print('Error fetching Center data: $error');
    }
  }

  Future<void> getShadowTeacher(
      String namePrefix, String selectedCity, String gender) async {
    try {
      var data = await searchShadowTeacher(namePrefix, selectedCity, gender);
      setState(() {
        shadowTeacherData = data;
        shadowTeacherCards = shadowTeacherData.asMap().entries.map((entry) {
          int index = entry.key;
          return CardShadowTeacher(
            userId: entry.value['UserID'].toString(),
            cardColor: cardColors[index % cardColors.length],
            teacherName: entry.value['Username'] ?? '',
            academicQualification: entry.value['AcademicQualification'] ?? '',
            city: entry.value['City'] ?? '',
            gender: entry.value['Gender'] ?? '',
            availability: entry.value['Availability'] ?? '',
          );
        }).toList();
      });
    } catch (error) {
      print('Error fetching specialist data: $error');
    }
  }

  Future<void> getResults() async {
    try {
      if (selectedSearch == SearchEnum.specialist) {
        await getSpecialists(
          widget.namePrefix,
          selectedCity ?? 'All',
          selectedSpecialist ?? 'All',
        );
      } else if (selectedSearch == SearchEnum.center) {
        await getCenter(
          widget.namePrefix,
          selectedCity ?? 'All',
        );
      } else if (selectedSearch == SearchEnum.shadowTeacher) {
        await getShadowTeacher(
          widget.namePrefix,
          selectedCity ?? 'All',
          selectedGender ?? 'All',
        );
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  double calculateTotalHeight() {
    // You may need to adjust this logic based on your actual card height
    double cardHeight = 550.0; // Adjust this based on your card height
    double spacingBetweenCards =
        80.0; // Adjust this based on your desired spacing

    int totalNumberOfCards;
    if (selectedSearch == SearchEnum.specialist) {
      totalNumberOfCards = specialistCards.length;
    } else if (selectedSearch == SearchEnum.center) {
      totalNumberOfCards = centerCards.length;
    } else if (selectedSearch == SearchEnum.shadowTeacher) {
      totalNumberOfCards = shadowTeacherCards.length;
    } else {
      totalNumberOfCards = 0;
    }

    // Calculate the initial height plus the space required for all cards
    double initialHeight =
        600.0; // Set your initial height when entering the page
    return initialHeight +
        totalNumberOfCards * (cardHeight + spacingBetweenCards);
  }
}
