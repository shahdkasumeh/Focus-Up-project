import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:test/core/class/constant/routes.dart';
import 'package:test/model/datasource/auth/room_data.dart';
import 'package:test/model/static/room_model.dart';

abstract class DiscoveringTheCongestionController extends GetxController {
  // gotohallquit();
  // goTohallDiscussion();
  // goTOhallsmokefree();
  // goTohallSocialForSmoker();
  // goToTable();
}

class DiscoveringTheCongestionControllerImp
    extends DiscoveringTheCongestionController {
  RoomsData roomsData = RoomsData(Get.find());

  var rooms = <RoomModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchRooms();
    super.onInit();
  }

  /// 📡 جلب الغرف من API
  void fetchRooms() async {
    isLoading.value = true;

    try {
      var response = await roomsData.getRooms();

      if (response != null && response["data"] != null) {
        final data = response["data"] as List;

        rooms.value = data.map((e) => RoomModel.fromJson(e)).toList();
      }
    } catch (e) {
      print("ERROR => $e");
    }

    isLoading.value = false;
  }

  /// 🏢 الانتقال لشاشة الطاولات
  void goToRoom(int roomId) {
    Get.toNamed(
      AppRoutes.hallTables, // 👈 شاشة الطاولات
      arguments: roomId,
    );
  }

  /// 🎨 لون حسب الازدحام
  Color getColor(double percent) {
    if (percent < 50) return const Color.fromARGB(255, 82, 175, 116);
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
