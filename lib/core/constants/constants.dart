import 'package:flutter/material.dart';

// class SharedPrefsService {
//   static SharedPreferences? _prefs;

//   // Khởi tạo trước khi dùng
//   static Future<void> init() async {
//     _prefs = await SharedPreferences.getInstance();
//   }

//   // ----- Keys -----
//   static const String _keyIsLoggedIn = 'isLoggedIn';
//   static const String _keyIsDarkMode = 'isDarkMode';
//   static const String _keyUsername = 'username';
//   static const String _keyToken = 'accessToken';

//   // ----- Getter -----
//   static bool get isLoggedIn => _prefs?.getBool(_keyIsLoggedIn) ?? false;
//   static bool get isDarkMode => _prefs?.getBool(_keyIsDarkMode) ?? false;
//   static String? get username => _prefs?.getString(_keyUsername);
//   static String? get accessToken => _prefs?.getString(_keyToken);

//   // ----- Setter -----
//   static Future<void> setIsLoggedIn(bool value) async {
//     await _prefs?.setBool(_keyIsLoggedIn, value);
//   }

//   static Future<void> setIsDarkMode(bool value) async {
//     await _prefs?.setBool(_keyIsDarkMode, value);
//   }

//   static Future<void> setUsername(String value) async {
//     await _prefs?.setString(_keyUsername, value);
//   }

//   static Future<void> setAccessToken(String value) async {
//     await _prefs?.setString(_keyToken, value);
//   }

//   // ----- Xóa dữ liệu -----
//   static Future<void> clear() async {
//     await _prefs?.clear();
//   }

//   static Future<void> remove(String key) async {
//     await _prefs?.remove(key);
//   }
// }

class KTextStyle {
  static const TextStyle title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subtitle = TextStyle(fontSize: 18, color: Colors.grey);

  static const TextStyle body = TextStyle(fontSize: 16, color: Colors.black87);

  static const TextStyle button = TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 14,
    color: Colors.black54,
  );
}
