import 'package:get/instance_manager.dart';
import 'package:test/controller/home/profile_controller.dart';

class ProfileScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileController());
  }
}