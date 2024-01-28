import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spectrum_speak/constant/utils.dart';
Future<List<dynamic>> searchSpecialist(String namePrefix,String city,String specialistCategory) async {
  try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}/search/specialist?city=$city&namePrefix=$namePrefix&specialistCategory=$specialistCategory'),
      headers: {
        'Accept': 'application/json',
        'Content-Type':'application/json'
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
      throw Exception('Failed to get data. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print(error);
    throw Exception('Failed to get data error: $error');
  }
}
Future<List<dynamic>> searchCenter(String namePrefix,String city) async {
  try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}/search/center?city=$city&namePrefix=$namePrefix'),
      headers: {
        'Accept': 'application/json',
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
      throw Exception('Failed to get data. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print(error);
    throw Exception('Failed to get data error: $error');
  }
}
Future<List<dynamic>> searchShadowTeacher(String namePrefix,String city,String gender) async {
  try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}/search/shadowTeacher?city=$city&namePrefix=$namePrefix&Gender=$gender'),
      headers: {
        'Accept': 'application/json',
        'Content-Type':'application/json'
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
      throw Exception('Failed to get data. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print(error);
    throw Exception('Failed to get data error: $error');
  }
}