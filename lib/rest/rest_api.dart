import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:spectrum_speak/constant/utils.dart';
import 'package:spectrum_speak/modules/parent.dart';
import 'package:spectrum_speak/modules/shadow_teacher.dart';

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

Future specialistSignUp(
    String userId, double price, String selectedSpecialistCategory) async {
  final response = await http
      .post(Uri.parse('${Utils.baseUrl}/signUp/specialist/$userId'), headers: {
    "Accept": "application/json"
  }, body: {
    'Price': price.toString(),
    "Category": selectedSpecialistCategory
  });
  var decodedData = jsonDecode(response.body);
  return decodedData;
}

Future shadowTeacherSignUp(String userId, String salary, String birthDate,
    String availability, String qualification, String gender) async {
  final response = await http.post(
      Uri.parse('${Utils.baseUrl}/signUp/shadowTeacher/$userId'),
      headers: {
        "Accept": "application/json"
      },
      body: {
        'Salary': salary,
        'BirthDate': birthDate,
        'Availability': availability,
        'AcademicQualification': qualification,
        'Gender': gender,
      });
  var decodedData = jsonDecode(response.body);
  return decodedData;
}

Future childrenSignUp(String userId, String name, String birthDate,
    String gender, String degreeOfAutism) async {
  final response =
      await http.post(Uri.parse('${Utils.baseUrl}/signUp/children'), headers: {
    "Accept": "application/json"
  }, body: {
    'UserId': userId,
    'Name': name,
    'BirthDate': birthDate,
    'Gender': gender,
    'DegreeOfAutism': degreeOfAutism,
  });
  var decodedData = jsonDecode(response.body);
  return decodedData;
}

Future<bool> isEmailAlreadyExists(String email) async {
  final response = await http.post(
    Uri.parse('${Utils.baseUrl}/checkEmail'),
    headers: {"Accept": "application/json"},
    body: {
      'Email': email,
    },
  );
  var decodedData = jsonDecode(response.body);

  if (response.statusCode == 200) {
    return decodedData['exists'];
  } else {
    return false;
  }
}

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

Future <ShadowTeacher?> profileShadowTeacher(String userId)async{
  try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}/profile/shadowTeacher/$userId'),
      headers: {"Accept": "application/json"},
    );
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body)["data"][0];
      // Create and return a ShadowTeacher instance
      print('Decoded Data: $decodedData');
      return ShadowTeacher(
        userID: userId,
        salary: double.parse(decodedData['Salary']),
        birthDate: decodedData['BirthDate'],
        availability: decodedData['Availability'],
        qualification: decodedData['AcademicQualification'],
        gender: decodedData['gender'],
        userName: decodedData['Username'],
        email: decodedData['Email'],
        city: decodedData['City'],
        phone: decodedData['Phone'],
        category: UserCategory.values.firstWhere((e) => e.toString() == 'UserCategory.${decodedData['Category']}')
      );
    } else {
      print("Error in profileShadowTeacher: ${response.statusCode}");
      return null;
    }
  } catch (error) {
    print("Error in profileShadowTeacher: $error");
    return null;
  }
}