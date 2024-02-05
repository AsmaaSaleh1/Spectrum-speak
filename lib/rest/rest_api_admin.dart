import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spectrum_speak/constant/utils.dart';

Future addAdmin(String userID) async {
  final response =
      await http.post(Uri.parse('${Utils.baseUrl}/admin'), headers: {
    "Accept": "application/json","Content-Type":"application/json"
  }, body: jsonEncode({
    'userId': userID,
  }));
  var decodedData = jsonDecode(response.body);
  return decodedData;
}

Future<bool?> isAdminSystem(String userID) async {
  try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}/admin/isAdmin/$userID'),
      headers: {
        'Accept': 'application/json',"Content-Type":"application/json"
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

Future<List<dynamic>> searchToUsers(String namePrefix,bool b) async {
  try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}/admin/${b?'search':'searchBlocked'}/user?namePrefix=$namePrefix'),
      headers: {
        'Accept': 'application/json',"Content-Type":"application/json"
      },
    );
    if (response.statusCode == 200) {
      // Check if the response body is not empty before decoding
      if (response.body.isNotEmpty) {
        var decodedData = jsonDecode(response.body);
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

Future removeAdmin(String userID) async {
  final response = await http.delete(
    Uri.parse('${Utils.baseUrl}/admin/delete/$userID'),
    headers: {
      "Accept": "application/json","Content-Type":"application/json"
    },
  );
  if (response.statusCode == 200) {
    var decodedData = jsonDecode(response.body);
    return decodedData;
  } else {
    throw Exception('Failed to delete child');
  }
}

Future blockUser(String userId) async {
  final response = await http.post(
      Uri.parse('${Utils.baseUrl}/admin/blocked/$userId'),
      headers: {"Accept": "application/json",},
      body: {});
  var decodedData = jsonDecode(response.body);
  return decodedData;
}
