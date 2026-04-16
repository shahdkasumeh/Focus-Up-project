import 'package:get/get.dart';
import 'package:test/core/class/crud.dart';
import 'package:test/model/datasource/auth/walk_in_data.dart';

abstract class CrowdedHallWithOutReservationController extends GetxController {}

class CrowdedHallWithOutReservationControllerImp
    extends CrowdedHallWithOutReservationController {
  final WalkInData walkInData = WalkInData(Crud());

  //   StatusRequest statusRequest = StatusRequest.none;

  //   Map<String, dynamic>? crowding;

  //   @override
  //   void onInit() {
  //     super.onInit();
  //     getCrowding();
  //   }

  //   // =========================
  //   // 📥 GET CROWDING
  //   // =========================
  //   Future<void> getCrowding() async {
  //     statusRequest = StatusRequest.loading;
  //     update();

  //     try {
  //       final response = await walkInData.getCrowding();

  //       response.fold(
  //         (failure) {
  //           print("❌ API ERROR => ${failure.message}");
  //           statusRequest = StatusRequest.failure;
  //         },
  //         (data) {
  //           print("📥 RESPONSE => $data");

  //           crowding = data["data"];

  //           statusRequest = StatusRequest.success;
  //         },
  //       );
  //     } catch (e) {
  //       print("🔥 EXCEPTION => $e");
  //       statusRequest = StatusRequest.failure;
  //     }

  //     update();
  //   }
  // }
  final List<Map<String, dynamic>> rooms = [
    {
      "name": "Social Hall",
      "capacity": 50,
      "inside": 1,
      "crowding": 2,
      "message": "القاعة هادئة",
      "status": "low",
    },
  ];
}
