import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static late SharedPreferences _preferences;
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> reload() async {
    _preferences.reload();
  }

  static containKey(String key) {
    return _preferences.containsKey(key);
  }

  static deleteString(String key) {
    return _preferences.remove(key);
  }

  static setString(String key, String value) {
    return _preferences.setString(key, value);
  }

  static setStringList(String key, List<String> value) {
    return _preferences.setStringList(key, value);
  }

  static String getString(String key) {
    return _preferences.getString(key) ?? "";
  }

  static List<String> getStringList(String key) {
    return _preferences.getStringList(key) ?? [];
  }

// You can add similar functions for other data types as needed
// Example:
  static setBool(String key, bool value) {
    return _preferences.setBool(key, value);
  }

  static bool getBool(String key) {
    return _preferences.getBool(key) ?? false;
  }

// Add more functions as per your requirements
}
