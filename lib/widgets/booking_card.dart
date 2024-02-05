import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/modules/Booking.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/modules/Dialogs.dart';
import 'package:spectrum_speak/modules/my_date_util.dart';
import 'package:spectrum_speak/rest/rest_api_booking.dart';
import 'package:spectrum_speak/rest/rest_api_profile.dart';
import 'package:spectrum_speak/screen/calendar_grid.dart';

class BookingCard extends StatefulWidget {
  final Booking booking;
  final String category;
  late String? history;
  late VoidCallback? onDelete; // Add this line
  BookingCard(
      {Key? key,
      required this.booking,
      required this.category,
      this.history,
      this.onDelete});

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('event card');
    String bookingMessage = (widget.category == 'Parent')
        ? '${widget.booking.childName} scheduled for a ${widget.booking.description} on this day'
        : 'You are scheduled for a ${widget.booking.description} session with ${widget.booking.childName} on this day';
    if (widget.history == 'Child') {
      bookingMessage =
          '${widget.booking.description} session on this day with ${widget.booking.specialistName}';
    }
    MediaQueryData mq = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.all(19.0),
      child: Container(
        width: 350,
        height: widget.history=='Child'?235:280,
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
                Visibility(
                  visible:widget.history!='Child',
                  child: Align(
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
                              imageUrl: widget.category == 'Parent'
                                  ? widget.booking.parentImageUrl
                                  : widget.booking.specialistImageUrl,
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
                          '${widget.booking.description}',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: kDarkerBlue,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: widget.category == 'Specialist',
                        child: Padding(
                          padding: EdgeInsets.only(top: 3.0, left: 8),
                          child: Row(
                            children: [
                              Icon(CupertinoIcons.person_2_alt,
                                  color: kRed, size: 20),
                              Text(
                                widget.booking.parentName,
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
                            Icon(
                                widget.category == 'Parent'
                                    ? FontAwesomeIcons.userDoctor
                                    : FontAwesomeIcons.childReaching,
                                color: kRed,
                                size: 20),
                            Text(
                              widget.category == 'Parent'
                                  ? '${widget.booking.specialistName}'
                                  : '${widget.booking.childName}',
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
                              ' ${widget.booking.time.day}-${widget.booking.time.month}',
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
                              '${MyDateUtil.formatDateTime(widget.booking.time)}',
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
                PopupMenuButton<String>(
                  color: kPrimary,
                  icon: Icon(
                    Icons.more_vert,
                    color: kDarkerColor,
                  ),
                  onSelected: (String value) async {
                    // if (value == 'Edit') {
                    //   Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (_) =>
                    //             EditChildCard(childId: childId)),
                    //   );
                    // } else if (value == 'Delete') {
                    //   // Handle delete logic
                    //   showDeleteConfirmationDialog(context);
                    // }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'Delete',
                      child: Text('Delete'),
                      onTap: () async {
                        await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: kDarkerBlue,
                                title: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.warning_amber,
                                        color: kYellow,
                                        size: 40,
                                      ),
                                      Text('Warning',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: kPrimary,
                                              fontSize: 30)),
                                    ]),
                                content: Text(
                                    'Are you sure you want to delete your booking with ${widget.category == 'Parent' ? widget.booking.specialistName : widget.booking.childName}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 21,
                                        color: kPrimary)),
                                actions: [
                                  TextButton(
                                      onPressed: () async {
                                        await deleteBooking(
                                            widget.booking.bookingID);
                                        Navigator.of(context).pop(true);
                                        widget.onDelete!();
                                        Dialogs.showSnackbar(context,
                                            'Session booking has been deleted successfully');
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: kPrimary,
                                          side: BorderSide(width: 1.0),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      child: Text('Yes',
                                          style: TextStyle(
                                              color: kDarkerColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 17))),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: kPrimary,
                                          side: BorderSide(width: 1.0),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      child: Text('Cancel',
                                          style: TextStyle(
                                              color: kDarkerColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 17))),
                                ],
                              );
                            });
                      },
                    ),
                    // Add more PopupMenuItems as needed
                  ],
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: EdgeInsets.only(top: 10.0, left: 2),
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
