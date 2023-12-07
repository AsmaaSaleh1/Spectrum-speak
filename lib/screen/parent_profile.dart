import 'package:flutter/material.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/rest/rest_api.dart';
import 'package:spectrum_speak/units/custom_button.dart';
import 'package:spectrum_speak/widgets/top_bar.dart';
import 'package:spectrum_speak/widgets/card_item.dart';
import 'package:spectrum_speak/widgets/stack_container_parent.dart';
import 'package:spectrum_speak/widgets/parent_information.dart';

import 'add_child.dart';

class ParentProfile extends StatefulWidget {
  const ParentProfile({super.key});

  @override
  State<ParentProfile> createState() => _ParentProfileState();
}

class _ParentProfileState extends State<ParentProfile> {
  bool hideCardItems = true;
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
          return FutureBuilder<int?>(
            future: _getNumOfChildForParent(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // You can return a loading indicator here if needed
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // Handle the error
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                print("data :${snapshot.data}");
                if (snapshot.data == 0) {
                  hideCardItems = false;
                }
                return TopBar(
                  body: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            const StackContainerParent(),
                            const ParentInformation(),
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
                              visible: hideCardItems,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: <Widget>[
                                    CardItem(),
                                    CardItem(),
                                    CardItem(),
                                    CardItem(),
                                    CardItem(),
                                    CardItem(),
                                    // Add more CardItems as needed
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: !hideCardItems,
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
                            Padding(
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
                                kPrimary.withOpacity(0.8),
                                kPrimary.withOpacity(0.5),
                                kPrimary.withOpacity(0.1),
                                kPrimary.withOpacity(0.0)
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
                return Text('No data available');
              }
            },
          );
        },
      );

  Future<int?> _getNumOfChildForParent() async {
    try {
      String? userId = await AuthManager.getUserId();
      if (userId != null) {
        int? numberOfChildren = await countOfChildForParent(userId);
        print(numberOfChildren);
        return numberOfChildren;
      } else {
        print('UserId is null');
        return null;
      }
    } catch (error) {
      print('Error in _getParentData: $error');
      return null;
    }
  }
}
