import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:test/core/class/constant/routes.dart';

abstract class SuccessSignupController extends GetxController {
  goToPageLogin();
}

class SuccessSignupControllerImp extends SuccessSignupController {
  @override
  goToPageLogin() {
    Get.offAllNamed(AppRoutes.login);
  }
}
