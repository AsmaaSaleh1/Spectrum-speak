import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:spectrum_speak/constant/utils.dart';
Future <dynamic> getReview(String userId) async {
  try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}/rate/specialist/$userId'),
      headers: {"Accept": "application/json"},
    );
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body)["data"][0];
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