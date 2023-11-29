import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static Future<void> storeUserData(String userId, String userEmail) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    prefs.setString('userID', userId);
    prefs.setString('userEmail', userEmail);
  }
  static Future<String?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userID');
  }
}
