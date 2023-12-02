import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/modules/shadow_teacher.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/rest/rest_api.dart';

//TODO: make it suitable at all width size (like I make in About in CenterProfile) specially Academic Qualification
class ShadowTeacherInformation extends StatelessWidget {
  const ShadowTeacherInformation({super.key});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Define different padding values based on the screen width.
    EdgeInsets contentPadding;
    if (screenWidth >= 1200) {
      contentPadding =
          const EdgeInsets.symmetric(vertical: 20, horizontal: 110.0);
    } else if (screenWidth >= 800) {
      contentPadding =
          const EdgeInsets.symmetric(vertical: 20, horizontal: 70.0);
    } else {
      contentPadding =
          const EdgeInsets.symmetric(vertical: 20, horizontal: 20.0);
    }
    return FutureBuilder<ShadowTeacher?>(
        future: _getShadowTeacher(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // You can return a loading indicator here if needed
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Handle the error
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            // Build your UI with the fetched data
            ShadowTeacher shadowTeacher = snapshot.data!;
            bool isTeacherAvailable;
            if (shadowTeacher.availability == "Available") {
              isTeacherAvailable = true;
            } else {
              isTeacherAvailable = false;
            }
            return Padding(
              padding: contentPadding,
              child: IntrinsicHeight(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: kPrimary,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: kDarkerColor,
                        spreadRadius: 2,
                        //blurRadius: 10,
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
                                    FontAwesomeIcons.personChalkboard,
                                    size: 15.0,
                                    color: kDarkerColor,
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  Icon(
                                    FontAwesomeIcons.graduationCap,
                                    size: 15.0,
                                    color: kDarkerColor,
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  Icon(
                                    FontAwesomeIcons.venusMars,
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
                                    FontAwesomeIcons.cakeCandles,
                                    size: 15.0,
                                    color: kDarkerColor,
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  Icon(
                                    FontAwesomeIcons.circleQuestion,
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
                                    "Teacher Name",
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
                                    "Academic Qualification",
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
                                    "Gender",
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
                                    "Age",
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
                                    "Availability",
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
                                    shadowTeacher.userName,
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
                                    shadowTeacher.qualification,
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
                                    shadowTeacher.gender,
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
                                    shadowTeacher.city,
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
                                    shadowTeacher.birthDate,
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
                                    shadowTeacher.availability,
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
                                    shadowTeacher.email,
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
                                    shadowTeacher.phone,
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
              ),
            );
          } else {
            // Return a default UI if no data is available
            return const Text('No data available');
          }
        });
  }

  Future<ShadowTeacher?> _getShadowTeacher() async {
    try {
      String? userId = await AuthManager.getUserId();
      print('UserId: $userId');

      // Check if userId is not null before calling profileShadowTeacher
      if (userId != null) {
        var result = await profileShadowTeacher(userId);
        print('Profile result: $result');
        return result;
      } else {
        print('UserId is null');
        return null;
      }
    } catch (error) {
      // Handle errors here
      print('Error in _getShadowTeacher: $error');
      return null;
    }
  }
}
