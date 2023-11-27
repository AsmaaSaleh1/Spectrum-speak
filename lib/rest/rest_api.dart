import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:spectrum_speak/constant/utils.dart';

Future userLogin(String email, String password) async {
  final response = await http.post(Uri.parse('${Utils.baseUrl}/login'),
      headers: {"Accept": "application/json"},
      body: {'Email': email, 'Password': password});
  var decodedData = jsonDecode(response.body);
  return decodedData;
}

Future userSignUp(String email, String userName, String phone, String password,
    String selectedCity, String selectedCategory) async {
  final response =
      await http.post(Uri.parse('${Utils.baseUrl}/signUp'), headers: {
    "Accept": "application/json"
  }, body: {
    'Username': userName,
    'Email': email,
    'Password': password,
    "City": selectedCity,
    'Phone': phone,
    "Category": selectedCategory
  });
  var decodedData = jsonDecode(response.body);
  return decodedData;
}
