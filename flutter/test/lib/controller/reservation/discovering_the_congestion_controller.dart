import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:test/core/class/constant/routes.dart';
import 'package:test/model/datasource/auth/room_data.dart';
import 'package:test/model/static/crowd_room_model.dart';

abstract class DiscoveringTheCongestionController extends GetxController {}

class DiscoveringTheCongestionControllerImp
    extends DiscoveringTheCongestionController {
  RoomsData roomsData = RoomsData(Get.find());
  var rooms = <CrowdRoomModel>[].obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    fetchRooms();
  }

  Future<void> fetchRooms() async {
    try {
      isLoading.value = true;

      var response = await roomsData.getRooms();

      response.fold(
        (failure) {
          Get.snackbar(
            "خطأ",
            failure.message,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        },
        (success) {
          final data = success["data"];

          if (data is List) {
            rooms.value = data.map((e) => CrowdRoomModel.fromJson(e)).toList();
          } else {
            rooms.clear();
          }
        },
      );
    } catch (e) {
      Get.snackbar(
        "Exception",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void goToRoom(int roomId) {
    Get.toNamed(AppRoutes.roomDetails, arguments: roomId);
  }

  /// 🎨 تحويل لون الباك إلى Color
  Color getColorFromString(String color) {
    switch (color.toLowerCase()) {
      case "green":
        return const Color(0xFF52AF74);
      case "orange":
        return const Color(0xFFF59E0B);
      case "red":
        return const Color(0xFFEF4444);
      default:
        return Colors.grey;
    }
  }

  Color getCardColor(double percent) {
    if (percent <= 50) {
      return const Color(0xFF52AF74); // أخضر
    } else if (percent <= 80) {
      return const Color(0xFFF59E0B); // أصفر
    } else {
      return const Color(0xFFEF4444); // أحمر
    }
  }

  Color getColorFromStatus(String status) {
    switch (status) {
      case "low":
        return const Color(0xFF52AF74);
      case "medium":
        return const Color(0xFFF59E0B);
      case "high":
        return const Color(0xFFEF4444);
      default:
        return Colors.grey;
    }
  }
}
