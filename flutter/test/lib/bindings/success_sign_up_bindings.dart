import 'package:get/instance_manager.dart';
import 'package:test/controller/auth/successsignupcontroller.dart';

class SuccessSignUpBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SuccessSignupControllerImp());
  }
}
