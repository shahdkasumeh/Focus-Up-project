import 'package:get/instance_manager.dart';
import 'package:test/controller/reservation/discovering_the_congestion_controller.dart';

class DiscoveringTheCongestionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DiscoveringTheCongestionControllerImp());
  }
}
