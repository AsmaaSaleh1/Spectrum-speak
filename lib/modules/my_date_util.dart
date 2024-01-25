import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDateUtil {
  // for getting formatted time from milliSecondsSinceEpochs String
  static String getFormattedTime(
      {required BuildContext context, required String time}) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return TimeOfDay.fromDateTime(date).format(context);
  }

  static String getCurrentDateTime() {
    // Get the current time
    DateTime now = DateTime.now();

    // Format the time in 12-hour format with AM/PM indicator
    String formattedTime = DateFormat('yyyy/MM/dd hh:mm a').format(now);

    return formattedTime;
  }

  // for getting formatted time for sent & read
  static String getMessageTime(
      {required BuildContext context, required String time}) {
    final DateTime sent = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    final DateTime now = DateTime.now();

    final formattedTime = TimeOfDay.fromDateTime(sent).format(context);
    if (now.day == sent.day &&
        now.month == sent.month &&
        now.year == sent.year) {
      return formattedTime;
    }

    return now.year == sent.year
        ? '$formattedTime - ${sent.day} ${_getMonth(sent)}'
        : '$formattedTime - ${sent.day} ${_getMonth(sent)} ${sent.year}';
  }

  //get last message time (used in chat user card)
  static List<String> getLastMessageTime(
      {required BuildContext context,
      required String time,
      bool showYear = false}) {
    List<String> t = [];
    final DateTime sent = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    final DateTime now = DateTime.now();
    print('send is $sent');
    if (now.day == sent.day &&
        now.month == sent.month &&
        now.year == sent.year) {
      t.add(TimeOfDay.fromDateTime(sent).format(context));
      t.add("Today");
      return t;
    }
    t.add(showYear
        ? '${sent.day} ${_getMonth(sent)} ${sent.year}'
        : '${sent.day} ${_getMonth(sent)}');
    t.add('Not Today');
    return t;
  }

  //get formatted last active time of user in chat screen
  static String getLastActiveTime(
      {required BuildContext context, required String lastActive}) {
    final int i = int.tryParse(lastActive) ?? -1;
    print('func here');
    //if time is not available then return below statement
    if (i == -1) return 'Last seen not available';

    DateTime time = DateTime.fromMillisecondsSinceEpoch(i);
    DateTime now = DateTime.now();

    String formattedTime = TimeOfDay.fromDateTime(time).format(context);
    print(formattedTime);
    if (time.day == now.day &&
        time.month == now.month &&
        time.year == time.year) {
      return 'Last seen today at $formattedTime';
    }

    if ((now.difference(time).inHours / 24).round() == 1) {
      return 'Last seen yesterday at $formattedTime';
    }

    String month = _getMonth(time);

    return 'Last seen on ${time.day} $month on $formattedTime';
  }

  // get month name from month no. or index
  static String _getMonth(DateTime date) {
    switch (date.month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sept';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
    }
    return 'NA';
  }

  static String timeAgo(String dateString) {
    // Parse the input date string with a custom format
    DateTime dateTime = DateFormat('yyyy/MM/dd hh:mm a').parse(dateString);

    // Set the year of the parsed date to the current year
    dateTime = DateTime(dateTime.year, dateTime.month, dateTime.day,
        dateTime.hour, dateTime.minute);

    // Calculate the time difference
    Duration difference = DateTime.now().difference(dateTime);

    if (difference.inDays >= 365) {
      // A year ago or more
      int years = (difference.inDays / 365).floor();
      return '${years == 1 ? 'a year' : '$years years'} ago';
    } else if (difference.inDays >= 30) {
      // At least a month ago
      return '${(difference.inDays / 30).floor()} month${(difference.inDays / 30).floor() > 1 ? 's' : ''} ago';
    } else if (difference.inDays >= 7) {
      // At least a week ago
      return '${difference.inDays ~/ 7} week${difference.inDays ~/ 7 > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 0) {
      // At least a day ago
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      // At least an hour ago
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else {
      // Less than an hour ago
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    }
  }
  static String formatDateTime(DateTime dateTime) {
  String formattedTime = DateFormat.jm().format(dateTime);
  return formattedTime;
  }
}
