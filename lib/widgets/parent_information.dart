import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/modules/parent.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/rest/rest_api_signUp.dart';
import 'package:spectrum_speak/rest/rest_api_profile.dart';

class ParentInformation extends StatelessWidget {
  const ParentInformation({Key? key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double screenWidth = constraints.maxWidth;

        // Define different padding values based on the screen width.
        EdgeInsets contentPadding;
        if (screenWidth >= 1200) {
          contentPadding = const EdgeInsets.symmetric(vertical: 20, horizontal: 110.0);
        } else if (screenWidth >= 800) {
          contentPadding = const EdgeInsets.symmetric(vertical: 20, horizontal: 70.0);
        } else {
          contentPadding = const EdgeInsets.symmetric(vertical: 20, horizontal: 20.0);
        }
        return FutureBuilder<Map<String, dynamic>?>(
          future: _getParentData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              Parent parent = snapshot.data!['parent'];
              String num = snapshot.data!['numberOfChildren']?.toString() ?? 'N/A';
              return buildParentInformation(context,parent, num, contentPadding);
            } else {
              return const Text('No data available');
            }
          },
        );
      },
    );
  }

  Widget buildParentInformation(BuildContext context,Parent parent, String num, EdgeInsets contentPadding) {
    return Padding(
      padding: contentPadding,
      child: IntrinsicHeight(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: kPrimary,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: kDarkerColor,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Personal Information",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: kDarkerColor,
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.user,
                                size: 15.0,
                                color: kDarkerColor,
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              Icon(
                                FontAwesomeIcons.locationDot,
                                size: 15.0,
                                color: kDarkerColor,
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              Icon(
                                FontAwesomeIcons.children,
                                size: 15.0,
                                color: kDarkerColor,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "User Name",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: kDarkerColor,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "Location",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: kDarkerColor,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "Number Of Children",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: kDarkerColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                parent.userName,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: kDarkerColor,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                parent.city,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: kDarkerColor,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "\t\t\t\t\t\t"+num,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: kDarkerColor,
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                  Text(
                                    "(In the system)",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Contact",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: kDarkerColor,
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.message,
                                size: 15.0,
                                color: kDarkerColor,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Icon(
                                FontAwesomeIcons.phone,
                                size: 15.0,
                                color: kDarkerColor,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: kDarkerColor,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                "Phone",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: kDarkerColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                parent.email,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: kDarkerColor,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                parent.phone,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: kDarkerColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Map<String, dynamic>?> _getParentData() async {
    try {
      String? userId = await AuthManager.getUserId();
      if (userId != null) {
        Parent? parent = await profileParent(userId);
        int? numberOfChildren = await countOfChildForParent(userId);
        String? num = numberOfChildren?.toString();
        return {'parent': parent, 'numberOfChildren': num};
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
