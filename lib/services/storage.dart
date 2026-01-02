import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _keyAppName = 'app_name';
  static const String _keyAppUrl = 'app_url';

  Future<void> saveSettings(String appName, String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyAppName, appName);
    await prefs.setString(_keyAppUrl, url);
  }

  Future<Map<String, String?>> getSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString(_keyAppName);
    final url = prefs.getString(_keyAppUrl);
    return {
      'appName': name,
      'url': url,
    };
  }
}
