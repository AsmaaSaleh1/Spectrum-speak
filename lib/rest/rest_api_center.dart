import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spectrum_speak/constant/utils.dart';
import 'package:spectrum_speak/modules/CenterUser.dart';
import 'package:spectrum_speak/modules/Event.dart';
import 'package:spectrum_speak/modules/center.dart';

Future<bool> isEmailAlreadyExistsCenter(String email) async {
  final response = await http.post(
      Uri.parse('${Utils.baseUrl}/center/checkEmail'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
      body: jsonEncode(
        {
          'Email': email,
        },
      ));
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
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "CenterName": centerName,
        'Email': email,
        "Phone": phone,
        "Description": description,
        "City": selectedCity,
      }));
  var decodedData = jsonDecode(response.body);
  return decodedData;
}

Future<String?> getCenterIdForSpecialist(String specialistId) async {
  //Delete if not used
  try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}/center/getID/$specialistId'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
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
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
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
        "Content-Type": "application/json"
      },
      body: jsonEncode(
        {
          'CenterName': centerName,
          'Email': email,
          'Phone': phone,
          'Description': description,
          'City': city,
        },
      ));
  var decodedData = jsonDecode(response.body);
  return decodedData;
}

Future deleteCenter(String userId) async {
  final response = await http.delete(
    Uri.parse('${Utils.baseUrl}/center/delete/$userId'),
    headers: {"Accept": "application/json", "Content-Type": "application/json"},
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
        "Content-Type": "application/json"
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

Future<List<dynamic>> searchToAddSpecialist(String namePrefix) async {
  try {
    final response = await http.get(
      Uri.parse(
          '${Utils.baseUrl}/search/center/specialist?namePrefix=$namePrefix'),
      headers: {
        'Accept': 'application/json',
        "Content-Type": "application/json"
      },
    );

    if (response.statusCode == 200) {
      // Check if the response body is not empty before decoding
      if (response.body.isNotEmpty) {
        var decodedData = jsonDecode(response.body);
        print(decodedData['message']);
        return decodedData['message']; // Return the array directly
      } else {
        throw Exception('Empty response body');
      }
    } else {
      throw Exception(
          'Failed to get data. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print(error);
    throw Exception('Failed to get data error: $error');
  }
}

Future<dynamic> getSpecialistAdminForCenter(String centerID) async {
  try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}/center/admin/Specialist/$centerID'),
      headers: {
        'Accept': 'application/json',
        "Content-Type": "application/json"
      },
    );

    if (response.statusCode == 200) {
      // Check if the response body is not empty before decoding
      if (response.body.isNotEmpty) {
        var decodedData = jsonDecode(response.body);
        print('name for sp ${decodedData['specialists'][0]["Username"]}');
        print('id for sp ${decodedData['specialists'][0]["UserID"]}');
        return decodedData['specialists'][0]
            ["Username"]; // Return the array directly
      } else {
        throw Exception('Empty response body');
      }
    } else {
      throw Exception(
          'Failed to get data. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print(error);
    throw Exception('Failed to get data error: $error');
  }
}

Future<dynamic> getSpecialistAdminUserIDForCenter(String centerID) async {
  try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}/center/admin/Specialist/$centerID'),
      headers: {
        'Accept': 'application/json',
        "Content-Type": "application/json"
      },
    );

    if (response.statusCode == 200) {
      // Check if the response body is not empty before decoding
      if (response.body.isNotEmpty) {
        var decodedData = jsonDecode(response.body);
        print('name for sp ${decodedData['specialists'][0]["Username"]}');
        print('id for sp ${decodedData['specialists'][0]["UserID"]}');
        return decodedData['specialists'][0]
            ["UserID"]; // Return the array directly
      } else {
        throw Exception('Empty response body');
      }
    } else {
      throw Exception(
          'Failed to get data. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print(error);
    throw Exception('Failed to get data error: $error');
  }
}

Future<String> getCenterName(String centerID) async {
  try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}/center/name/$centerID'),
      headers: {
        'Accept': 'application/json',
        "Content-Type": "application/json"
      },
    );

    if (response.statusCode == 200) {
      // Check if the response body is not empty before decoding
      if (response.body.isNotEmpty) {
        var decodedData = jsonDecode(response.body);
        // Check if the response indicates success
        if (decodedData['success']) {
          // Extract the center name from the response
          var centerName = decodedData['center']['CenterName'];
          return centerName;
        } else {
          // The server response indicates failure
          print('Center not found');
          return 'No Center';
        }
      } else {
        throw Exception('Empty response body');
      }
    } else {
      throw Exception(
          'Failed to get data. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print(error);
    throw Exception('Failed to get data error: $error');
  }
}

Future<void> addSpecialistToCenter(String userId, String centerId) async {
  try {
    final response = await http.patch(
      Uri.parse('${Utils.baseUrl}/center/addSpecialist/$userId'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{'centerId': int.parse(centerId)}),
    );

    if (response.statusCode == 200) {
      print('Specialist added successfully');
    } else if (response.statusCode == 404) {
      print('User not found');
    } else {
      print('Failed to add speciliast. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error updating center: $error');
  }
}

Future<List<Event>> fetchEvents(String city) async {
  List<Event> list = [];
  final response = await http.get(
      Uri.parse('${Utils.baseUrl}/center/eventsWithCenters'),
      headers: <String, String>{'Accept': 'application/json'});
  print('events api');
  if (response.statusCode == 200) {
    final data = json.decode(response.body);

    // Check if 'result' is not empty
    if (data['result'] != null && data['result'].isNotEmpty) {
      // Assuming you want to create an Event object for the first result
      for (var res in data['result']) {
        final eventResult = res;
        if(eventResult['City']==city)
        {
          CenterUser center =
              await Utils.fetchCenter(eventResult['CenterID'].toString());
          Event e = Event(
            image: center.image,
            eventID: eventResult['EventID'].toString() ??
                '', // Provide a default value
            centerName: eventResult['CenterName'] ?? '',
            city: eventResult['City'] ?? '',
            description: eventResult['Description'] ?? '',
            time: DateTime.parse(eventResult['EventTime']),
          );
          list.add(e);
        }
      }
    }
  }
  return list;
}
