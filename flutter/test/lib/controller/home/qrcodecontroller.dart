import 'package:get/get.dart';
import 'package:test/core/class/constant/storagehandler.dart';
import 'package:test/model/datasource/auth/qr_data.dart';

abstract class Qrcodecontroller extends GetxController {}

class QrcodecontrollerImp extends Qrcodecontroller {
  RxString qr = "".obs;

  RxBool isInside = false.obs;

  /// 🔥 هنا نخزن كل بيانات الحضور
  Rxn<Map<String, dynamic>> attendanceData = Rxn<Map<String, dynamic>>();

  final StorageHandler storage = StorageHandler();
  final QrData data = QrData(Get.find());

  @override
  void onInit() {
    super.onInit();
    qr.value = storage.qrCode ?? "";
  }

  // ================= CHECK IN =================
  Future<void> checkIn() async {
    if (qr.value.isEmpty) {
      Get.snackbar("Error", "QR is empty");
      return;
    }

    final res = await data.checkIn(qr.value);

    res.fold(
      (f) {
        Get.snackbar("Error", f.message);
      },
      (r) {
        isInside.value = true;

        /// 🔥 نخزن كل الرد
        attendanceData.value = r;

        Get.snackbar("Success", r["message"] ?? "Checked in");
      },
    );
  }

  // ================= CHECK OUT =================
  Future<void> checkOut() async {
    if (qr.value.isEmpty) {
      Get.snackbar("Error", "QR is empty");
      return;
    }

    final res = await data.checkOut(qr.value);

    res.fold(
      (f) {
        Get.snackbar("Error", f.message);
      },
      (r) {
        isInside.value = false;

        /// 🔥 تحديث نفس البيانات
        attendanceData.value = r;

        Get.snackbar("Success", r["message"] ?? "Checked out");
      },
    );
  }
}
/////////////////////////////

//   RxString qr = "".obs;

//   var isInside = false.obs;

//   final StorageHandler storage = StorageHandler();
//   QrData data = QrData(Get.find());

//   @override
//   void onInit() {
//     super.onInit();

//     qr.value = storage.qrCode ?? ""; // 🔥 آمن
//   }

//   Future<void> checkIn() async {
//     if (qr.value.isEmpty) {
//       Get.snackbar("Error", "QR is empty");
//       return;
//     }

//     final res = await data.checkIn(qr.value);

//     res.fold(
//       (f) {
//         Get.snackbar("Error", f.message);
//       },
//       (r) {
//         isInside.value = true;

//         Get.snackbar("Success", r["message"] ?? "Checked in");
//       },
//     );
//   }

//   Future<void> checkOut() async {
//     if (qr.value.isEmpty) {
//       Get.snackbar("Error", "QR is empty");
//       return;
//     }

//     final res = await data.checkOut(qr.value);

//     res.fold(
//       (f) {
//         Get.snackbar("Error", f.message);
//       },
//       (r) {
//         isInside.value = false;

//         Get.snackbar("Success", r["message"] ?? "Checked out");
//       },
//     );
//   }
// }
