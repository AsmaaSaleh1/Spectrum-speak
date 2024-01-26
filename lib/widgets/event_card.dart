import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spectrum_speak/modules/Event.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/modules/my_date_util.dart';

class EventCard extends StatelessWidget {
  final Event event;
  const EventCard({Key? key, required this.event});

  @override
  Widget build(BuildContext context) {
    print('event card');
    MediaQueryData mq = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.all(19.0),
      child: Container(
        width: 350,
        height: 300,
        decoration: BoxDecoration(
          color: kPrimary,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: kDarkBlue.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      width: 110, // Adjust the width as needed
                      height: 110, // Adjust the height as needed
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
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: CircularProfileAvatar(
                          '',
                          radius: 110,
                          child: CachedNetworkImage(
                            width: mq.size.height * .4,
                            height: mq.size.height * .4,
                            imageUrl: event.image,
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
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align text to the center
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '${event.centerName} Center',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: kDarkerBlue,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0, left: 5.0),
                        child: Row(
                          children: [
                            Icon(Icons.location_on_outlined,
                                color: kRed, size: 20),
                            Text(
                              ' ${event.city}',
                              style: TextStyle(
                                fontSize: 18,
                                color: kRed,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 3.0, left: 8),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today_rounded,
                                color: kBlue, size: 20),
                            Text(
                              ' ${event.time.day}-${event.time.month}',
                              style: TextStyle(
                                fontSize: 18,
                                color: kBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 3.0, left: 8),
                        child: Row(
                          children: [
                            Icon(Icons.access_time_filled_outlined,
                                color: kYellow, size: 20),
                            Text(
                              '${MyDateUtil.formatDateTime(event.time)}',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 212, 163, 17),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.only(top: 8.0, left: 2),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth:
                        mq.size.width * 0.8, // Adjust the maxWidth as needed
                  ),
                  child: Text(
                    textAlign: TextAlign.center,
                    event.description,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kDarkerBlue,
                    ),
                  ),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
