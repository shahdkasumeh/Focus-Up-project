import 'package:get/get.dart';
import 'package:test/controller/auth/logincontroller.dart';

class LoginScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginControllerImp());
  }
}
