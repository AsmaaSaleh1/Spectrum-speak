import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:spectrum_speak/const.dart';
import 'package:spectrum_speak/screen/center_profile.dart';
import 'package:spectrum_speak/units/custom_clipper_center_card.dart';

class CenterCard extends StatelessWidget {
  final Color cardColor;
  final String about;
  final VoidCallback onTap;
  final bool isLess;
  const CenterCard({
    Key? key,
    this.cardColor = kDarkBlue,
    required this.about,
    required this.onTap,
    required this.isLess,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(19.0),
      child: Container(
        width: 300,
        height: 360,
        decoration: BoxDecoration(
          color: kPrimary,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: cardColor.withOpacity(0.5),
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
                color: cardColor,
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
                    child: Container(
                      width: 250, // Adjust the width as needed
                      height: 130, // Adjust the height as needed
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        boxShadow: [
                          BoxShadow(
                            color: cardColor.withOpacity(0.5),
                            blurRadius: 8.0, // Blur radius
                            spreadRadius: 2.0, // Spread radius
                            offset: const Offset(7, 7),
                          ),
                        ],
                      ),
                      child: Image.asset('images/center.jpg'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    "Center Name",
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
                        "Location",
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
                        left: 20, right: 20, top: 5, bottom: 2),
                    child: Column(
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
                        const SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: onTap,
                          child: isLess
                              ? Text(
                                  about,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: kDarkerColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              : Text(
                                  about,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  //Comment
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: kDarkerColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
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
                                MaterialPageRoute(builder: (context) => const CenterProfile()),
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
                                      MaterialPageRoute(builder: (context) => const CenterProfile()),
                                    );
                                  },
                                  icon: Icon(
                                    FontAwesomeIcons.anglesRight,
                                    size: 14,
                                    color: cardColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
