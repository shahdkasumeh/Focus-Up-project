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

  // =========================
  // 🔥 EMAIL ERROR HANDLER
  // =========================
  String mapEmailError(dynamic response) {
    final message = (response["message"] ?? "").toString().toLowerCase();

    if (message.contains("not found") ||
        message.contains("doesn't exist") ||
        message.contains("invalid email")) {
      return "No account found with this email.";
    }

    if (message.contains("network") || message.contains("socket")) {
      return "Network error. Please check your connection.";
    }

    return "Unable to process request. Try again later.";
  }

  // =========================
  // 🚀 CHECK EMAIL
  // =========================
  @override
  checkEmail() async {
    if (!formstate.currentState!.validate()) return;

    final emailText = email.text.trim();

    final res = await emailverificationData.resendVerification();

    res.fold(
      (failure) {
        Get.snackbar(
          "Error",
          failure.message,
          backgroundColor: Colors.red.withValues(alpha: 0.9),
          colorText: Colors.white,
        );
      },
      (response) {
        final message = (response["message"] ?? "").toString().toLowerCase();

        final bool isSuccess =
            response["success"] == true ||
            response["status"] == true ||
            message.contains("sent") ||
            message.contains("success");

        if (isSuccess) {
          Get.snackbar(
            "Success",
            "Verification email sent 📩",
            backgroundColor: Colors.green.withValues(alpha: 0.9),
            colorText: Colors.white,
          );

          Get.offAllNamed(
            AppRoutes.resetpassword,
            arguments: {"email": emailText},
          );
        } else {
          Get.snackbar(
            "Error",
            mapEmailError(response),
            backgroundColor: Colors.red.withValues(alpha: 0.9),
            colorText: Colors.white,
          );
        }
      },
    );
  }
}
