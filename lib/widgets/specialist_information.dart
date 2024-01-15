import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/modules/specialist.dart';
import 'package:spectrum_speak/rest/rest_api_center.dart';
import 'package:spectrum_speak/rest/rest_api_profile.dart';
import 'package:spectrum_speak/screen/sign_up_specialist.dart';
import 'package:tuple/tuple.dart';

class SpecialistInformation extends StatelessWidget {
  final String userId;
  const SpecialistInformation({
    super.key,
    required this.userId,
  });

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
          return FutureBuilder<Tuple2<Specialist?, String>>(
              future: _getSpecialist(context),
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
                  Specialist? specialist = snapshot.data!.item1;
                  String workCenter = snapshot.data!.item2.toString();
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
                                              FontAwesomeIcons.buildingUser,
                                              size: 15.0,
                                              color: kDarkerColor,
                                            ),
                                            const SizedBox(
                                              height: 15.0,
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
                                            Row(
                                              children: [
                                                Text(
                                                  "Price ",
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: kDarkerColor,
                                                  ),
                                                ),
                                                const SizedBox(width: 5,),
                                                Text(
                                                  "(for one session)",
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
                                      Padding(
                                        padding: const EdgeInsets.all(7.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              specialist!.userName,
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
                                              workCenter,
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
  Future<Tuple2<Specialist?, String>> _getSpecialist(
      BuildContext context) async {
    try {
      // Check if userId is not null before calling profileShadowTeacher
      var result = await profileSpecialist(userId);
      // Check if result is null or if specialist sign-up is not complete
      if (result == null) {
        var check = await checkSpecialistSignUpComplete(userId);
        if (!check!) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SignUpSpecialist(),
            ),
          );
        } else {
          print("error in checker specialist");
        }
      }
      String centerName = await getCenterName(result!.centerID);
      return Tuple2(result, centerName);
    } catch (error) {
      // Handle errors here
      print('Error in _getSpecialist: $error');
      return Tuple2(null, "");
    }
  }
}
