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

  // ================= TOKEN =================

  Future<void> setToken(String token) async {
    await _p.setString('token', token);
  }

  String? get token => _p.getString('token');

  Future<void> removeToken() async {
    await _p.remove('token');
  }

  // ================= CURRENT USER ID =================

  Future<void> setUserId(int id) async {
    await _p.setInt('user_id', id);
  }

  int get userId => _p.getInt('user_id') ?? 0;

  Future<void> removeUserId() async {
    await _p.remove('user_id');
  }

  // ================= CURRENT USER NAME =================

  Future<void> setUserName(String name) async {
    await _p.setString('user_name', name);
  }

  String? get userName => _p.getString('user_name');

  Future<void> removeUserName() async {
    await _p.remove('user_name');
  }

  // ================= KEYS PER USER =================

  String get _bookingIdKey => 'booking_id_$userId';

  String get _userQrKey => 'user_qr_$userId';

  // ================= USER QR PER USER =================

  Future<void> setUserQr(String qr) async {
    if (userId == 0) return;

    await _p.setString(_userQrKey, qr);
  }

  String? get userQr {
    if (userId == 0) return null;

    return _p.getString(_userQrKey);
  }

  Future<void> removeUserQr() async {
    if (userId == 0) return;

    await _p.remove(_userQrKey);
  }

  // ================= BOOKING ID PER USER =================

  /// كل مستخدم رح ينخزن حجزه بمفتاح خاص فيه:
  /// booking_id_5
  /// booking_id_12
  Future<void> setBookingId(int id) async {
    if (userId == 0) return;

    await _p.setInt(_bookingIdKey, id);
  }

  /// بيرجع حجز المستخدم الحالي فقط
  int get bookingId {
    if (userId == 0) return 0;

    return _p.getInt(_bookingIdKey) ?? 0;
  }

  /// بيمسح حجز المستخدم الحالي فقط
  Future<void> removeBookingId() async {
    if (userId == 0) return;

    await _p.remove(_bookingIdKey);
  }

  // ================= LOGOUT =================

  /// عند تسجيل الخروج منمسح بيانات الجلسة الحالية فقط.
  /// ما منمسح bookingId تبع المستخدم لأن ممكن يرجع يسجل دخول
  /// ولسا حجزه موجود.
  Future<void> clearCurrentSession() async {
    await removeToken();
    await removeUserId();
    await removeUserName();
  }

  /// استخدميها فقط إذا بدك تمسحي كل بيانات التطبيق بالكامل.
  Future<void> clearAll() async {
    await _p.clear();
  }
} 