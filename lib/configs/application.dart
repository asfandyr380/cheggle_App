import 'package:listar_flutter/models/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Application {
  static bool debug = false;
  static String version = '1.0.8';
  static SharedPreferences preferences;
  static UserModel user;
  static String dateFormat = 'HH:MM, MMM dd yyyy';
  static String domain = "https://passionui.com";

  ///Set User
  Future<void> setUser(UserModel update) async {
    user = update;
  }

  ///Set Preferences
  Future<void> setPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }

  ///Singleton factory
  static final Application _instance = Application._internal();

  factory Application() {
    return _instance;
  }

  Application._internal();
}
