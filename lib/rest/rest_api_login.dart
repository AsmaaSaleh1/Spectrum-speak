
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:spectrum_speak/constant/utils.dart';
Future userLogin(String email, String password) async {
  final response = await http.post(Uri.parse('${Utils.baseUrl}/users/login'),
      headers: {"Accept": "application/json"},
      body: {'Email': email, 'Password': password});
  var decodedData = jsonDecode(response.body);
  return decodedData;
}