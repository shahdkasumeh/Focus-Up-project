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

  /// TOKEN
  Future<void> setToken(String token) async {
    await _p.setString('token', token);
  }

  String? get token => _p.getString('token');

  /// USER ID
  Future<void> setUserId(int id) async {
    await _p.setInt('user_id', id);
  }

  int get userId => _p.getInt('user_id') ?? 0;

  /// QR
  Future<void> setQrCode(String qr) async {
    await _p.setString('qr_code', qr);
  }

  String? get qrCode => _p.getString('qr_code');

  /// CLEAR
  Future<void> clear() async {
    await _p.clear();
  }
}
