import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/constant/utils.dart';
import 'package:spectrum_speak/modules/Booking.dart';
import 'package:spectrum_speak/modules/BookingNotification.dart';
import 'package:spectrum_speak/modules/ChatUser.dart';
import 'package:spectrum_speak/modules/my_date_util.dart';
import 'package:spectrum_speak/modules/specialist.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/rest/rest_api_booking.dart';
import 'package:spectrum_speak/rest/rest_api_profile.dart';
// import 'package:spectrum_speak/screen/calendar_specialist.dart';
import 'package:spectrum_speak/screen/offers_and_requests.dart';
import 'package:spectrum_speak/widgets/top_bar.dart';

class BookingNotificationCard extends StatefulWidget {
  late BookingNotification bn;
  late Function(int)? callBack;
  BookingNotificationCard({Key? key, required this.bn, this.callBack})
      : super(key: key);

  @override
  _BookingNotificationCardState createState() =>
      _BookingNotificationCardState();
}

class _BookingNotificationCardState extends State<BookingNotificationCard> {
  late MediaQueryData mq; // Declare MediaQueryData variable
  String title = '';
  String subtitle = '';
  ChatUser user = new ChatUser();
  bool read = false;
  int index = 0;
  bool visible = true;
  List<Booking> b = [];
  String decision = '';
  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    user = await Utils.fetchUser(widget.bn.fromID!);
    if (widget.bn.type == 'request') {
      title =
          '${user.Name} has requested a session on ${widget.bn.timeOfBooking!.split(':')[0]}:${widget.bn.timeOfBooking!.split(':')[1]}!';
      if ((await Utils.fetchBooking(widget.bn.fromID!, widget.bn.toID!))
              .item1 ==
          'Yes') {
        print('there\'s a response');
        BookingNotification t =
            (await Utils.fetchBooking(widget.bn.fromID!, widget.bn.toID!))
                .item2;
        setState(() {
          decision = t.value! ? 'accept' : 'reject';
          visible = false;
        });
      } else {}
    } else if (widget.bn.type == 'response') {
      title = widget.bn.value!
          ? '${user.Name} has approved your booking request!'
          : '${user.Name} has declined your booking request';
    }
    read = widget.bn.read!;
    subtitle = '${MyDateUtil.timeAgo(widget.bn.timeSent!)}';
    print(title);
    print(subtitle);
    print('from ${widget.bn.fromID} to ${widget.bn.toID}');
    print('\n');
    // Ensure the widget is mounted before calling setState
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);

    // Use the title, trailing, and other data in your widget
    // return Text('MMM');
    // The rest of your widget code...
    return PopScope(
      onPopInvoked: (didPop) async {
        print('card popped');
        unreadBookingCount = await Utils.getUnreadBookingNotifications(
            AuthManager.u.UserID.toString());
        widget.callBack!(unreadBookingCount);
      },
      child: Card(
        elevation: 3,
        shadowColor: kDarkerColor,
        color: kPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: InkWell(
            onTap: () async {
              await Utils.updateBookingNotificationReadStatus(widget.bn, true);
              unreadBookingCount = await Utils.getUnreadBookingNotifications(
                  AuthManager.u.UserID.toString());
              setState(() {
                read = true;
              });
              // if (widget.bn.type == 'request') {
              //   Utils.retrieveBookingRequestValue(widget.bn);
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (_) => CalendarPageSpecialist(
              //                 category:'Specialist',
              //               )));
              // } else {
              //   // Utils.retrieveOfferResponseValue(widget.cn);
              // }
            },
            child: Column(
              children: [
                ListTile(
                    leading: CircularProfileAvatar(
                      '',
                      borderWidth: 1.0,
                      borderColor: kDarkerColor,
                      backgroundColor: kPrimary,
                      radius: 25.0,
                      child: CachedNetworkImage(
                        width: mq.size.height * .05,
                        height: mq.size.height * .05,
                        imageUrl: user.image,
                        errorWidget: (context, url, error) =>
                            const CircleAvatar(
                                child: Icon(CupertinoIcons.person)),
                      ),
                    ),
                    title: Text(
                      title,
                      maxLines: 3,
                      style: TextStyle(color: kDarkerColor),
                    ),
                    subtitle: Text(subtitle,
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold)),
                    trailing: !read
                        ?
                        //unread notification
                        Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                                color: kDarkerBlue,
                                borderRadius: BorderRadius.circular(10)),
                          )
                        : null),
                Visibility(
                  visible: visible && widget.bn.type == 'request',
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () async {
                              BookingNotification b = BookingNotification();
                              b.toID = widget.bn.fromID;
                              b.fromID = widget.bn.toID;
                              b.timeSent = MyDateUtil.getCurrentDateTime();
                              b.type = 'response';
                              b.read = false;
                              b.value = true;
                              b.childID = widget.bn.childID;
                              b.childName = widget.bn.childName;
                              b.timeOfBooking = widget.bn.timeOfBooking;
                              await Utils.addBookingNotification(b);
                              await Utils.setBookingRequestCompleted(b);
                              Specialist? s =
                                  await profileSpecialist(b.fromID!);
                              await addBooking(
                                  b.toID!,
                                  b.childID!,
                                  b.fromID!,
                                  s!.specialistCategory,
                                  b.timeOfBooking.toString());
                              setState(() {
                                widget.bn.value = true;
                                decision = 'accept';
                                visible = false;
                              });
                            },
                            icon: Icon(FontAwesomeIcons.check, color: kGreen)),
                        IconButton(
                            onPressed: () async {
                              BookingNotification b = BookingNotification();
                              b.toID = widget.bn.fromID;
                              b.fromID = widget.bn.toID;
                              b.timeSent = MyDateUtil.getCurrentDateTime();
                              b.type = 'response';
                              b.value = false;
                              b.read = false;
                              b.childID = widget.bn.childID;
                              b.childName = widget.bn.childName;
                              b.timeOfBooking = widget.bn.timeOfBooking;
                              print('${b.fromID} ${b.toID}');
                              await Utils.addBookingNotification(b);
                              await Utils.setBookingRequestCompleted(b);
                              setState(() {
                                widget.bn.value = true;
                                decision = 'reject';
                                visible = false;
                              });
                            },
                            icon: Icon(FontAwesomeIcons.x, color: kRed))
                      ]),
                ),
                Visibility(
                  visible: !visible &&
                      widget.bn.value! &&
                      widget.bn.type == 'request',
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Text(decision == 'accept' ? 'Accepted' : 'Rejected',
                        style: TextStyle(fontSize: 13, color: kDarkerBlue)),
                    Icon(
                        decision == 'accept'
                            ? FontAwesomeIcons.check
                            : FontAwesomeIcons.x,
                        color: decision == 'accept' ? kGreen : kRed),
                  ]),
                )
              ],
            )),
      ),
    );
  }
}
