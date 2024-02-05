import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/constant/utils.dart';
import 'package:spectrum_speak/screen/shadow_teacher_profile.dart';
import 'package:spectrum_speak/units/custom_clipper_shadow_teacher.dart';

class CardShadowTeacher extends StatefulWidget {
  final String userId;
  final Color cardColor;
  final String teacherName;
  final String academicQualification;
  final String city;
  final String gender;
  final String availability;
  const CardShadowTeacher({
    super.key,
    required this.userId,
    this.cardColor = kDarkBlue,
    required this.teacherName,
    required this.academicQualification,
    required this.city,
    required this.gender,
    required this.availability,
  });

  @override
  State<CardShadowTeacher> createState() => _CardShadowTeacherState();
}

class _CardShadowTeacherState extends State<CardShadowTeacher> {
  String image = '';
  Future<void> getImage() async {
    image = (await Utils.fetchUser(widget.userId)).image;
    setState(() {
      image = image;
    });
  }

  @override
  initState() {
    super.initState();
    getImage();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mq=MediaQuery.of(context);
    bool isTeacherAvailable;
    if (widget.availability == "Available") {
      isTeacherAvailable = true;
    } else {
      isTeacherAvailable = false;
    }
    return Padding(
      padding: const EdgeInsets.all(19.0),
      child: Container(
        width: 300,
        height: 400,//was 380
        decoration: BoxDecoration(
          color: kPrimary,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: kDarkerColor.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 6,
              offset: const Offset(7, 7),
            ),
          ],
        ),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, top: 10, right: 10, bottom: 40),
              child: ClipPath(
                clipper: CustomClipperShadowTeacher(),
                child: Container(
                  color: widget.cardColor,
                  width: 300,
                  height: 350,
                ),
              ),
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 10,
                    ),
                    child: Container(
                      width: 120, // Adjust the width as needed
                      height: 120, // Adjust the height as needed
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
                        radius: 60.0,
                        child: CachedNetworkImage(
                          width: mq.size.height * .1,
                          height: mq.size.height * .1,
                          imageUrl: image,
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
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  child: Text(
                    widget.teacherName,
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w900,
                      color: kDarkerColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        FontAwesomeIcons.graduationCap,
                        size: 15.0,
                        color: kDarkerColor,
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        widget.academicQualification,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: kDarkerColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        FontAwesomeIcons.locationDot,
                        size: 15.0,
                        color: kDarkerColor,
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        widget.city,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: kDarkerColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        FontAwesomeIcons.venusMars,
                        size: 15.0,
                        color: kDarkerColor,
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        widget.gender,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: kDarkerColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isTeacherAvailable
                            ? CupertinoIcons.checkmark_circle_fill
                            : CupertinoIcons.clear_circled_solid,
                        size: 17.0,
                        color: isTeacherAvailable ? kGreen : kRed,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        widget.availability,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: kDarkerColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 10, top: 10, bottom: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShadowTeacherProfile(
                                  userId: widget.userId,
                                ),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                "Show More",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700,
                                  color: kDarkerColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ShadowTeacherProfile(
                                        userId: widget.userId,
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  FontAwesomeIcons.anglesRight,
                                  size: 14,
                                  color: widget.cardColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
