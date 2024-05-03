import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  late SharedPreferences _preferences;

  SharedPreferencesService() {
    init();
  }

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<bool> saveData(String key, dynamic value) async {
    if (value is String) {
      return await _preferences.setString(key, value);
    } else if (value is int) {
      return await _preferences.setInt(key, value);
    } else if (value is bool) {
      return await _preferences.setBool(key, value);
    }
    return false;
  }

  dynamic getData(String key) {
    return _preferences.get(key);
  }
}
