import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:spectrum_speak/constant/utils.dart';

Future editProfileParent(String userId, String userName, String phone,
    String birthDate, String selectedCity) async {
  final response = await http
      .patch(Uri.parse('${Utils.baseUrl}/profileEdit/parent/$userId'), headers: {
    "Accept": "application/json",
    "Content-Type":"application/json"
  }, body: jsonEncode({
    'Username': userName,
    "BirthDate": birthDate,
    "City": selectedCity,
    'Phone': phone,
  }));
  var decodedData = jsonDecode(response.body);
  return decodedData;
}

Future editProfileSpecialist(
    String userId,
    String userName,
    String phone,
    String birthDate,
    String selectedCity,
    String specialistCategory,
    double price) async {
  final response = await http.patch(
      Uri.parse('${Utils.baseUrl}/profileEdit/specialist/$userId'),
      headers: {
        "Accept": "application/json",
        "Content-Type":"application/json"
      },
      body: jsonEncode({
        'Username': userName,
        "BirthDate": birthDate,
        "City": selectedCity,
        'Phone': phone,
        'SpecialistCategory': specialistCategory,
        'Price': price.toString(),
      }));
  var decodedData = jsonDecode(response.body);
  return decodedData;
}

Future editProfileShadowTeacher(
    String userId,
    String userName,
    String phone,
    String birthDate,
    String selectedCity,
    String AcademicQualification,
    double salary,
    String gender,
    String availability) async {
  final response = await http.patch(
      Uri.parse('${Utils.baseUrl}/profileEdit/shadowTeacher/$userId'),
      headers: {
        "Accept": "application/json",
        "Content-Type":"application/json"
      },
      body: jsonEncode({
        'Username': userName,
        "AcademicQualification": AcademicQualification,
        "BirthDate": birthDate,
        "City": selectedCity,
        'Phone': phone,
        'Salary': salary.toString(),
        "gender":gender,
        "Availability":availability
      }));
  var decodedData = jsonDecode(response.body);
  return decodedData;
}

Future editChildCard(
    String childId,
    String childName,
    String birthDate,
    String gender,
    String degreeOfAutism,) async {
  final response = await http.patch(
      Uri.parse('${Utils.baseUrl}/profileEdit/child/$childId'),
      headers: {
        "Accept": "application/json",
        "Content-Type":"application/json"
      },
      body: jsonEncode({
        'Name':childName,
        'BirthDate':birthDate,
        'Gender':gender,
        'DegreeOfAutism':degreeOfAutism
      }));
  var decodedData = jsonDecode(response.body);
  return decodedData;
}

Future resetPassword(String email, String password)async{
  final response = await http.patch(
      Uri.parse('${Utils.baseUrl}/profileEdit/password/$email'),
      headers: {
        "Accept": "application/json",
        "Content-Type":"application/json"
      },
      body: {
        'Password':password
      });
  var decodedData = jsonDecode(response.body);
  return decodedData;
}