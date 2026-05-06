import 'package:get/get.dart';
import 'package:test/controller/home/pakages_controller.dart';

class PackagesScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PackagesController());

  }
}