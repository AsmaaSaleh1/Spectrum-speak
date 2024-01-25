import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/modules/Event.dart';
import 'package:spectrum_speak/rest/rest_api_center.dart';
import 'package:spectrum_speak/widgets/event_card.dart';

late int indexOfFirstDayMonth = 0;
late int indexOfLastDayMonth = 0;

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime _selectedDate;
  int _selectedIndex = 0;
  List<Event> allEvents = [];
  List<Event> dayEvents = [];
  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    indexOfFirstDayMonth = getIndexOfFirstDayInMonth(_selectedDate);
    indexOfLastDayMonth = indexOfLastDayMonth;
    print('last $indexOfLastDayMonth');
    setState(() {
      _selectedIndex = indexOfFirstDayMonth +
          int.parse(DateFormat('d').format(DateTime.now())) -
          1;
    });
    Future.delayed(Duration.zero, () async {
      await getEvents();
      getEvents();
      if (allEvents.isEmpty) {
        print('inittt empty');
      }
      for (var e in allEvents) {
        print('eventssssssss $e');
      }
    });
    dayEvents = getEventForDay(allEvents, _selectedDate);
  }

  Future<void> getEvents() async {
    allEvents = await fetchEvents();
    if (allEvents.isEmpty) {
      print('init empty');
    }
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
                              print(
                                  'index ${_selectedIndex - indexOfFirstDayMonth}');
                              print(_selectedDate);
                              List<Event> list =
                                  getEventForDay(allEvents, _selectedDate);
                              dayEvents.clear();
                              dayEvents = list;
                              print('new events');
                              for (var e in list) print('eventssss $e');
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
                                                    .length
                                    ? Colors.transparent
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
                                              ? Colors.black
                                              : Colors.grey
                                          : Colors.grey,
                              fontSize: 17,
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
                    Text(
                        dayEvents.length == 0
                            ? 'No events today'
                            : '${dayEvents.length} event${dayEvents.length == 1 ? '' : 's'} today',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                    if (dayEvents.isNotEmpty)
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: [for (var e in dayEvents) EventCard(event:e)]))
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

List<Event> getEventForDay(List<Event> events, DateTime t) {
  List<Event> e = [];

  if (events.isEmpty) {
    print('empty');
  }

  for (var event in events) {
    print(t);
    print(event);
    print('\n\n');
    if ((event.time.month == t.month) &&
        (event.time.day == t.day) &&
        (t.year == event.time.year)) {
      print(e);
      e.add(event);
    }
  }
  return e;
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
