import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:spectrum_speak/constant/utils.dart';
import 'package:spectrum_speak/modules/child.dart';
import 'package:spectrum_speak/modules/parent.dart';
import 'package:spectrum_speak/modules/shadow_teacher.dart';
import 'package:spectrum_speak/modules/specialist.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';

Future<ShadowTeacher?> profileShadowTeacher(String userId) async {
  try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}/profile/shadowTeacher/$userId'),
      headers: {"Accept": "application/json"},
    );
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body)["data"][0];
      // Create and return a ShadowTeacher instance
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
          category: UserCategory.values.firstWhere((e) =>
              e.toString() == 'UserCategory.${decodedData['Category']}'));
    } else {
      print("Error in profileShadowTeacher: ${response.statusCode}");
      return null;
    }
  } catch (error) {
    print("Error in profileShadowTeacher: $error");
    return null;
  }
}

Future<Specialist?> profileSpecialist(String userId) async {
  try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}/profile/specialist/$userId'),
      headers: {"Accept": "application/json"},
    );
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body)["data"][0];

      // Create and return a specialist instance
      return Specialist(
        userID: userId,
        userName: decodedData['Username'],
        email: decodedData['Email'],
        birthDate: decodedData['BirthDate'],
        city: decodedData['City'],
        phone: decodedData['Phone'],
        category: UserCategory.values.firstWhere(
            (e) => e.toString() == 'UserCategory.${decodedData['Category']}'),
        specialistCategory: decodedData['SpecialistCategory'].toString(),
        price: double.parse(decodedData['Price']),
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

Future<Parent?> profileParent(String userId) async {
  try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}/profile/parent/$userId'),
      headers: {"Accept": "application/json"},
    );
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body)["data"][0];
      // Create and return a parent instance
      return Parent(
        userID: userId,
        userName: decodedData['Username'],
        email: decodedData['Email'],
        birthDate: decodedData['BirthDate'],
        city: decodedData['City'],
        phone: decodedData['Phone'],
        category: UserCategory.values.firstWhere(
            (e) => e.toString() == 'UserCategory.${decodedData['Category']}'),
      );
    } else {
      print("Error in profile Parent: ${response.statusCode}");
      return null;
    }
  } catch (error) {
    print("Error in profile Parent: $error");
    return null;
  }
}

Future<List<Child>> childCard(String userId) async {
  try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}/profile/child/$userId'),
      headers: {"Accept": "application/json"},
    );
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body)["data"];
      print(decodedData);
      // Create and return a list of Child instances
      List<Child> children = decodedData.map<Child>((childData) {
        return Child(
          childID: childData["ChildID"].toString(),
          userID: userId,
          childName: childData['Name'],
          birthDate: childData['BirthDate'],
          gender: childData['Gender'],
          degreeOfAutism: childData['DegreeOfAutism'],
        );
      }).toList();

      return children;
    } else {
      print("Error in child card: ${response.statusCode}");
      return [];
    }
  } catch (error) {
    print("Error in childCard: $error");
    return [];
  }
}

Future<int?> countOfChildForParent(String userId) async {
  try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}/childCount/$userId'),
      headers: {"Accept": "application/json"},
    );

    var decodedData = jsonDecode(response.body);
    if (decodedData['message'] >= 0) {
      // Access the 'message' key for the count
      int count = decodedData['message'];
      return count;
    } else {
      print("Error decoding data from /childCount/$userId");
      return null;
    }
  } catch (error) {
    print('Error in countOfChildForParent: $error');
    return null;
  }
}

Future<Child?> getChildByID(String childId) async {
  try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}/profile/childByID/$childId'),
      headers: {"Accept": "application/json"},
    );
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body)["data"][0];
      String? userId = await AuthManager.getUserId();
      // Create and return a list of Child instances
      if (userId != null) {
        return Child(
          childID: childId,
          userID: userId,
          childName: decodedData['Name'],
          birthDate: decodedData['BirthDate'],
          gender: decodedData['Gender'],
          degreeOfAutism: decodedData['DegreeOfAutism'],
        );
      } else {
        print("Null userID");
        return null;
      }
    } else {
      print("Error in child card: ${response.statusCode}");
      return null;
    }
  } catch (error) {
    print("Error in childCard: $error");
    return null;
  }
}

Future<void> uploadImage(File image) async {
  try {//TODO:not tested
    // Ensure you are importing 'dart:io' for the File class
    final bytes = await image.readAsBytes();
    final base64Image = base64Encode(bytes);

    final response = await http.post(
      Uri.parse('${Utils.baseUrl}/profile/uploadPhoto'),
      headers: {"Accept": "application/json"},
      body: {
        'Photo': base64Image,
      },
    );

    if (response.statusCode == 200) {
      print('Image uploaded successfully');
    } else {
      print('Failed to upload image. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error uploading image: $e');
  }
}
//TODO: handle the null from the database in shadowTeacher and specialist profile
