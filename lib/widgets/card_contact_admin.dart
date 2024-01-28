import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/modules/ContactUs.dart';

class CardContactUsAdmin extends StatelessWidget {
  final Contact contact;
  const CardContactUsAdmin({
    super.key,
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(19.0),
      child: Container(
        width: 400,
        height: 200,
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
          padding: const EdgeInsets.all(20.0),
          child: Column(
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
                      toBeginningOfSentenceCase(contact.userName) ??
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
                      contact.contact,
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
                          DateTime.parse(contact.dateTime.toString())),
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
                          DateTime.parse(contact.dateTime.toString())),
                      style: TextStyle(
                        fontSize: 14.0,
                        color: kYellow.withGreen(180),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
