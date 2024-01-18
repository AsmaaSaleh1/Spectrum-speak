import 'package:shared_preferences/shared_preferences.dart';
import 'package:spectrum_speak/constant/utils.dart';
import 'package:spectrum_speak/modules/ChatUser.dart';

class AuthManager {
  static late ChatUser u;

  static Future<void> storeUserData(String userId, String userEmail,
      String userName, bool cameFromSignUp) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    prefs.setString('userID', userId);
    prefs.setString('userEmail', userEmail);
    prefs.setString('userName', userName);
    final DateTime now = DateTime.now();
    final DateTime sessionExpiration = now.add(const Duration(minutes: 20));
    prefs.setString('sessionExpiration', sessionExpiration.toIso8601String());
    u = new ChatUser(
        Email: userEmail,
        UserID: int.parse(userId),
        Name: userName,
        isOnline: true);
    u.lastActive = DateTime.now().millisecondsSinceEpoch.toString();
    if (cameFromSignUp == true) {
      await Utils.createFireBaseUser(userEmail, userName, int.parse(userId));
      await Utils.getFirebaseMessagingToken(userId);
    }
    Utils.updateActiveStatus(userId, true);
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

  static Future<String?> getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName');
  }

  static Future<void> clearUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    u.isOnline = false;
    Utils.updateActiveStatus(u.UserID.toString(), false);
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
