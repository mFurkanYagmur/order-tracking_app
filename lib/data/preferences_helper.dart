import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  SharedPreferences? _preferences;

  PreferencesHelper._() {
    SharedPreferences.getInstance().then((value) {
      _preferences = value;
    });
  }

  static PreferencesHelper? _instance;

  static PreferencesHelper get instance {
    _instance ??= PreferencesHelper._();
    return _instance!;
  }

  static const String _emailKey = 'email';

  Future<bool> setEmail(String email) async {
    _preferences ??= await SharedPreferences.getInstance();
    return _preferences!.setString(_emailKey, email);
  }

  Future<String?> getEmail() async {
    _preferences ??= await SharedPreferences.getInstance();
    return _preferences!.getString(_emailKey);
  }

  Future<bool> getIsLogin() async {
    _preferences ??= await SharedPreferences.getInstance();
    final email = _preferences!.getString(_emailKey);
    return email != null && email.isNotEmpty;
  }

  Future<bool?> signOut() async {
    _preferences ??= await SharedPreferences.getInstance();
    return _preferences!.clear();
  }
}
