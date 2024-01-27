import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:spectrum_speak/constant/utils.dart';
Future addRate(String userID, double rate, String date, String comment,
    String specialistID, String centerID,) async {
  final response =
  await http.post(Uri.parse('${Utils.baseUrl}/rate'), headers: {
    "Content-Type":"application/json",
    "Accept": "application/json"
  }, body: {
    'UserID': userID,
    'Rate': rate.toString(),
    'Date': date,
    "Comment": comment,
    "SpecialistID": specialistID,
    'CenterID': centerID
  });
  var decodedData = jsonDecode(response.body);
  return decodedData;
}
Future <dynamic> getReviewSpecialist(String userId) async {
  try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}/rate/specialist/$userId'),
      headers: {
        "Content-Type":"application/json",
        "Accept": "application/json"
      },
    );
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body)["data"];
      // Create and return a ShadowTeacher instance
      return decodedData;
    } else {
      print("Error in profileShadowTeacher: ${response.statusCode}");
      return null;
    }
  } catch (error) {
    print("Error in profileShadowTeacher: $error");
    return null;
  }
}
Future <dynamic> getReviewCenter(String userId) async {
  try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}/rate/center/$userId'),
      headers: {
        "Content-Type":"application/json",
        "Accept": "application/json"
      },
    );
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body)["data"];
      // Create and return a ShadowTeacher instance
      return decodedData;
    } else {
      print("Error in profileShadowTeacher: ${response.statusCode}");
      return null;
    }
  } catch (error) {
    print("Error in profileShadowTeacher: $error");
    return null;
  }
}
Future deleteRate(String rateId)async{
  final response = await http.delete(
    Uri.parse('${Utils.baseUrl}/rate/delete/$rateId'),
    headers: {
    "Content-Type":"application/json",
    "Accept": "application/json"
  },
  );
  if (response.statusCode == 200) {
    var decodedData = jsonDecode(response.body);
    return decodedData;
  } else {
    throw Exception('Failed to delete rate');
  }
}
Future<bool> checkIfUserRateSpecialistBefore(String userID, String specialistID, ) async {
  try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}/rate/check/specialist?UserID=$userID&SpecialistID=$specialistID'),
      headers: {
        "Content-Type":"application/json",
        "Accept": "application/json"
      },
    );

    if (response.statusCode == 200) {
      // Check if the response body is not empty before decoding
      if (response.body.isNotEmpty) {
        var decodedData = jsonDecode(response.body);
        return decodedData['data']; // Return the array directly
      } else {
        throw Exception('Empty response body');
      }
    } else {
      throw Exception('Failed to get data. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print(error);
    throw Exception('Failed to get data error: $error');
  }
}
Future<bool> checkIfUserRateCenterBefore(String userID, String centerID, ) async {
  try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}/rate/check/center?UserID=$userID&CenterID=$centerID'),
      headers: {
        "Content-Type":"application/json",
        "Accept": "application/json"
      },
    );

    if (response.statusCode == 200) {
      // Check if the response body is not empty before decoding
      if (response.body.isNotEmpty) {
        var decodedData = jsonDecode(response.body);
        return decodedData['data']; // Return the array directly
      } else {
        throw Exception('Empty response body');
      }
    } else {
      throw Exception('Failed to get data. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print(error);
    throw Exception('Failed to get data error: $error');
  }
}