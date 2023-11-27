import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/screen/edit_profile.dart';
import 'package:spectrum_speak/units/custom_button.dart';
import 'package:spectrum_speak/units/custom_clipper.dart';

class StackContainerParent extends StatelessWidget {
  const StackContainerParent({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
            alignment: const Alignment(0, 1),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProfileAvatar(
                  '',
                  borderWidth: 4.0,
                  borderColor: kPrimary,
                  radius: 80.0,
                  child: Image.asset('images/prof.png'),
                ),
                const SizedBox(height: 4.0),
                Text(
                  "User Name",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: kDarkerColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    "Category", //Parent, Shadow Teacher, Specialized category( audio and speech ...)
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey[700],
                    ),
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
                const SizedBox(height: 5.0),
                CustomButton(
                  foregroundColor: kDarkerColor,
                  backgroundColor: kBlue,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EditProfile()),
                    );
                  },
                  buttonText: 'Edit Profile',
                  icon: const Icon(
                    Icons.edit,
                    size: 18.0,
                  ),
                  iconColor: kPrimary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
