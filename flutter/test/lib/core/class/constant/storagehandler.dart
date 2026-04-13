import 'package:shared_preferences/shared_preferences.dart';

class StorageHandler {
  static SharedPreferences? _prefs;

  Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future setToken(String token) async {
    await _prefs?.setString('token', token);
  }

  String? get token {
    return _prefs?.getString('token');
  }

  Future clear() async {
    await _prefs?.clear();
  }
}
