import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/modules/Booking.dart';
import 'package:spectrum_speak/modules/Event.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/rest/rest_api_center.dart';
import 'package:spectrum_speak/rest/rest_api_booking.dart';
import 'package:spectrum_speak/widgets/booking_card.dart';
import 'package:spectrum_speak/widgets/event_card.dart';
import 'package:spectrum_speak/widgets/top_bar.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

late int indexOfFirstDayMonth = 0;
late int indexOfLastDayMonth = 0;
bool calendarGuide = true;

class CalendarPage extends StatefulWidget {
  final String city;
  final String category;
  const CalendarPage({Key? key, required this.city, required this.category})
      : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime _selectedDate;
  int _selectedIndex = 0;
  List<Event> allEvents = [];
  List<Event> dayEvents = [];
  List<Booking> dayBookings = [];
  List<Booking> allBookings = [];
  TutorialCoachMark? tutorialCoachMark;
  List<TargetFocus>? targets;
  GlobalKey changeMonthKey = GlobalKey();
  GlobalKey viewCalendarKey = GlobalKey();
  void _showTutorialCoachmark() {
    calendarGuide = true;
    _initTarget();
    tutorialCoachMark = TutorialCoachMark(
      targets: targets!,
      pulseEnable: false,
      colorShadow: Color.fromARGB(72, 14, 95, 136),
      onClickTarget: (target) {
        print("${target.identify}");
      },
      hideSkip: true,
      alignSkip: Alignment.topRight,
      onFinish: () {
        print("Finish");
      },
    )..show(context: context);
  }

  void _initTarget() {
    targets = [
      // profile
      TargetFocus(
        identify: "viewCalendar-key",
        keyTarget: viewCalendarKey,
        shape: ShapeLightFocus.RRect,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                text:
                    "Welcome to your calendar where you'll be able to manage your bookings${widget.category == 'Parent' ? ' and view events near you📆!' : '📆!'} ",
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
      TargetFocus(
        identify: "changeMonth-key",
        keyTarget: changeMonthKey,
        shape: ShapeLightFocus.RRect,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                text:
                    "Tap the arrows to navigate between months and stay up to date on your commitments🚀",
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
    ];
  }

  @override
  void initState() {
    if (AuthManager.firstTime && calendarGuide)
    Future.delayed(const Duration(seconds: 1), () {
      _showTutorialCoachmark();
    });
    super.initState();
    _selectedDate = DateTime.now();
    indexOfFirstDayMonth = getIndexOfFirstDayInMonth(_selectedDate);
    indexOfLastDayMonth = indexOfLastDayMonth;
    setState(() {
      _selectedIndex = indexOfFirstDayMonth +
          int.parse(DateFormat('d').format(DateTime.now())) -
          1;
    });
    Future.delayed(Duration.zero, () async {
      if (widget.category == 'Parent') await getEvents();
      allBookings =
          await getBookings(AuthManager.u.UserID.toString(), widget.category);
      setState(() {
        allBookings = allBookings;
      });
    });
    setState(() {
      if (widget.category == 'Parent')
        dayEvents = getEventForDay(allEvents, _selectedDate);
      dayBookings = getBookingForDay(allBookings, _selectedDate);
    });
  }

  Future<void> getEvents() async {
    allEvents = await fetchEvents(widget.city);
  }

  Future<void> refreshPage() async {
    allBookings =
        await getBookings(AuthManager.u.UserID.toString(), widget.category);
    setState(() {
      allBookings = allBookings;
      dayBookings = getBookingForDay(allBookings, _selectedDate);
    });
  }

  void refresh() {
    refreshPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Scaffold(
          backgroundColor: kPrimary,
          appBar: AppBar(
            key: changeMonthKey,
            backgroundColor: kPrimary,
            shadowColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: kDarkerBlue,
              ),
              onPressed: () {
                setState(() {
                  _selectedDate = DateTime(
                    _selectedDate.year,
                    _selectedDate.month - 1,
                    _selectedDate.day,
                  );
                  indexOfFirstDayMonth =
                      getIndexOfFirstDayInMonth(_selectedDate);
                  indexOfLastDayMonth = indexOfLastDayMonth;
                  _selectedIndex = indexOfFirstDayMonth +
                      int.parse(DateFormat('d').format(_selectedDate)) -
                      1;
                });
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward,
                  color: kDarkerBlue,
                ),
                onPressed: () {
                  setState(() {
                    _selectedDate = DateTime(
                      _selectedDate.year,
                      _selectedDate.month + 1,
                      _selectedDate.day,
                    );
                    indexOfFirstDayMonth =
                        getIndexOfFirstDayInMonth(_selectedDate);
                    indexOfLastDayMonth = indexOfLastDayMonth;
                    _selectedIndex = indexOfFirstDayMonth +
                        int.parse(DateFormat('d').format(_selectedDate)) -
                        1;
                  });
                },
              ),
            ],
            title: Column(
              children: [
                const Text(
                  "Calendar",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: kDarkerBlue),
                ),
                Text(
                  DateFormat('MMMM yyyy').format(_selectedDate),
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.grey),
                )
              ],
            ),
          ),
          body: Column(
            children: [
              SizedBox(
                height: 50,
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                    ),
                    itemCount: daysOfWeek.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        alignment: Alignment.center,
                        child: Text(
                          daysOfWeek[index],
                          style: const TextStyle(
                              fontSize: 15,
                              color: kRed,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    }),
              ),
              Container(
                decoration: BoxDecoration(
                  color: kPrimary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: kDarkerBlue.withOpacity(0.3),
                      spreadRadius: 0.1,
                      blurRadius: 7,
                      offset: const Offset(0, 7.75),
                    ),
                  ],
                ),
                child: GridView.builder(
                  key: viewCalendarKey,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                  ),
                  itemCount: 42, // 6 rows of 7 days
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (index >= indexOfFirstDayMonth &&
                                index <
                                    indexOfFirstDayMonth +
                                        listOfDatesInMonth(_selectedDate)
                                            .length &&
                                (index <= indexOfLastDayMonth)) {
                              _selectedIndex = index;
                              _selectedDate = DateTime(
                                _selectedDate.year,
                                _selectedDate.month,
                                _selectedIndex - indexOfFirstDayMonth + 1,
                              );
                              print(_selectedDate);
                              List<Event> list =
                                  getEventForDay(allEvents, _selectedDate);
                              dayEvents.clear();
                              dayEvents = list;
                              List<Booking> bList =
                                  getBookingForDay(allBookings, _selectedDate);
                              dayBookings.clear();
                              dayBookings = bList;
                            }
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: index == _selectedIndex
                                ? kRed
                                : index >= indexOfFirstDayMonth &&
                                        index <
                                            indexOfFirstDayMonth +
                                                listOfDatesInMonth(
                                                        _selectedDate)
                                                    .length &&
                                        index <= indexOfLastDayMonth
                                    ? (((widget.category == 'Parent') &&
                                                    hasEvents(
                                                        DateTime(
                                                            _selectedDate.year,
                                                            _selectedDate.month,
                                                            listOfDatesInMonth(
                                                                    _selectedDate)[
                                                                index]),
                                                        allEvents) ||
                                                hasBookings(
                                                    DateTime(
                                                        _selectedDate.year,
                                                        _selectedDate.month,
                                                        listOfDatesInMonth(
                                                                _selectedDate)[
                                                            index]),
                                                    allBookings))) ||
                                            ((widget.category ==
                                                    'Specialist') &&
                                                hasBookings(
                                                    DateTime(
                                                        _selectedDate.year,
                                                        _selectedDate.month,
                                                        listOfDatesInMonth(
                                                                _selectedDate)[
                                                            index]),
                                                    allBookings))
                                        ? Colors.grey
                                        : Colors.transparent
                                    : Colors
                                        .transparent, // Grey color for days from previous and next months
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            '${listOfDatesInMonth(_selectedDate)[index]}',
                            style: TextStyle(
                              color: index == _selectedIndex
                                  ? Colors.white
                                  : (index <= indexOfLastDayMonth) &&
                                          index % 7 == 6
                                      ? Colors.redAccent
                                      : (index >= indexOfFirstDayMonth &&
                                              index <
                                                  indexOfFirstDayMonth +
                                                      listOfDatesInMonth(
                                                              _selectedDate)
                                                          .length)
                                          ? (index <= indexOfLastDayMonth)
                                              ? (((widget
                                                                      .category ==
                                                                  'Parent') &&
                                                              hasEvents(
                                                                  DateTime(
                                                                      _selectedDate
                                                                          .year,
                                                                      _selectedDate
                                                                          .month,
                                                                      listOfDatesInMonth(
                                                                              _selectedDate)[
                                                                          index]),
                                                                  allEvents) ||
                                                          hasBookings(
                                                              DateTime(
                                                                  _selectedDate
                                                                      .year,
                                                                  _selectedDate
                                                                      .month,
                                                                  listOfDatesInMonth(
                                                                          _selectedDate)[
                                                                      index]),
                                                              allBookings))) ||
                                                      ((widget.category ==
                                                              'Specialist') &&
                                                          hasBookings(
                                                              DateTime(
                                                                  _selectedDate
                                                                      .year,
                                                                  _selectedDate
                                                                      .month,
                                                                  listOfDatesInMonth(
                                                                          _selectedDate)[
                                                                      index]),
                                                              allBookings))
                                                  ? kRed // Set the color for days with events
                                                  : Colors.black
                                              : Colors.grey
                                          : Colors.grey,
                              fontSize: 17,
                              // No underline for days without events
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(getMessage(widget.category, dayBookings, dayEvents),
                        // widget.category=='Parent'
                        //     ? dayBookings.isEmpty&&dayEvents.isEmpty?
                        //     'No events or bookings today'
                        //     : dayBookings.isNotEmpty &&dayEvents.isNotEmpty
                        //         ? '${dayEvents.length} event${(dayEvents.length) == 1 ? '' : 's'} and ${dayBookings.length} event${(dayBookings.length) == 1 ? '' : 's'} today'
                        //         : dayBookings.isEmpty
                        //         ?'${dayEvents.length} event${(dayEvents.length) == 1 ? '' : 's'}'
                        //         :dayEvents.isEmpty?
                        //         ${dayBookings.length} event${(dayEvents.length) == 1 ? '' : 's'},
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    if (dayEvents.isNotEmpty || dayBookings.isNotEmpty)
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(children: [
                            if (widget.category == 'Parent')
                              for (var e in dayEvents) EventCard(event: e),
                            for (var b in dayBookings)
                              BookingCard(
                                  booking: b,
                                  category: widget.category,
                                  onDelete: refresh)
                          ]))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String getMessage(String category, List<Booking> b, List<Event> e) {
  if (category == 'Parent') {
    if (b.isEmpty && e.isEmpty)
      return 'No events or bookings for today';
    else if (b.isEmpty && e.isNotEmpty) {
      return '${e.length} event${(e.length) == 1 ? '' : 's'}';
    } else if (b.isNotEmpty && e.isEmpty) {
      return '${b.length} booking${(b.length) == 1 ? '' : 's'}';
    } else {
      return '${e.length} event${(e.length) == 1 ? '' : 's'} and ${b.length} booking${(b.length) == 1 ? '' : 's'}';
    }
  }
  if (b.isEmpty) {
    return 'No bookings for today';
  }
  return '${b.length} booking${(b.length) == 1 ? '' : 's'}';
}

List<int> listOfDatesInMonth(DateTime currentDate) {
  var selectedMonthFirstDay = DateTime(currentDate.year, currentDate.month, 1);
  var firstDayIndex = getIndexOfFirstDayInMonth(currentDate);

  // Calculate the days from the previous month
  var previousMonthLastDay = selectedMonthFirstDay.subtract(Duration(days: 1));
  var daysInPreviousMonth = previousMonthLastDay.day - firstDayIndex + 1;

  // Calculate the days from the next month
  var daysInCurrentMonth =
      DateTime(currentDate.year, currentDate.month + 1, 0).day;
  // Generate the list of dates for the current month
  var currentMonthDates = List<int>.generate(
    daysInCurrentMonth,
    (i) => i + 1,
  );

  // Generate the list of dates including days from previous and next months
  var listOfDates = List<int>.generate(
    42, // 6 rows of 7 days
    (i) {
      if (i < firstDayIndex) {
        return daysInPreviousMonth + i;
      } else if (i < daysInPreviousMonth + daysInCurrentMonth) {
        if (i - firstDayIndex + 1 > daysInCurrentMonth)
          return (i - firstDayIndex + 1) - daysInCurrentMonth;
        return i - firstDayIndex + 1;
      } else {
        return i - (daysInPreviousMonth + firstDayIndex) + 1;
      }
    },
  );

  // Add the current month's days to the beginning of the list
  listOfDates.replaceRange(firstDayIndex == 0 ? 0 : firstDayIndex,
      currentMonthDates.length, currentMonthDates);
  listOfDates.replaceRange(
      firstDayIndex == 0
          ? currentMonthDates.length
          : firstDayIndex + currentMonthDates.length,
      listOfDates.length - 1,
      currentMonthDates);
  indexOfLastDayMonth = (firstDayIndex == 0
          ? currentMonthDates.length
          : firstDayIndex + currentMonthDates.length) -
      1;
  return listOfDates;
}

int getIndexOfFirstDayInMonth(DateTime currentDate) {
  var selectedMonthFirstDay =
      DateTime(currentDate.year, currentDate.month, 1); // Set day to 1
  var day = DateFormat('EEE').format(selectedMonthFirstDay).toUpperCase();

  return daysOfWeek.indexOf(day);
}

bool hasEvents(DateTime date, List<Event> events) {
  return events.any((event) =>
      event.time.year == date.year &&
      event.time.month == date.month &&
      event.time.day == date.day);
}

bool hasBookings(DateTime date, List<Booking> bookings) {
  return bookings.any((booking) =>
      booking.time.year == date.year &&
      booking.time.month == date.month &&
      booking.time.day == date.day);
}

List<Event> getEventForDay(List<Event> events, DateTime t) {
  List<Event> e = [];



  for (var event in events) {
    if ((event.time.month == t.month) &&
        (event.time.day == t.day) &&
        (t.year == event.time.year)) {
      e.add(event);
    }
  }
  return e;
}

List<Booking> getBookingForDay(List<Booking> allBookings, DateTime t) {
  List<Booking> b = [];

  for (var booking in allBookings) {
    if ((booking.time.month == t.month) &&
        (booking.time.day == t.day) &&
        (t.year == booking.time.year)) {
      b.add(booking);
    }
  }
  return b;
}

final List<String> daysOfWeek = [
  "SAT",
  "SUN",
  "MON",
  "TUE",
  "WED",
  "THU",
  "FRI",
];
