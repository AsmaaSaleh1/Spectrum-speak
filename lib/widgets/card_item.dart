import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/rest/rest_api_profile_delete.dart';
import 'package:spectrum_speak/screen/edit_child_card.dart';
import 'package:spectrum_speak/screen/parent_profile.dart';

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
                        toBeginningOfSentenceCase(userName)??"",
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
              child: PopupMenuButton<String>(
                color: kPrimary,
                icon: Icon(
                  Icons.more_vert,
                  color: kDarkerColor,
                ),
                onSelected: (String value) async {
                  if (value == 'Edit') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => EditChildCard(childId: childId)),
                    );
                  } else if (value == 'Delete') {
                    // Handle delete logic
                    showDeleteConfirmationDialog(context);
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'Edit',
                    child: Text('Edit'),
                  ),
                  PopupMenuItem<String>(
                    value: 'Delete',
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
  Future<void> showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to delete this child?'
              'This action cannot be undone.'),
          icon: Icon(Icons.warning_amber,size: 45,color: kYellow,),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Perform delete logic
                await deleteChild(childId);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => ParentProfile()),
                );
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
