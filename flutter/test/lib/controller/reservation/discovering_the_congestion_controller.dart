
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/core/class/constant/routes.dart';
import 'package:test/model/datasource/home/room_data.dart';
import 'package:test/model/static/crowding/crowd_room_model.dart';

abstract class DiscoveringTheCongestionController extends GetxController {}

class DiscoveringTheCongestionControllerImp
    extends DiscoveringTheCongestionController {
  RoomsData roomsData = RoomsData(Get.find());

  var rooms = <CrowdRoomModel>[].obs;
  var isLoading = false.obs;

  Timer? autoRefreshTimer;

  @override
  void onInit() {
    super.onInit();

    fetchRooms(showLoading: true);

    autoRefreshTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      fetchRooms(showLoading: false);
    });
  }

  Future<void> fetchRooms({bool showLoading = true}) async {
    try {
      if (showLoading) {
        isLoading.value = true;
      }

      var response = await roomsData.getRooms();

      response.fold(
        (failure) {
          if (showLoading) {
            Get.snackbar(
              "خطأ",
              failure.message,
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
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
      if (showLoading) {
        Get.snackbar(
          "Exception",
          e.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } finally {
      if (showLoading) {
        isLoading.value = false;
      }
    }
  }

  Future<void> refreshRoomsManually() async {
    await fetchRooms(showLoading: false);
  }

  void goToRoom(int roomId) {
    Get.toNamed(AppRoutes.roomDetails, arguments: roomId);
  }

  Color getColorFromString(String color) {
    final value = color.trim().toLowerCase();

    switch (value) {
      case "green":
      case "low":
        return const Color(0xFF52AF74);

      case "orange":
      case "yellow":
      case "medium":
        return const Color(0xFFF59E0B);

      case "red":
      case "high":
        return const Color(0xFFEF4444);

      case "grey":
      case "gray":
        return Colors.grey;

      default:
        return Colors.grey;
    }
  }

  Color getCardColor(double percent) {
    if (percent <= 50) {
      return const Color(0xFF52AF74);
    } else if (percent <= 80) {
      return const Color(0xFFF59E0B);
    } else {
      return const Color(0xFFEF4444);
    }
  }

  @override
  void onClose() {
    autoRefreshTimer?.cancel();
    super.onClose();
  }
}
