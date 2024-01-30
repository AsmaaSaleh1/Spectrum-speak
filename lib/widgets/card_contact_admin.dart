import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/modules/ContactUs.dart';
import 'package:spectrum_speak/rest/rest_api_contact.dart';
import 'package:spectrum_speak/units/custom_button.dart';

class CardContactUsAdmin extends StatelessWidget {
  final Contact contact;
  final VoidCallback onDonePressed;

  const CardContactUsAdmin({
    super.key,
    required this.contact,
    required this.onDonePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(19.0),
      child: Container(
        width: 400,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.circleUser,
                          size: 27.0,
                          color: kDarkerColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          toBeginningOfSentenceCase(contact.userName) ?? "",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: kDarkerColor,
                          ),
                        ),
                      ],
                    ),
                    CustomButton(
                      foregroundColor: kPrimary,
                      backgroundColor: kBlue,
                      onPressed: () async {
                        await contactUsDone(
                          contact.contactID,
                        );
                        onDonePressed();
                      },
                      buttonText: "  Done",
                      icon: Icon(
                        Icons.done_all,
                        size: 20,
                      ),
                      iconColor: kDarkerColor,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(2.0),
                child: Text(
                  contact.contact,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: kDarkBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      // Display the date
                      DateFormat('yyyy-MM-dd')
                          .format(DateTime.parse(contact.dateTime.toString())),
                      style: TextStyle(
                        fontSize: 14.0,
                        color: kGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      // Display the time
                      DateFormat('HH:mm')
                          .format(DateTime.parse(contact.dateTime.toString())),
                      style: TextStyle(
                        fontSize: 14.0,
                        color: kRed,
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
