import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static Future<void> storeUserData(String userId, String userEmail) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    prefs.setString('userID', userId);
    prefs.setString('userEmail', userEmail);
    final DateTime now = DateTime.now();
    final DateTime sessionExpiration = now.add(const Duration(minutes: 2));
    prefs.setString('sessionExpiration', sessionExpiration.toIso8601String());
    /*If the timestamp is within the valid session duration,
     the user is considered logged in;
     otherwise,
     you'll require them to log in again.*/
  }

  static Future<String?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userID');
  }

  static Future<String?> getUserEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userEmail');
  }

  static Future<void> clearUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<bool> isUserLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? expirationString = prefs.getString('sessionExpiration');

    if (expirationString != null) {
      final DateTime expiration = DateTime.parse(expirationString);
      final DateTime now = DateTime.now();
      return now.isBefore(expiration);
    }

    return false;
  }
}
