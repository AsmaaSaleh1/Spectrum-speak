import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/constant/utils.dart';
import 'package:spectrum_speak/modules/CenterUser.dart';
import 'package:spectrum_speak/rest/rest_api_center.dart';
import 'package:spectrum_speak/screen/center_profile.dart';
import 'package:spectrum_speak/units/custom_clipper_center_card.dart';

class CenterCard extends StatefulWidget {
  final String userId;
  final Color cardColor;
  final String about;
  final String centerName;
  final String city;
  final VoidCallback onTap;
  final bool isLess;
  const CenterCard({
    super.key,
    required this.userId,
    this.cardColor = kDarkBlue,
    required this.about,
    required this.centerName,
    required this.city,
    required this.onTap,
    required this.isLess,
  });

  @override
  State<CenterCard> createState() => _CenterCardState();
}

class _CenterCardState extends State<CenterCard> {
  String url = '';
  Future<void> assignUrl() async {
    String centerID = (await getCenterIdForSpecialist(widget.userId))!;
    CenterUser c = await Utils.fetchCenter(centerID);
    await (url = c.image);
    setState(() {
      url = url;
    });
  }

  @override
  initState() {
    super.initState();
    assignUrl();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.all(19.0),
      child: Container(
        width: 300,
        height: 400,
        decoration: BoxDecoration(
          color: kPrimary,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: widget.cardColor.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: <Widget>[
            ClipPath(
              clipper: CustomClipperCard(),
              child: Container(
                color: widget.cardColor,
              ),
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: CircularProfileAvatar(
                      '',
                      borderWidth: 3.0,
                      borderColor: kDarkerBlue,
                      backgroundColor: kPrimary,
                      radius: 70.0,
                      child: CachedNetworkImage(
                        width: mq.size.height * .1,
                        height: mq.size.height * .1,
                        imageUrl: url,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit:
                                  BoxFit.cover, // Set the fit property to cover
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
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    widget.centerName,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w900,
                      color: kDarkerColor,
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
                        widget.city,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 2, bottom: 2),
                      child: AboutSection(
                        about: widget.about,
                      )),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 10, top: 2, bottom: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CenterProfile(
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
                                      builder: (context) => CenterProfile(
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

class AboutSection extends StatefulWidget {
  final String about;
  const AboutSection({
    Key? key,
    required this.about,
  }) : super(key: key);

  @override
  _AboutSectionState createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  bool isMore = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "About",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
            color: kDarkerColor,
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isMore = !isMore;
            });
          },
          child: isMore
              ? Text(
                  widget.about,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: kDarkerColor,
                    fontWeight: FontWeight.w500,
                  ),
                )
              : Text(
                  widget.about,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: kDarkerColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ),
      ],
    );
  }
}
