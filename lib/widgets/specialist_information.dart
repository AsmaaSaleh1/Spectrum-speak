import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/modules/specialist.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/rest/rest_api_signUp.dart';
import 'package:spectrum_speak/rest/rest_api_profile.dart';

class SpecialistInformation extends StatelessWidget {
  const SpecialistInformation({super.key});

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double screenWidth = constraints.maxWidth;

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
          return FutureBuilder<Specialist?>(
              future: _getSpecialist(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // You can return a loading indicator here if needed
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  // Handle the error
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  // Build your UI with the fetched data
                  Specialist specialist = snapshot.data!;
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.userDoctor,
                                              size: 15.0,
                                              color: kDarkerColor,
                                            ),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            Icon(
                                              FontAwesomeIcons.locationDot,
                                              size: 15.0,
                                              color: kDarkerColor,
                                            ),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            Icon(
                                              FontAwesomeIcons.buildingUser,
                                              size: 15.0,
                                              color: kDarkerColor,
                                            ),
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            Icon(
                                              FontAwesomeIcons.sackDollar,
                                              size: 15.0,
                                              color: kDarkerColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(7.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                            //TODO: hide if not work in any center from the application
                                            Text(
                                              "Work Center",
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
                                              "Price for one session",
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              specialist.userName,
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
                                              specialist.city,
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
                                              "Work Center",//TODO
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
                                              specialist.price.toString(),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              specialist.email,
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
                                              specialist.phone,
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
                } else {
                  // Return a default UI if no data is available
                  return const Text('No data available');
                }
              });
        },
      );
  Future<Specialist?> _getSpecialist() async {
    try {
      String? userId = await AuthManager.getUserId();
      print('UserId: $userId');

      // Check if userId is not null before calling profileShadowTeacher
      if (userId != null) {
        var result = await profileSpecialist(userId);
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
