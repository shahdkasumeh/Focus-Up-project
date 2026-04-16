import 'package:get/instance_manager.dart';
import 'package:test/controller/auth/forgetpasswordcontroller.dart';

class ForgetPasswordScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ForgetPasswordControllerImp());
  }
}
