
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:spectrum_speak/constant/utils.dart';
import 'package:spectrum_speak/modules/child.dart';
import 'package:spectrum_speak/modules/parent.dart';
import 'package:spectrum_speak/modules/shadow_teacher.dart';
import 'package:spectrum_speak/modules/specialist.dart';

Future <ShadowTeacher?> profileShadowTeacher(String userId)async{
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

Future <Specialist?> profileSpecialist(String userId)async{
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
        city: decodedData['City'],
        phone: decodedData['Phone'],
        category: UserCategory.values.firstWhere((e) => e.toString() == 'UserCategory.${decodedData['Category']}'),
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

Future <Parent?> profileParent(String userId)async{
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
        city: decodedData['City'],
        phone: decodedData['Phone'],
        category: UserCategory.values.firstWhere((e) => e.toString() == 'UserCategory.${decodedData['Category']}'),
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
    if (decodedData['message'] >=0) {
      // Access the 'message' key for the count
      int count = decodedData['message'];
      return count;
    } else {
      //print("Error decoding data from /childCount/$userId");
      return null;
    }
  } catch (error) {
    print('Error in countOfChildForParent: $error');
    return null;
  }
}

//TODO: handle the null from the database in shadowTeacher and specialist profile