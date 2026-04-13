import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:test/core/class/constant/routes.dart';
import 'package:test/core/class/statusrequest.dart';

abstract class Resetpasswordcontroller extends GetxController {
  goToSuccessResetPassword();
}

class ResetpasswordcontrollerImp extends Resetpasswordcontroller {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController password;
  late TextEditingController password_confirmation;
  bool isPasswordHidden = true;
  bool isConfirmHidden = true;
  late StatusRequest statusRequest;

  void togglePassword() {
    isPasswordHidden = !isPasswordHidden;
    update();
  }

  void toggleConfirmPassword() {
    isConfirmHidden = !isConfirmHidden;
    update();
  }

  @override
  void onInit() {
    password = TextEditingController();
    password_confirmation = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    password_confirmation.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  goToSuccessResetPassword() {
    if (password.text != password_confirmation.text)
      return Get.defaultDialog(
        title: "warning",
        middleText: "password Not Match",
      );
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      Get.offAllNamed(AppRoutes.successresetpassword);
    }
  }
}
