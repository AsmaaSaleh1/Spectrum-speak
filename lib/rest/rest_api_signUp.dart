import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:spectrum_speak/constant/utils.dart';

Future userSignUp(String email, String userName, String phone, String password,
    String birthDate, String selectedCity, String selectedCategory) async {
  final response =
      await http.post(Uri.parse('${Utils.baseUrl}/signUp'), headers: {
    "Accept": "application/json"
  }, body: {
    'Username': userName,
    'Email': email,
    'Password': password,
    "BirthDate": birthDate,
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
    "SpecialistCategory": selectedSpecialistCategory
  });
  var decodedData = jsonDecode(response.body);
  print(decodedData);
  return decodedData;
}

Future shadowTeacherSignUp(String userId, String salary, String availability,
    String qualification, String gender) async {
  final response = await http.post(
      Uri.parse('${Utils.baseUrl}/signUp/shadowTeacher/$userId'),
      headers: {
        "Accept": "application/json"
      },
      body: {
        'Salary': salary,
        'Availability': availability,
        'AcademicQualification': qualification,
        'Gender': gender,
      });
  var decodedData = jsonDecode(response.body);
  return decodedData;
}

Future childrenSignUp(String userId, String name, String birthDate,
    String gender, String degreeOfAutism) async {
  final response = await http
      .post(Uri.parse('${Utils.baseUrl}/signUp/children/$userId'), headers: {
    "Accept": "application/json"
  }, body: {
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
    Uri.parse('${Utils.baseUrl}/users/checkEmail/user'),
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

Future<void> uploadImage(File image, String userID) async {
  try {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${Utils.baseUrl}/signUp/uploadPhoto/$userID'),
    );
    request.headers['Accept'] = 'application/json';
    var multipartFile = await http.MultipartFile.fromPath(
      'image',
      image.path,
    );
    request.files.add(multipartFile);
    var response = await http.Response.fromStream(await request.send());
    if (response.statusCode == 200) {
      print('Image uploaded successfully');
    } else {
      print('Failed to upload image. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error uploading image: $e');
  }
}

