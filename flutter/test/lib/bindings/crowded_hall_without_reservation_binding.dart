import 'package:get/instance_manager.dart';
import 'package:test/controller/reservation/crowded_hall_with_out_reservation_controller.dart';

class CrowdedHallWithoutReservationBinding  extends Bindings{
  @override
  void dependencies() {
    Get.put(CrowdedHallWithOutReservationControllerImp());
  }
}