import 'package:circular_profile_avatar/circular_profile_avatar.dart';
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
  bool isButtonPressed=false;
  bool _hasRequestBeenMade = false;
  Future<void> updateVar() async {
    bool r =
        await Utils.checkIfRequestHasBeenMade(widget.userID, globalCenterID);
    setState(() {
      _hasRequestBeenMade = r;
      if (_hasRequestBeenMade) isButtonPressed = true;
    });
    print('bool value is $_hasRequestBeenMade\nButton pressed value is $isButtonPressed');
  }

  @override
  initState() {
    super.initState();
    updateVar();
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
                isButtonPressed = !isButtonPressed;
              });
              if (isButtonPressed && !_hasRequestBeenMade) {
                CenterNotification cn = CenterNotification(
                    fromID: globalCenterID,
                    time: MyDateUtil.getCurrentDateTime(),
                    toID: widget.userID,
                    read: false,
                    type: "request",
                    value: false);
                Utils.storeCenterNotification(cn);
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
