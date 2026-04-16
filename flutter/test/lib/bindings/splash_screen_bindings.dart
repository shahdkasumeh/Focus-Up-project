import 'package:get/get.dart';
import 'package:test/controller/auth/splashcontroller.dart';

class SplashScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
