import 'package:get/get.dart';
import 'package:test/core/class/constant/storagehandler.dart';
import 'package:test/model/datasource/auth/qr_data.dart';

abstract class Qrcodecontroller extends GetxController {}

class QrcodecontrollerImp extends Qrcodecontroller {
  RxString qr = "".obs;

  final StorageHandler storage = StorageHandler();
  final storedQr = StorageHandler().qrCode;

  @override
  void onInit() {
    super.onInit();
  }

  QrData data = QrData(Get.find());

  var isInside = false.obs;

  Future<void> checkIn() async {
    final res = await data.checkIn(qr.value);

    res.fold((f) => Get.snackbar("Error", f.message), (r) {
      isInside.value = true;
      Get.snackbar("Success", r["message"] ?? "Checked in");
    });
  }

  Future<void> checkOut() async {
    final res = await data.checkOut(qr.value);

    res.fold((f) => Get.snackbar("Error", f.message), (r) {
      isInside.value = false;
      Get.snackbar("Success", r["message"] ?? "Checked out");
    });
  }
}
