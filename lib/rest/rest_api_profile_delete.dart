import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:spectrum_speak/constant/utils.dart';
Future deleteChild(String childId) async {
  final response = await http.delete(
    Uri.parse('${Utils.baseUrl}/profileDelete/child/$childId'),
    headers: {
      "Accept": "application/json",
    },
  );
  if (response.statusCode == 200) {
    var decodedData = jsonDecode(response.body);
    return decodedData;
  } else {
    throw Exception('Failed to delete child');
  }
}
Future deleteParent(String userId)async{
  final response = await http.delete(
    Uri.parse('${Utils.baseUrl}/profileDelete/parent/$userId'),
    headers: {
      "Accept": "application/json",
    },
  );
  if (response.statusCode == 200) {
    var decodedData = jsonDecode(response.body);
    return decodedData;
  } else {
    throw Exception('Failed to delete child');
  }
}
Future deleteSpecialist(String userId)async{
  final response = await http.delete(
    Uri.parse('${Utils.baseUrl}/profileDelete/specialist/$userId'),
    headers: {
      "Accept": "application/json",
    },
  );
  if (response.statusCode == 200) {
    var decodedData = jsonDecode(response.body);
    return decodedData;
  } else {
    throw Exception('Failed to delete child');
  }
}
Future deleteShadowTeacher(String userId)async{
  final response = await http.delete(
    Uri.parse('${Utils.baseUrl}/profileDelete/shadowTeacher/$userId'),
    headers: {
      "Accept": "application/json",
    },
  );
  if (response.statusCode == 200) {
    var decodedData = jsonDecode(response.body);
    return decodedData;
  } else {
    throw Exception('Failed to delete child');
  }
}
