
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:spectrum_speak/constant/utils.dart';

Future getUserCategory(String userId) async {
  try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}/user/category/$userId'),
      headers: {"Accept": "application/json"},
    );
    var decodedData = jsonDecode(response.body);
    if (decodedData['data'] is List && decodedData['data'].isNotEmpty) {
      return decodedData['data'][0]['Category'];
    } else {
      print("Error: Unable to extract 'Category' from the JSON response.");
      return '';
    }
  } catch (error) {
    print("Error in getUserCategory: $error");
    return null;
  }
}

Future getUserName(String userId) async {
  try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}/user/username/$userId'),
      headers: {"Accept": "application/json"},
    );
    var decodedData = jsonDecode(response.body);
    if (decodedData['data'] is List && decodedData['data'].isNotEmpty) {
      return decodedData['data'][0]['Username'];
    } else {
      print("Error: Unable to extract 'Username' from the JSON response.");
      return '';
    }
  } catch (error) {
    print("Error in getUserName: $error");
    return null;
  }
}