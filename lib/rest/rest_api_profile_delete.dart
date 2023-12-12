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
