import 'package:get/instance_manager.dart';
import 'package:test/controller/auth/resetpasswordcontroller.dart';

class ResetPasswordScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ResetpasswordcontrollerImp());
  }
}
