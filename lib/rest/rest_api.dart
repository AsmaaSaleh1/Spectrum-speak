import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:spectrum_speak/constant/utils.dart';
String responseData = '';

Future userLogin(String email, String password) async {
  await http.post(
    '${Utils.baseUrl}/users/login' as Uri,
    headers: {"Accept":"Application/json"},
    body: {'Email':email,'Password':password}
  );
}