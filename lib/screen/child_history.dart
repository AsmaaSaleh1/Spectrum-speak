import 'package:flutter/material.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/modules/Booking.dart';
import 'package:spectrum_speak/rest/rest_api_booking.dart';
import 'package:spectrum_speak/widgets/booking_card.dart';

class ChildHistory extends StatefulWidget {
  final String childID;
  const ChildHistory({super.key, required this.childID});

  @override
  State<ChildHistory> createState() => _ChildHistoryState();
}

class _ChildHistoryState extends State<ChildHistory> {
  List<Booking> completedBookings = [];
  List<Booking> incompletedBookings = [];
  @override
  initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    List<Booking> bookings = await getBookings(widget.childID, 'Child');
    for (var b in bookings) {
      bool isFuture = b.time.isAfter(DateTime.now());
      if (isFuture) {
        incompletedBookings.add(b);
      } else {
        completedBookings.add(b);
      }
    }
    print(
        '---------------------------------------------------------------------future');
    for (var b in incompletedBookings) print(b);
    print(
        '---------------------------------------------------------------------past');
    for (var b in completedBookings) print(b);
    setState(() {
      incompletedBookings = incompletedBookings;
      completedBookings = completedBookings;
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: kPrimary,
        appBar: AppBar(
          title: Text('History',
              style: TextStyle(
                  color: kPrimary, fontSize: 30, fontWeight: FontWeight.bold)),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: mq.size.height * 0.05),
            Center(
                child: Text('Upcoming Sessions❓',
                    style: TextStyle(color: kDarkerBlue, fontSize: 26,fontWeight:FontWeight.bold))),
            SizedBox(
              height: mq.size.width * 0.001,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                for (var b in incompletedBookings)
                  BookingCard(booking: b, category: 'Parent', history: 'Child')
              ]),
            ),
            SizedBox(height:mq.size.width*0.01),
            Center(
                child: Text('Completed Sessions✅',
                    style: TextStyle(color: kDarkerBlue, fontSize: 26,fontWeight:FontWeight.bold))),
            SizedBox(
              height: mq.size.width * 0.001,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                for (var b in completedBookings)
                  BookingCard(booking: b, category: 'Parent', history: 'Child')
              ]),
            )
          ],
        ));
  }
}
