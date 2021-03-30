import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  Future<SharedPreferences> _sharedPreference;

  SharedPreferenceHelper() {
    _sharedPreference = SharedPreferences.getInstance();
  }

  Future<String> getString(String title) {
    return _sharedPreference.then((prefs) {
      return prefs.getString(title) ?? "";
    });
  }

  Future<bool> setString(String title, String value) {
    return _sharedPreference.then((prefs) {
      return prefs.setString(title, value);
    });
  }
}