import 'package:get/get.dart';
import 'package:test/controller/reservation/type_booking_controller.dart';

class TypeBookingBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(TypeBookingControllerImp());
  }
}
