import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:test/controller/reservation/crowded_hall_with_out_reservation_controller.dart';

class CrowdedHallWithoutReservation extends StatelessWidget {
  const CrowdedHallWithoutReservation({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CrowdedHallWithOutReservationControllerImp());
    return Scaffold();
  }
}
