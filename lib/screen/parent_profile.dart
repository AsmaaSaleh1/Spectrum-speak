import 'package:flutter/material.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/modules/child.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/rest/rest_api_profile.dart';
import 'package:spectrum_speak/units/custom_button.dart';
import 'package:spectrum_speak/widgets/card_item.dart';
import 'package:spectrum_speak/widgets/stack_container_parent.dart';
import 'package:spectrum_speak/widgets/parent_information.dart';

import 'add_child.dart';
import 'login.dart';

class ParentProfile extends StatefulWidget {
  final String userID;
  const ParentProfile({super.key, required this.userID});

  @override
  State<ParentProfile> createState() => _ParentProfileState();
}

class _ParentProfileState extends State<ParentProfile> {
  List<Child> children = [];
  @override
  void initState() {
    super.initState();
    _loadChildren(widget.userID);
    checkLoginStatus();
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
          return FutureBuilder<String?>(
              future: _getID(),
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
                  String userIdLogin = snapshot.data!;
                  return Scaffold(
                    appBar: AppBar(
                      title: Text('Profile'),
                    ),
                    body: Stack(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              StackContainerParent(
                                userID: widget.userID,
                              ),
                              ParentInformation(
                                userID: widget.userID,
                              ),
                              Divider(
                                color: kDarkerColor,
                                thickness: 2.0,
                                indent: linePadding,
                                endIndent: linePadding,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: AlignmentDirectional.topCenter,
                                child: Text(
                                  "My Children",
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                    color: kDarkerColor,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: children.isNotEmpty,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: children
                                        .map((child) => CardItem(
                                              childId: child.childID,
                                              userName: child.childName,
                                              gender: child.gender,
                                              birthDate: child.birthDate,
                                              degreeOfAutism:
                                                  child.degreeOfAutism,
                                              userID: child.userID,
                                              // Add other properties as needed
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: children.isEmpty &&
                                    userIdLogin == widget.userID,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const AddChild(
                                            comeFromSignUp: false,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "You Can Add Your children",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: kGreen,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: userIdLogin == widget.userID,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: linePadding, vertical: 10),
                                  child: Align(
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: CustomButton(
                                      foregroundColor: kDarkerColor,
                                      backgroundColor: kBlue,
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => const AddChild(
                                              comeFromSignUp: false,
                                            ),
                                          ),
                                        );
                                      },
                                      buttonText: "Add Child",
                                      icon: Icon(Icons.add_box_outlined),
                                      iconColor: kPrimary,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 70,
                              ),
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
  Future<void> _loadChildren(String userId) async {
    List<Child> loadedChildren = await childCard(userId);
    setState(() {
      children = loadedChildren;
    });
  }

  Future<String?> _getID() async {
    try {
      // Check if userId is not null before calling profileSpecialist
      String? userIdLogin = await AuthManager.getUserId();
      return userIdLogin;
    } catch (e) {
      print("error in user ID");
    }
    return null;
  }
}
