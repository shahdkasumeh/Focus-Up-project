import 'package:get/get.dart';
import 'package:test/controller/home/luckywheel_controller.dart';

class LuckyWheelScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LuckyWheelControllerImp());
  }
}
