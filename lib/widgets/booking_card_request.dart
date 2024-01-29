import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/modules/Booking.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/modules/BookingNotification.dart';
import 'package:spectrum_speak/modules/Dialogs.dart';
import 'package:spectrum_speak/modules/my_date_util.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/rest/rest_api_booking.dart';
import 'package:spectrum_speak/rest/rest_api_profile.dart';
import 'package:spectrum_speak/screen/calendar_grid.dart';

class BookingCardRequest extends StatefulWidget {
  final BookingNotification booking;
  const BookingCardRequest({
    Key? key,
    required this.booking,
  });

  @override
  State<BookingCardRequest> createState() => _BookingCardRequestState();
}

class _BookingCardRequestState extends State<BookingCardRequest> {
  List<Booking> b = [];
  int index = 0;
  @override
  initState() {
    super.initState();
  }

  Future<void> initData() async {
    b = await getBookings(AuthManager.u.UserID.toString(), 'Specialist');
    for (int i = 0; i < b.length; i++) {
      if (b[i].time == widget.booking.timeSent &&
          AuthManager.u.UserID == widget.booking.toID) {
        index = i;
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print('event card');
    String bookingMessage =
        'A request has been made by ${b[index].parentName} for a session';
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      width: 110, // Adjust the width as needed
                      height: 110, // Adjust the height as needed
                      child: Container(
                        margin: EdgeInsets.all(8.0),
                        child: CircularProfileAvatar(
                          '',
                          radius: 110,
                          borderWidth: 3,
                          borderColor: kDarkBlue,
                          child: CachedNetworkImage(
                            width: mq.size.width * .4,
                            height: mq.size.width * .4,
                            imageUrl:b[index].specialistImageUrl,
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
                          'Session Request',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: kDarkerBlue,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: true,
                        child: Padding(
                          padding: EdgeInsets.only(top: 3.0, left: 8),
                          child: Row(
                            children: [
                              Icon(CupertinoIcons.person_2_alt,
                                  color: kRed, size: 20),
                              Text(
                                b[index].parentName,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: kRed,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 3.0, left: 8),
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.childReaching,
                                color: kRed,
                                size: 20),
                            Text('${b[index].childName}',
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
                              ' ${b[index].time.day}-${b[index].time.month}',
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
                              '${MyDateUtil.formatDateTime(b[index].time)}',
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
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: EdgeInsets.only(top: 20.0, left: 2),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth:
                        mq.size.width * 0.8, // Adjust the maxWidth as needed
                  ),
                  child: Text(
                    textAlign: TextAlign.center,
                    bookingMessage,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: kDarkBlue,
                    ),
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
