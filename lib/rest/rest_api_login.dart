import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:spectrum_speak/constant/utils.dart';

Future userLogin(String email, String password) async {
  final response = await http.post(Uri.parse('${Utils.baseUrl}/users/login'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
      body: jsonEncode({'Email': email, 'Password': password}));
  var decodedData = jsonDecode(response.body);
  print('d$decodedData');
  return decodedData;
}

Future<String> getCity(String id) async {
  try {
    final response = await http.post(Uri.parse('${Utils.baseUrl}/users/city'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({'UserID': id}));
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      Map<String, dynamic> data = json.decode(response.body);
      return data['result']['City']; // Assuming the API response structure
    } else if (response.statusCode == 404) {
      // If the city is not found
      throw Exception('City not found');
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load city');
    }
  } catch (error) {
    // Handle errors during the API call
    print('Error fetching city: $error');
    throw Exception('Internal Server Error');
  }
}

Future<bool> checkForFirstTime(String id) async {
  try {
    final response = await http.post(
        Uri.parse('${Utils.baseUrl}/users/checkForFirstTime'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({'id': id}));
    var decodedData = jsonDecode(response.body);
    if (decodedData['result'] == "Not The First Time") 
      return false;
    return true;
  } catch (error) {
// Handle errors during the API call
    print('Error fetching city: $error');
    throw Exception('Internal Server Error');
  }
}
Future<void> setFirstTimeFalse(String id) async {
  try {
    final response = await http.patch(
        Uri.parse('${Utils.baseUrl}/users/setFirstTimeFalse'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({'id': id}));
    var decodedData = jsonDecode(response.body);
  } catch (error) {
// Handle errors during the API call
    print('Error fetching city: $error');
    throw Exception('Internal Server Error');
  }
}
