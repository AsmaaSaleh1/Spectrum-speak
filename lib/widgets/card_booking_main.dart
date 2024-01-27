import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/modules/Booking.dart';

class CardBooking extends StatelessWidget {
  final Booking booking;
  final String category;
  const CardBooking({
    super.key,
    required this.booking,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(19.0),
      child: Container(
        width: 300,
        height: 170,
        decoration: BoxDecoration(
          color: kPrimary,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: kDarkBlue.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: 100, // Adjust the width as needed
                        height: 100, // Adjust the height as needed
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: kDarkBlue.withOpacity(0.5),
                              blurRadius: 8.0, // Blur radius
                              spreadRadius: 2.0, // Spread radius
                              offset: const Offset(-5, 5),
                            ),
                          ],
                        ),
                        child: CircularProfileAvatar(
                          '',
                          borderWidth: 1.0,
                          radius: 50.0,
                          child: Image.asset(
                              'images/prof.png'), //TODO: category == "Specialist"?booking.parentImageUrl:booking.specialistImageUrl;
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 25.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 3,
                          top: 5,
                          bottom: 3,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.userLarge,
                              size: 15.0,
                              color: kDarkerColor,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              toBeginningOfSentenceCase(category == "Specialist"
                                      ? booking.parentName
                                      : booking.specialistName) ??
                                  "",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: kDarkerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.child,
                              size: 15.0,
                              color: kRed,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              booking.childName,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: kRed,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.calendar,
                              size: 15.0,
                              color: kGreen,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              // Display the date
                              DateFormat('yyyy-MM-dd').format(
                                  DateTime.parse(booking.time.toString())),
                              style: TextStyle(
                                fontSize: 14.0,
                                color: kGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.clock,
                              size: 15.0,
                              color: kYellow.withGreen(180),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              // Display the time
                              DateFormat('HH:mm').format(
                                  DateTime.parse(booking.time.toString())),
                              style: TextStyle(
                                fontSize: 14.0,
                                color: kYellow.withGreen(180),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.userDoctor,
                              size: 15.0,
                              color: kBlue,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              booking.description,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: kBlue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
