import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static late SharedPreferences _prefs;

  static const String _isDarkModeKey = 'isDarkMode';
  static const String _keyEmail = 'email';
  static const String _keyVerificationCode = 'verificationCode';
  static const String _keyNewPassword = 'newPassword';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get isDarkMode => _prefs.getBool(_isDarkModeKey) ?? false;
  static String? get email => _prefs.getString(_keyEmail);
  static String? get verificationCode => _prefs.getString(_keyVerificationCode);
  static String? get newPassword => _prefs.getString(_keyNewPassword);

  static Future<void> setIsDarkMode(bool value) async {
    await _prefs.setBool(_isDarkModeKey, value);
  }

  static Future<void> setEmail(String value) async {
    await _prefs.setString(_keyEmail, value);
  }

  static Future<void> setVerificationCode(String value) async {
    await _prefs.setString(_keyVerificationCode, value);
  }

  static Future<void> setNewPassword(String value) async {
    await _prefs.setString(_keyNewPassword, value);
  }

  static Future<void> clear() async {
    await _prefs.clear();
  }

  static Future<void> remove(String key) async {
    await _prefs.remove(key);
  }
}
