import 'package:get/get.dart';
import 'package:test/model/datasource/auth/qr_data.dart';
import 'package:test/core/class/constant/storagehandler.dart';

class QrcodecontrollerImp extends GetxController {
  RxString qr = "".obs;
  RxInt bookingId = 0.obs;

  Rxn<Map<String, dynamic>> attendanceData = Rxn<Map<String, dynamic>>();

  final StorageHandler storage = StorageHandler();
  final QrData data = QrData(Get.find());

  @override
  void onInit() {
    super.onInit();
    qr.value = storage.qrCode ?? "";
  }

  // ================= استخراج ID =================
  int extractBookingId(String raw) {
    if (raw.startsWith("BOOKING:")) {
      return int.parse(raw.split(":")[1]);
    }

    if (raw.contains("/b/")) {
      final uri = Uri.parse(raw);
      return int.parse(uri.pathSegments.last);
    }

    throw Exception("Invalid QR");
  }

  // ================= عند scan =================
  void handleQR(String raw) {
    qr.value = raw;
    bookingId.value = extractBookingId(raw);
  }

  // ================= الحالة =================
  bool get isInside {
    if (attendanceData.value == null) return false;
    return attendanceData.value!["data"]["status"] != "completed";
  }

  // ================= CHECK IN =================
  Future<void> checkIn() async {
    if (bookingId.value == 0) return;

    final res = await data.checkIn(bookingId.value);

    res.fold((f) => Get.snackbar("Error", f.message), (r) {
      attendanceData.value = r;
      Get.snackbar("Success", r["message"] ?? "Checked in");
    });
  }

  // ================= CHECK OUT =================
  Future<void> checkOut() async {
    if (bookingId.value == 0) return;

    final res = await data.checkOut(bookingId.value);

    res.fold((f) => Get.snackbar("Error", f.message), (r) {
      attendanceData.value = r;
      Get.snackbar("Success", r["message"] ?? "Checked out");
    });
  }
}
