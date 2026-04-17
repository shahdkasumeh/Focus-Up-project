import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:test/controller/reservation/crowded_hall_with_out_reservation_controller.dart';
import 'package:test/core/class/constant/appcolor.dart';

class CrowdedHallWithoutReservation extends StatelessWidget {
  const CrowdedHallWithoutReservation({super.key});

  @override
  Widget build(BuildContext context) {
    CrowdedHallWithOutReservationControllerImp controller = Get.put(
      CrowdedHallWithOutReservationControllerImp(),
    );
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),

        title: const Text(
          "نسبة الازدحام",
          style: TextStyle(color: Appcolor.backgroundcolor),
        ),
        backgroundColor: Appcolor.fourthColor,
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final room = controller.room.value;

        if (room == null) {
          return const Center(child: Text("لا توجد بيانات"));
        }

        final color = controller.getColor(room.percentage);

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// اسم القاعة
                  Text(
                    room.roomName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// progress bar
                  LinearProgressIndicator(
                    value: room.percentage / 100,
                    color: color,
                    backgroundColor: Colors.grey.shade300,
                  ),

                  const SizedBox(height: 8),

                  /// النسبة
                  Text("نسبة الازدحام: ${room.percentage.toStringAsFixed(1)}%"),

                  const SizedBox(height: 6),

                  /// العدد
                  Text(
                    "الموجود داخل: ${room.currentInside} / ${room.capacity}",
                  ),

                  const SizedBox(height: 12),

                  /// الحالة (Badge)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: color),
                    ),
                    child: Text(
                      "الحالة: ${room.status}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// الرسالة
                  Text(room.message, style: TextStyle(color: color)),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
