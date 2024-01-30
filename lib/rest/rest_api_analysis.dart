import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spectrum_speak/constant/utils.dart';

Future<Map<String, dynamic>?> getUsersCountByCity(String city) async {
  try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}/analysis/count/byCity?city=$city'),
      headers: {"Accept": "application/json","Content-Type":"application/json"},
    );

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      Map<String,dynamic> data = decodedData["categoryCounts"];
      return data;
    } else {
      print('Failed to get Users Count By City: ${response.statusCode}');
      return null;
    }
  } catch (error) {
    print('Error during network request: $error');
    return null;
  }
}
Future<Map<String, dynamic>?> getChildrenCountByDegreeOfAutism() async {
  try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}/analysis/count/DegreeOfAutism'),
      headers: {"Accept": "application/json","Content-Type":"application/json"},
    );

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      Map<String,dynamic> data = decodedData["DegreeOfAutism"];
      return data;
    } else {
      print('Failed to get Children Count By Degree Of Autism: ${response.statusCode}');
      return null;
    }
  } catch (error) {
    print('Error during network request: $error');
    return null;
  }
}
Future<Map<String, dynamic>?> getChildrenCountGroupedByOldAndGender() async {
  try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}/analysis/count/children/old'),
      headers: {"Accept": "application/json","Content-Type":"application/json"},
    );

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      Map<String, dynamic> data = {
        "Male": decodedData["Male"],
        "Female": decodedData["Female"],
      };
      return data;
    } else {
      print('Failed to get Children Count Grouped By Old and Gender: ${response.statusCode}');
      return null;
    }
  } catch (error) {
    print('Error during network request: $error');
    return null;
  }
}