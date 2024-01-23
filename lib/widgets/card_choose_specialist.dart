import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/constant/utils.dart';
import 'package:spectrum_speak/modules/my_date_util.dart';
import 'package:spectrum_speak/screen/center_profile.dart';
import 'package:spectrum_speak/screen/specialist_profile.dart';

import '../modules/CenterNotification.dart';

class CardChooseSpecialist extends StatefulWidget {
  final String userID;
  final String userName;
  final String specialistCategory;
  const CardChooseSpecialist({
    super.key,
    required this.userID,
    required this.userName,
    required this.specialistCategory,
  });

  @override
  State<CardChooseSpecialist> createState() => _CardChooseSpecialistState();
}

class _CardChooseSpecialistState extends State<CardChooseSpecialist> {
  bool isButtonPressed = false;
  bool _hasRequestBeenMade = false;
  Future<void> initButton() async {
    bool r =
        await Utils.checkIfRequestHasBeenMade(widget.userID, globalCenterID);
    setState(() {
      _hasRequestBeenMade = r;
      if (_hasRequestBeenMade) isButtonPressed = true;
    });
    print(
        'bool value is $_hasRequestBeenMade\nButton pressed value is $isButtonPressed');
  }

  @override
  initState() {
    super.initState();
    initButton();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: kDarkerColor,
      color: kPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SpecialistProfile(
                userId: widget.userID,
              ),
            ),
          );
        },
        child: ListTile(
          leading: CircularProfileAvatar(
            '',
            borderWidth: 1.0,
            borderColor: kDarkerColor,
            backgroundColor: kPrimary,
            radius: 25.0,
            child: Image.asset(
              'images/prof.png',
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            widget.userName,
            style: TextStyle(
              color: kDarkerColor,
            ),
          ),
          subtitle: Text(
            widget.specialistCategory,
            maxLines: 1,
          ),
          trailing: ElevatedButton.icon(
            onPressed: () async {
              _hasRequestBeenMade = await Utils.checkIfRequestHasBeenMade(
                  widget.userID, globalCenterID);
              setState(() {
                // Toggle the button state
                if (!isButtonPressed) isButtonPressed = !isButtonPressed;
              });
              if (isButtonPressed && !_hasRequestBeenMade) {
                CenterNotification cn = CenterNotification(
                    fromID: globalCenterID,
                    time: MyDateUtil.getCurrentDateTime(),
                    toID: widget.userID,
                    read: false,
                    type: "request",
                    value: false);
                print('center id $globalCenterID');
                Utils.storeCenterNotification(cn);
              } else if (isButtonPressed && _hasRequestBeenMade) {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: kDarkerBlue,
                        title: Row(mainAxisAlignment:MainAxisAlignment.center,
                        children:[Icon(Icons.warning_amber,color: kYellow,size: 40,),
                        Text('Warning',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: kPrimary,fontSize:30)),]),
                        content: Text(
                            'You\'re going to cancel your offer for ${widget.userName}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 21,
                                color: kPrimary)),
                        actions: [
                          TextButton(
                              onPressed: () {
                                CenterNotification cn = new CenterNotification(
                                    fromID: globalCenterID,
                                    toID: widget.userID);
                                Utils.deleteCenterNotification(cn);
                                setState(() {
                                  isButtonPressed = false;
                                });
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: kPrimary,
                                  side: BorderSide(width: 1.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: Text('Okay',
                                  style: TextStyle(
                                      color: kDarkerColor,
                                      fontWeight: FontWeight.w600,fontSize:17))),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: kPrimary,
                                  side: BorderSide(width: 1.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: Text('Cancel',
                                  style: TextStyle(
                                      color: kDarkerColor,
                                      fontWeight: FontWeight.w600,fontSize:17))),
                        ],
                      );
                    });
              }
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: kPrimary,
              backgroundColor: isButtonPressed ? kGreen : kBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  7,
                ),
              ),
            ),
            icon: Icon(
              isButtonPressed ? Icons.done : Icons.add,
              color: kPrimary,
            ),
            label: Text(
              isButtonPressed ? "Done" : "Add",
              style: TextStyle(
                color: kPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
