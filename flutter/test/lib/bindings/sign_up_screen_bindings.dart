import 'package:get/instance_manager.dart';
import 'package:test/controller/auth/signupcontroller.dart';

class SignUpScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SignUpControllerImp());
  }
}
