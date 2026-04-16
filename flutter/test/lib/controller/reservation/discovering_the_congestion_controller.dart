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

  /// 📡 جلب الغرف من API
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

  /// 🏢 الانتقال لشاشة الطاولات
  void goToRoom(int roomId) {
    Get.toNamed(AppRoutes.roomDetails, arguments: roomId);
  }

  /// 🎨 لون حسب الازدحام
  Color getColor(double percent) {
    if (percent < 50) return const Color(0xFF52AF74);
    if (percent < 80) return const Color(0xFFF59E0B);
    return const Color(0xFFEF4444);
  }

  /// 💬 رسالة حسب الازدحام
  String getMessage(double percent) {
    if (percent < 50) return "هادئة ومناسبة للتركيز";
    if (percent < 80) return "ازدحام متوسط، احجز مسبقاً";
    return "ممتلئة تقريباً، انتظر قليلاً";
  }
}
