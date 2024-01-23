import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/modules/center.dart';
import 'package:spectrum_speak/rest/rest_api_center.dart';
import 'package:tuple/tuple.dart';

class CenterInformation extends StatefulWidget {
  final String userId;
  const CenterInformation({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  _CenterInformationState createState() => _CenterInformationState();
}

class _CenterInformationState extends State<CenterInformation> {
  bool isMore = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double screenWidth = constraints.maxWidth;
        // Define different padding values based on the screen width.
        EdgeInsets contentPadding;
        if (screenWidth >= 1200) {
          contentPadding = const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 110.0,
          );
        } else if (screenWidth >= 800) {
          contentPadding = const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 70.0,
          );
        } else {
          contentPadding = const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20.0,
          );
        }
        return FutureBuilder<Tuple2<CenterAutism?, dynamic>>(
          future: _getCenter(),
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
              CenterAutism? center = snapshot.data!.item1;
              String admin = snapshot.data!.item2.toString();
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
                              AboutSection(center: center!),
                              const SizedBox(height: 10),
                              Text(
                                "Center Information",
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
                                          FontAwesomeIcons.buildingUser,
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
                                          FontAwesomeIcons.userDoctor,
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
                                          "Center Name",
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
                                          "Specialist Admin",
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
                                          center.centerName,
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
                                          center.city,
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
                                          admin,
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
                              const SizedBox(
                                height: 10,
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
                                          height: 15.0,
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
                                          center.email,
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
                                          center.phone,
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
          },
        );
      },
    );
  }

  Future<Tuple2<CenterAutism?, dynamic>> _getCenter() async {
    try {
      print('UserId: ${widget.userId}');
      String spID = '${await getSpecialistAdminUserIDForCenter(widget.userId)}';
      print('spID $spID');
      var result = await profileCenter(
          spID); //this has to be Specialist id not center id
      print('result======$result');
      dynamic admin = await getSpecialistAdminForCenter(widget.userId);
      print(admin);
      return Tuple2(result, admin);
    } catch (error) {
      print('Error in _getCenter: $error');
      return Tuple2(null, null);
    }
  }
}

class AboutSection extends StatefulWidget {
  final CenterAutism center;

  const AboutSection({Key? key, required this.center}) : super(key: key);

  @override
  _AboutSectionState createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  bool isMore = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "About",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: kDarkerColor,
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isMore = !isMore;
            });
          },
          child: isMore
              ? Text(
                  widget.center.description,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: kDarkerColor,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : Text(
                  widget.center.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: kDarkerColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
