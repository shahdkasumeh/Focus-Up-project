import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:test/core/class/constant/routes.dart';

abstract class TypeBookingController extends GetxController {
  goToDiscoveringTheCongestion();
  goToThehallWithoutAReservation();
}

class TypeBookingControllerImp extends TypeBookingController {
  get statusRequest => null;

  List rooms = []; // كل الغرف
  Map<String, dynamic>? room;
  @override
  goToDiscoveringTheCongestion() {
    Get.toNamed(AppRoutes.discoveringthecongestionscreen);
  }

  @override
  goToThehallWithoutAReservation() {
    Get.toNamed(AppRoutes.crowdedHallWithoutReservation);
  }
}
