import 'package:shared_preferences/shared_preferences.dart';

class StorageHandler {
  static final StorageHandler _instance = StorageHandler._internal();
  factory StorageHandler() => _instance;
  StorageHandler._internal();

  static SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  SharedPreferences get _p => _prefs!;

  Future<void> setToken(String token) async {
    await _p.setString('token', token);
  }

  String? get token => _p.getString('token');

  Future<void> setQrCode(String qr) async {
    await _p.setString('qr_code', qr);
  }

  String? get qrCode => _p.getString('qr_code');

  Future<void> clear() async {
    await _p.clear();
  }
}
