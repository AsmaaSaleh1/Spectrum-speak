import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';

import 'package:spectrum_speak/constant/const_color.dart';

class CardItem extends StatelessWidget {
  final String childId;
  final String userName;
  final String gender;
  final String birthDate;
  final String degreeOfAutism;
  const CardItem({
    super.key,
    required this.childId,
    required this.userName,
    required this.gender,
    required this.birthDate,
    required this.degreeOfAutism,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(19.0),
      child: Container(
        width: 300,
        height: 150,
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
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        child: Image.asset('images/prof.png'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 25.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        userName,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: kDarkerColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Text(
                        gender,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: kBlue,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Text(
                        birthDate, //Birth Date
                        style: TextStyle(
                          fontSize: 14.0,
                          color: kRed,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Text(
                        degreeOfAutism, //Birth Date
                        style: TextStyle(
                          fontSize: 14.0,
                          color: kGreen,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: 1,
              right: 1,
              child: PopupMenuButton(
                color: kPrimary,
                icon: Icon(
                  Icons.more_vert,
                  color: kDarkerColor,
                ),
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  PopupMenuItem(
                    child: Text('Edit'),
                  ),
                  PopupMenuItem(
                    child: Text('Delete'),
                  ),
                  // Add more PopupMenuItems as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
