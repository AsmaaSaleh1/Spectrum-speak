import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spectrum_speak/constant/utils.dart';
import 'package:spectrum_speak/modules/center.dart';

Future<bool> isEmailAlreadyExistsCenter(String email) async {
  final response = await http.post(
    Uri.parse('${Utils.baseUrl}/center/checkEmail'),
    headers: {"Accept": "application/json"},
    body: {
      'Email': email,
    },
  );
  var decodedData = jsonDecode(response.body);

  if (response.statusCode == 200) {
    return decodedData['exists'];
  } else {
    return false;
  }
}

Future centerSignUp(String specialistID, String centerName, String email,
    String phone, String description, String selectedCity) async {
  final response = await http.post(
      Uri.parse('${Utils.baseUrl}/center/register/$specialistID'),
      headers: {
        "Accept": "application/json"
      },
      body: {
        "CenterName": centerName,
        'Email': email,
        "Phone": phone,
        "Description": description,
        "City": selectedCity,
      });
  var decodedData = jsonDecode(response.body);
  return decodedData;
}

Future<String?> getCenterIdForSpecialist(String specialistId) async {
  //Delete if not used
  try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}/center/getID/$specialistId'),
      headers: {"Accept": "application/json"},
    );

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      return decodedData['centerId'].toString();
    } else {
      print('Failed to get center ID: ${response.statusCode}');
      return null;
    }
  } catch (error) {
    print('Error during network request: $error');
    return null;
  }
}

Future<CenterAutism?> profileCenter(String userId) async {
  try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}/center/getCenter/$userId'),
      headers: {"Accept": "application/json"},
    );
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body)["centerInfo"];

      // Create and return a specialist instance
      return CenterAutism(
        centerID: decodedData['CenterID'].toString(),
        centerName: decodedData['CenterName'],
        email: decodedData['Email'],
        phone: decodedData['Phone'],
        description: decodedData['Description'],
        city: decodedData['City'],
      );
    } else {
      print("Error in getCenter: ${response.statusCode}");
      return null;
    }
  } catch (error) {
    print("Error in profileShadowTeacher: $error");
    return null;
  }
}

Future editProfileCenter(
  String userId,
  String centerName,
  String email,
  String phone,
  String description,
  String city,
) async {
  final response = await http.patch(
    Uri.parse('${Utils.baseUrl}/center/edit/$userId'),
    headers: {
      "Accept": "application/json",
    },
    body: {
      'CenterName': centerName,
      'Email': email,
      'Phone': phone,
      'Description': description,
      'City': city,
    },
  );
  var decodedData = jsonDecode(response.body);
  return decodedData;
}

Future deleteCenter(String userId)async{
  final response = await http.delete(
    Uri.parse('${Utils.baseUrl}/center/delete/$userId'),
    headers: {
      "Accept": "application/json",
    },
  );
  if (response.statusCode == 200) {
    var decodedData = jsonDecode(response.body);
    return decodedData;
  } else {
    throw Exception('Failed to delete center');
  }
}

Future<bool> checkAdmin(String userId) async {
  try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}/center/admin/$userId'),
      headers: {
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      return decodedData['isAdmin'] ?? false;
    } else {
      throw Exception('Failed to check admin status');
    }
  } catch (error) {
    print(error);
    throw Exception('Failed to check admin status');
  }
}

Future searchSpecialist() async {//does not work
  try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}/search/specialist'),
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Check if the response body is not empty before decoding
      if (response.body.isNotEmpty) {
        var decodedData = jsonDecode(response.body);
        return decodedData;
      } else {
        throw Exception('Empty response body');//TTTTTTT
      }
    } else {
      throw Exception('Failed to get data. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print(error);
    throw Exception('Failed to get data error: $error');
  }
}
