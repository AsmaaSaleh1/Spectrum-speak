import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spectrum_speak/constant/utils.dart';
import 'package:spectrum_speak/modules/ContactUs.dart';

Future sendContact(
  String userId,
  String contact,
) async {
  final response = await http.post(
      Uri.parse('${Utils.baseUrl}/contactUs/postContact/$userId'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        'Contact': contact,
      }));
  var decodedData = jsonDecode(response.body);
  return decodedData;
}

Future<List<Contact>?> getContact() async {
  List<Contact> contact = [];
  final response = await http.get(
    Uri.parse('${Utils.baseUrl}/contactUs/getContact'),
    headers: {"Accept": "application/json", "Content-Type": "application/json"},
  );
  if (response.statusCode == 200) {
    var decodedData = jsonDecode(response.body);
    for (var item in decodedData['result']) {
      Contact contactUs = Contact(
        item["ContactID"].toString(),
        item["UserID"].toString(),
        item["Username"],
        item["Contact"],
        item["Done"] == 1 ? 1 : 0,
        DateTime.parse(item["Time"]),
      );
      contact.add(contactUs);
    }
    return contact;
  } else {
    print("Error in getContact: ${response.statusCode}");
    return [];
  }
}
Future<List<Contact>?> getAllContact() async {
  List<Contact> contact = [];
  final response = await http.get(
    Uri.parse('${Utils.baseUrl}/contactUs/getAllContact'),
    headers: {"Accept": "application/json", "Content-Type": "application/json"},
  );
  if (response.statusCode == 200) {
    var decodedData = jsonDecode(response.body);
    for (var item in decodedData['result']) {
      Contact contactUs = Contact(
        item["ContactID"].toString(),
        item["UserID"].toString(),
        item["Username"],
        item["Contact"],
        item["Done"] == 1 ? 1 : 0,
        DateTime.parse(item["Time"]),
      );
      contact.add(contactUs);
    }
    return contact;
  } else {
    print("Error in getContact: ${response.statusCode}");
    return [];
  }
}
Future contactUsDone(
  String contactID,
) async {
  final response = await http.put(
    Uri.parse('${Utils.baseUrl}/contactUs/updateContact/$contactID'),
    headers: {"Accept": "application/json", "Content-Type": "application/json"},
  );
  if (response.statusCode == 200) {
    var decodedData = jsonDecode(response.body);
    return decodedData;
  } else {
    print("Error in getContact: ${response.statusCode}");
    return null;
  }
}

Future<int> getDoneContact() async {
  int count = 0;
  final response = await http.get(
    Uri.parse('${Utils.baseUrl}/contactUs/getContact'),
    headers: {"Accept": "application/json", "Content-Type": "application/json"},
  );
  if (response.statusCode == 200) {
    var decodedData = jsonDecode(response.body);
    for (var item in decodedData['result']) {
      if (item["Done"] == 0) count++;
    }
    print('count is for contact admin $count');
    return count;
  } else {
    print("Error in getContact: ${response.statusCode}");
    return 0;
  }
}
