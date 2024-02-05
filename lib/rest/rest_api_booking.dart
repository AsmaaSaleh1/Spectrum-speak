import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spectrum_speak/constant/utils.dart';
import 'package:spectrum_speak/modules/Booking.dart';
import 'package:spectrum_speak/modules/ChatUser.dart';

Future<String> checkBooking(String SpID, String parentID, String d) async {
  String date = d.split('.')[0];
  try {
    final response = await http.post(
        Uri.parse('${Utils.baseUrl}/booking/checkBooking'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({'date': date, 'SpID': SpID, 'pID': parentID}));
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      var decodedData = jsonDecode(response.body);
      return decodedData['Availability']; // Assuming the API response structure
    } else if (response.statusCode == 404) {
      // If the city is not found
      throw Exception('Date not found');
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to check Booking');
    }
  } catch (error) {
    // Handle errors during the API call
    print('Error fetching booking availability: $error');
    throw Exception('Internal Server Error');
  }
}

Future<List<Booking>> getBookings(String uid, String category) async {
  List<Booking> bookings = [];
  try {
    print('bookings here');
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}/booking/getBookings/$uid/$category'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (var item in data['result']) {
        String? url =
            (await Utils.fetchUser('${item['imageTargetUserID']}')).image;
        print('url $url');
        Booking booking = Booking(
            item['ParentName'],
            item['ChildName'],
            item['SpecialistName'],
            DateTime.parse(item['Time']),
            item['Description'],
            item['BookingID'],
            category == 'Specialist' ? url! : '',
            category == 'Parent'? url! : '');
        print(booking.parentImageUrl);
        print(booking.specialistImageUrl);
        bookings.add(booking);
      }
    }
  } catch (e) {
    print("error fetching bookings $e");
  }
  print('length bookings is ${bookings.length}');
  return bookings;
}

Future addBooking(String ParentID, String ChildID, String UserID,
    String Description, String Time) async {
  String date = Time.split('.')[0];
  try {
    final response = await http.post(
        Uri.parse('${Utils.baseUrl}/booking/addBooking'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          "ParentID": ParentID,
          "ChildID": ChildID,
          "UserID": UserID,
          "Description": Description,
          "Time": date
        }));
    var decodedData = jsonDecode(response.body);
    return decodedData;
  } catch (error) {
    // Handle errors during the API call
    print('Error fetching booking availability: $error');
    throw Exception('Internal Server Error');
  }
}

Future<void> deleteBooking(int bookingID) async {
  try {
    final response = await http.delete(
        Uri.parse('${Utils.baseUrl}/booking/deleteBooking/$bookingID'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        });
    var decodedData = jsonDecode(response.body);
    return decodedData['result'];
  } catch (e) {
    print("Error deleting booking $e");
  }
}

Future<List<Booking>> getBookingsForSevenDay(
    String uid, String category) async {
  List<Booking> bookings = [];
  try {
    print('bookings here');
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}/booking/getBookings/7day/$uid/$category'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (var item in data['result']) {
        ChatUser u = await Utils.fetchUser('${item['imageTargetUserID']}');
        String url = u.image;
        Booking booking = Booking(
            item['ParentName'],
            item['ChildName'],
            item['SpecialistName'],
            DateTime.parse(item['Time']),
            item['Description'],
            item['BookingID'],
            category == 'Specialist' ? url! : '',
            category == 'Parent' ? url! : '');
        bookings.add(booking);
      }
    }
  } catch (e) {
    print("error fetching bookings $e");
  }
  print('length bookings is ${bookings.length}');
  return bookings;
}
