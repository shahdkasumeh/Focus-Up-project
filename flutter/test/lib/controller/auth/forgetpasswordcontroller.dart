import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/core/class/constant/routes.dart';
import 'package:test/model/datasource/auth/email_verification_data.dart';

abstract class ForgetPasswordController extends GetxController {
  checkEmail();
}

class ForgetPasswordControllerImp extends ForgetPasswordController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController email;

  EmailVerificationData emailverificationData = EmailVerificationData(
    Get.find(),
  );

  @override
  void onInit() {
    email = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  checkEmail() async {
    if (!formstate.currentState!.validate()) {
      return;
    }

    final res = await emailverificationData.resendVerification();

    res.fold(
      (failure) {
        Get.snackbar("Error", failure.message);
      },
      (response) {
        Get.snackbar("Success", response["message"] ?? "Check your email");

        // 🔥 الانتقال لصفحة reset password
        Get.offAllNamed(
          AppRoutes.resetpassword,
          arguments: {"email": email.text},
        );
      },
    );
  }
}
