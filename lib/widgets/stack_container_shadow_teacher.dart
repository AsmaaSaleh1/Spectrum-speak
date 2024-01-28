import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/constant/utils.dart';
import 'package:spectrum_speak/modules/ChatUser.dart';
import 'package:spectrum_speak/modules/shadow_teacher.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/rest/rest_api_profile.dart';
import 'package:spectrum_speak/screen/edit_shadow_teacher_profile.dart';
import 'package:spectrum_speak/screen/sign_up_shadow_teacher.dart';
import 'package:spectrum_speak/units/custom_button.dart';
import 'package:spectrum_speak/units/custom_clipper.dart';
import 'package:tuple/tuple.dart';

class StackContainerShadowTeacher extends StatefulWidget {
  final String userId;
  StackContainerShadowTeacher({
    super.key,
    required this.userId,
  });

  @override
  State<StackContainerShadowTeacher> createState() => _StackContainerShadowTeacherState();
}

class _StackContainerShadowTeacherState extends State<StackContainerShadowTeacher> {
  String url='';

  Future<void> assignUrl() async {
    ChatUser u = await Utils.fetchUser(widget.userId);
    await(url = u.image);
    setState((){url=url;});
  }
  @override
  initState(){
    super.initState();
    assignUrl();
  }
  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);
    return FutureBuilder<Tuple2<ShadowTeacher?, String?>>(
        future: _getShadowTeacher(context),
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
            ShadowTeacher shadowTeacher = snapshot.data!.item1!;
            String userIdLogin = snapshot.data!.item2!;
            bool isTeacherAvailable;
            if (shadowTeacher.availability == "Available") {
              isTeacherAvailable = true;
            } else {
              isTeacherAvailable = false;
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
                        borderWidth: 1.0,
                        borderColor: kDarkerBlue,
                        backgroundColor: kPrimary,
                        radius: 80.0,
                        child: CachedNetworkImage(
                          width: mq.size.height * .05,
                          height: mq.size.height * .05,
                          imageUrl: url,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit
                                    .cover, // Set the fit property to cover
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const CircleAvatar(
                                  child: Icon(CupertinoIcons.person)),
                        ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          toBeginningOfSentenceCase(shadowTeacher.userName) ??
                              "",
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
                                toBeginningOfSentenceCase(
                                        shadowTeacher.qualification) ??
                                    "",
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
                        Visibility(
                          visible: widget.userId == userIdLogin,
                          child: CustomButton(
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

  Future<Tuple2<ShadowTeacher?, String?>> _getShadowTeacher(
      BuildContext context) async {
    try {
      String? userIdLogin = await AuthManager.getUserId();
      var result = await profileShadowTeacher(widget.userId);
      // Check if result is null or if Shadow Teacher sign-up is not complete
      if (result == null) {
        var check = await checkShadowTeacherSignUpComplete(widget.userId);
        if (!check!) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SignUpShadowTeacher(),
            ),
          );
        } else {
          print("error in checker ShadowTeacher");
        }
      }
      return Tuple2(result, userIdLogin);
    } catch (error) {
      // Handle errors here
      print('Error in _getShadowTeacher: $error');
      return Tuple2(null, null);
    }
  }
}
