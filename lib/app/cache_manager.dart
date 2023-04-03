import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  static late SharedPreferences prefs;

  static String? get sessionId => prefs.getString("sessionId");

  static set sessionId(String? sessionId) {
    if (sessionId != null) prefs.setString("sessionId", sessionId);
  }

  static String? get userId => prefs.getString("userId");

  static set userId(String? userId) {
    if (userId != null) prefs.setString("userId", userId);
  }

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }
}
