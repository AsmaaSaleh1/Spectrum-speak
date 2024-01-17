import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spectrum_speak/constant/utils.dart';

Future addAdmin(String userID) async {
  final response =
      await http.post(Uri.parse('${Utils.baseUrl}/admin'), headers: {
    "Accept": "application/json"
  }, body: {
    'userId': userID,
  });
  var decodedData = jsonDecode(response.body);
  return decodedData;
}
Future <bool?> isAdminSystem(String userID)async{
  try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}/admin/isAdmin/$userID'),
      headers: {
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      return decodedData['isAdmin'] ?? false;
    } else {
      throw Exception('Failed to check admin status');
    }
  } catch (error) {
    print(error);
    throw Exception('Failed to check admin status');
  }
}