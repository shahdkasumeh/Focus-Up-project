import 'package:get/get.dart';
import 'package:test/core/class/statusrequest.dart';
import 'package:test/model/datasource/auth/qr_data.dart';
import 'package:test/model/static/booking_model.dart';

abstract class Qrcodecontroller extends GetxController {}

class QrcodecontrollerImp extends Qrcodecontroller {
  late QrData qrData;

  var studentId = "".obs;
  var studentname = "".obs;

  var isInside = false.obs;
  var sessionDuration = "".obs;

  var statusRequest = StatusRequest.none.obs;

  @override
  void onInit() {
    super.onInit();

    print("🔥 QR CONTROLLER INIT");

    qrData = QrData(Get.find());

    // بيانات تجريبية (بدك لاحقاً تربطيها باليوزر الحقيقي)
    studentId.value = "3";
    studentname.value = "Lana Alhabbal";
  }

  // 🔥 Check In
  Future<void> checkIn() async {
    statusRequest.value = StatusRequest.loading;

    print("🚀 CHECK IN START");

    final response = await qrData.checkIn(studentId.value);

    print("📦 RAW RESPONSE => $response");

    response.fold(
      (failure) {
        print("❌ CHECK IN FAIL => $failure");
        statusRequest.value = StatusRequest.failure;
      },
      (data) {
        print("✅ CHECK IN SUCCESS => $data");

        try {
          final result = BookingResponse.fromJson(data);

          isInside.value = true;
          sessionDuration.value = "";

          print("🎯 PARSED SUCCESS");
        } catch (e) {
          print("❌ PARSE ERROR => $e");
        }

        statusRequest.value = StatusRequest.success;
      },
    );
  }

  // 🔥 Check Out
  Future<void> checkOut() async {
    statusRequest.value = StatusRequest.loading;

    print("🚀 CHECK OUT START");

    final response = await qrData.checkOut(studentId.value);

    print("📦 RAW RESPONSE => $response");

    response.fold(
      (failure) {
        print("❌ CHECK OUT FAIL => $failure");
        statusRequest.value = StatusRequest.failure;
      },
      (data) {
        print("✅ CHECK OUT SUCCESS => $data");

        try {
          final result = BookingResponse.fromJson(data);

          isInside.value = false;
          sessionDuration.value = "${result.data.hours ?? 0} ساعة";

          print("🎯 PARSED SUCCESS");
        } catch (e) {
          print("❌ PARSE ERROR => $e");
        }

        statusRequest.value = StatusRequest.success;
      },
    );
  }

  // 🔥 Toggle
  void toggleCheck() {
    print("🔁 TOGGLE CLICKED");

    if (isInside.value) {
      checkOut();
    } else {
      checkIn();
    }
  }
}
