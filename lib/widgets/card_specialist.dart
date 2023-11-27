import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/screen/specialist_profile.dart';
import 'package:spectrum_speak/units/custom_clipper_puzzle.dart';

class CardSpecialist extends StatelessWidget {
  final Color cardColor;

  const CardSpecialist({
    super.key,
    this.cardColor = kDarkBlue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(19.0),
      child: Container(
        width: 300,
        height: 380,
        decoration: BoxDecoration(
          color: kPrimary,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: kDarkerColor.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,bottom: 70),
              child: ClipPath(
                clipper: CustomClipperPuzzle(),
                child: Container(
                  color: cardColor,
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
                      top: 20,bottom: 10,
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
                        child: Image.asset('images/prof.png'),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10,top: 10),
                  child: Text(
                    "Specialized Name",
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
                        FontAwesomeIcons.userDoctor,
                        size: 15.0,
                        color: kDarkerColor,
                      ),
                      const SizedBox(width: 7,),
                      Text(
                        "Category",
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
                      const SizedBox(width: 7,),
                      Text(
                        "Location",
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
                        FontAwesomeIcons.sackDollar,
                        size: 15.0,
                        color: kDarkerColor,
                      ),
                      const SizedBox(width: 7,),
                      Text(
                        "100\$",//Price for one session
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
                        FontAwesomeIcons.buildingUser,
                        size: 15.0,
                        color: kDarkerColor,
                      ),
                      const SizedBox(width: 7,),
                      Text(
                        "Center Name",//If any
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
                      const EdgeInsets.only(right: 10, top: 2, bottom: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SpecialistProfile()),
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
                                      MaterialPageRoute(builder: (context) => const SpecialistProfile()),
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
