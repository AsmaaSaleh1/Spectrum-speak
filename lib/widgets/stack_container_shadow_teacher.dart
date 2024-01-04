import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/modules/shadow_teacher.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/rest/rest_api_signUp.dart';
import 'package:spectrum_speak/rest/rest_api_profile.dart';
import 'package:spectrum_speak/screen/edit_shadow_teacher_profile.dart';
import 'package:spectrum_speak/units/build_profile_image.dart';
import 'package:spectrum_speak/units/custom_button.dart';
import 'package:spectrum_speak/units/custom_clipper.dart';

class StackContainerShadowTeacher extends StatelessWidget {
  const StackContainerShadowTeacher({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ShadowTeacher?>(
        future: _getShadowTeacher(),
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
            ShadowTeacher shadowTeacher = snapshot.data!;
            bool isTeacherAvailable;
            if(shadowTeacher.availability=="Available"){
              isTeacherAvailable=true;
            }else{
              isTeacherAvailable=false;
            }
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
                          //child: ProfileImageDisplay(),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          toBeginningOfSentenceCase(shadowTeacher.userName) ?? "",
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
                                FontAwesomeIcons.graduationCap,
                                size: 15.0,
                                color: kYellow,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                toBeginningOfSentenceCase(shadowTeacher.qualification) ?? "",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isTeacherAvailable
                                    ? CupertinoIcons.checkmark_circle_fill
                                    : CupertinoIcons.clear_circled_solid,
                                size: 15.0,
                                color: isTeacherAvailable ? kGreen : kRed,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                shadowTeacher.availability,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
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
                                shadowTeacher.city,
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
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EditShadowTeacherProfile()),
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
          } else {
            // Return a default UI if no data is available
            return const Text('No data available');
          }
        });
  }

  Future<ShadowTeacher?> _getShadowTeacher() async {
    try {
      String? userId = await AuthManager.getUserId();
      print('UserId: $userId');

      // Check if userId is not null before calling profileShadowTeacher
      if (userId != null) {
        var result = await profileShadowTeacher(userId);
        print('Profile result: $result');
        return result;
      } else {
        print('UserId is null');
        return null;
      }
    } catch (error) {
      // Handle errors here
      print('Error in _getShadowTeacher: $error');
      return null;
    }
  }
}
