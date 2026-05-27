import 'package:get/get.dart';
import 'package:test/core/class/constant/storagehandler.dart';
import 'package:test/model/datasource/home/qr_data.dart';

class QrcodecontrollerImp extends GetxController {
  final RxString qr = "".obs;
  final RxString userName = "".obs;

  /// حجز المستخدم الحالي فقط
  final RxInt bookingId = 0.obs;

  final RxBool isLoading = false.obs;

  final Rxn<Map<String, dynamic>> attendanceData = Rxn<Map<String, dynamic>>();

  final QrData data = QrData(Get.find());
  final StorageHandler storage = StorageHandler();

  @override
  void onInit() {
    super.onInit();
    buildUserQr();
  }
  void buildUserQr() {
    final token = storage.token ?? "";
    final currentUserName = storage.userName ?? "";
    final currentUserId = storage.userId;
    final currentBookingId = storage.bookingId;

    userName.value = currentUserName;
    bookingId.value = currentBookingId;

    if (token.isEmpty || currentUserId == 0) {
      qr.value = "";
      return;
    }

    final bookingValue = currentBookingId == 0
        ? "null"
        : currentBookingId.toString();

    qr.value = "$token|$currentUserName|$bookingValue";

    print("CURRENT USER ID => $currentUserId");
    print("CURRENT USER NAME => $currentUserName");
    print("CURRENT USER BOOKING ID => $bookingValue");
    print("CURRENT USER QR => ${qr.value}");
  }

  /// بعد نجاح حجز المستخدم الحالي
  Future<void> setBookingId(int id) async {
    final token = storage.token ?? "";
    final currentUserName = storage.userName ?? "";

    await storage.setBookingId(id);
    await storage.setUserQr("$token|$currentUserName|$id");

    buildUserQr();
  }

  /// بعد إلغاء الحجز أو الخروج للمستخدم الحالي فقط
  Future<void> clearBookingId() async {
    final token = storage.token ?? "";
    final currentUserName = storage.userName ?? "";

    await storage.removeBookingId();
    await storage.setUserQr("$token|$currentUserName|null");

    buildUserQr();
  }

  void refreshQr() {
    buildUserQr();
  }

  Map<String, dynamic>? get bookingData {
    final value = attendanceData.value;

    if (value == null) return null;

    if (value["data"] is Map<String, dynamic>) {
      return Map<String, dynamic>.from(value["data"]);
    }

    return value;
  }

  String get actualStartText {
    final value = bookingData?["actual_start"];

    if (value == null || value.toString().isEmpty) {
      return "-";
    }

    return value.toString();
  }

  String get actualEndText {
    final value = bookingData?["actual_end"];

    if (value == null || value.toString().isEmpty) {
      return "Still Inside";
    }

    return value.toString();
  }

  Future<void> checkIn() async {
    if (bookingId.value == 0) {
      Get.snackbar("Error", "No active booking");
      return;
    }

    isLoading.value = true;

    try {
      final res = await data.checkIn(bookingId.value);

      res.fold(
        (failure) {
          Get.snackbar("Error", failure.message);
        },
        (response) {
          attendanceData.value = Map<String, dynamic>.from(response);

          Get.snackbar("Success", response["message"] ?? "Checked in");
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkOut() async {
    if (bookingId.value == 0) {
      Get.snackbar("Error", "No active booking");
      return;
    }

    isLoading.value = true;

    try {
      final res = await data.checkOut(bookingId.value);

      await res.fold(
        (failure) async {
          Get.snackbar("Error", failure.message);
        },
        (response) async {
          attendanceData.value = Map<String, dynamic>.from(response);

          await clearBookingId();

          Get.snackbar("Success", response["message"] ?? "Checked out");
        },
      );
    } finally {
      isLoading.value = false;
    }
  }
}
