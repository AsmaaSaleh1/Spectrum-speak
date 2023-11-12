import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/const.dart';
import 'package:spectrum_speak/screen/edit_center_profile.dart';
import 'package:spectrum_speak/units/custom_button.dart';
import 'package:spectrum_speak/units/custom_clipper.dart';

class StackContainerCenter extends StatelessWidget {
  const StackContainerCenter({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.0,
      child: Stack(
        children: <Widget>[
          Container(),
          ClipPath(
            clipper: MyCustomClipper(),
            child: Container(
              height: 300.0,
              color: kDarkBlue,
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 250, // Adjust the width as needed
                  height: 140, // Adjust the height as needed
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(
                        color: kDarkBlue,
                        blurRadius: 5.0, // Blur radius
                        spreadRadius: 5.0, // Spread radius
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                  child: Image.asset('images/center.jpg'),
                ),
                const SizedBox(height: 10.0),
                Text(
                  "Center Name",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: kDarkerColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        FontAwesomeIcons.locationDot,
                        size: 15.0,
                        color: kRed,
                      ),
                      Text(
                        "Location",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      foregroundColor: kDarkerColor,
                      backgroundColor: kBlue,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const EditCenterProfile()),
                        );
                      },
                      buttonText: 'Edit Profile',
                      icon: const Icon(
                        Icons.edit,
                        size: 18.0,
                      ),
                      iconColor: kPrimary,
                    ),
                    const SizedBox(width: 20,),
                    CustomButton(
                      foregroundColor: kDarkerColor,
                      backgroundColor: kBlue,
                      onPressed: () {
                        //TODO: Add Specialist For Center
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => const EditProfile()),
                        // );
                      },
                      buttonText: 'Add Specialist',
                      icon: const Icon(
                        Icons.add_circle_outline,
                        size: 18.0,
                      ),
                      iconColor: kPrimary,
                    ),
                  ],
                ),
                //TODO: Hide the two buttons if there is anyone who is not a specialist who has set up the center
              ],
            ),
          ),
        ],
      ),
    );
  }
}
