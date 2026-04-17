import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/core/class/crud.dart';
import 'package:test/model/datasource/auth/walk_in_data.dart';
import 'package:test/model/static/walk_in_crowding_model.dart';

abstract class CrowdedHallWithOutReservationController extends GetxController {}

class CrowdedHallWithOutReservationControllerImp
    extends CrowdedHallWithOutReservationController {
  final WalkInData walkInData = WalkInData(Crud());

  var rooms = <WalkInCrowdingModel>[].obs;
  var isLoading = false.obs;

  /// 👇 Object واحد
  Rxn<WalkInCrowdingModel> room = Rxn<WalkInCrowdingModel>();

  @override
  void onInit() {
    super.onInit();
    fetchRoom();
  }

  Future<void> fetchRoom() async {
    try {
      isLoading.value = true;

      final response = await walkInData.getCrowding();

      response.fold(
        (failure) {
          Get.snackbar("خطأ", failure.message);
        },
        (success) {
          final data = success["data"];

          print("DATA => $data");

          if (data != null && data is Map<String, dynamic>) {
            room.value = WalkInCrowdingModel.fromJson(data);
          } else {
            room.value = null;
            Get.snackbar("تنبيه", "البيانات غير صالحة من السيرفر");
          }
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// 🎨 لون حسب النسبة
  Color getColor(double percent) {
    if (percent < 50) return const Color(0xFF52AF74);
    if (percent < 80) return const Color(0xFFF59E0B);
    return const Color(0xFFEF4444);
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "low":
        return Colors.green;
      case "medium":
        return Colors.orange;
      case "high":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
