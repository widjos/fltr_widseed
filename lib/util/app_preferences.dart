
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  AppPreferences._privateContructor();

  static final AppPreferences shared = AppPreferences._privateContructor();

  static const LANGUAGE_APP = "APP_LANGUAGE_SEEDFLUTTER";

  setString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);

  }

  Future<String?> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);  
  }
}