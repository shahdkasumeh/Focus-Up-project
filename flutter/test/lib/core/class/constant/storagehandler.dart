import 'package:shared_preferences/shared_preferences.dart';

class StorageHandler {
  static final StorageHandler _instance = StorageHandler._internal();
  factory StorageHandler() => _instance;
  StorageHandler._internal();

  static late SharedPreferences _prefs;

  Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future setToken(String token) async {
    await _prefs.setString('token', token);
  }

  String? get token => _prefs.getString('token');

  Future setQr(String qr) async {
    await _prefs.setString('qr_code', qr);
  }

  String? get qrCode => _prefs.getString('qr_code');

  Future clear() async {
    await _prefs.clear();
  }
}
