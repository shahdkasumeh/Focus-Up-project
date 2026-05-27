import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/core/class/constant/routes.dart';
import 'package:test/core/class/crud.dart';
import 'package:test/core/class/statusrequest.dart';
import 'package:test/model/datasource/auth/reset_password_data.dart';

abstract class Resetpasswordcontroller extends GetxController {
  goToSuccessResetPassword();
}

class ResetpasswordcontrollerImp extends Resetpasswordcontroller {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController password;
  late TextEditingController password_confirmation;

  bool isPasswordHidden = true;
  bool isConfirmHidden = true;

  StatusRequest statusRequest = StatusRequest.none;

  late ResetPasswordData resetPasswordData;

  String email = "";
  String token = "";

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

    resetPasswordData = ResetPasswordData(Crud());

    email = Get.arguments?["email"] ?? "";
    token = Get.arguments?["token"] ?? "";

    super.onInit();
  }

  @override
  void dispose() {
    password_confirmation.dispose();
    password.dispose();
    super.dispose();
  }

  String mapResetPasswordError(dynamic response) {
    final message = (response["message"] ?? response["status"] ?? "")
        .toString()
        .toLowerCase();

    if (message.contains("token")) {
      return "Reset link is invalid or expired.";
    }

    if (message.contains("email")) {
      return "Email is invalid.";
    }

    if (message.contains("password")) {
      return "Password must be at least 8 characters.";
    }

    return "Unable to reset password. Try again.";
  }

  @override
  goToSuccessResetPassword() async {
    if (password.text.trim() != password_confirmation.text.trim()) {
      return Get.defaultDialog(
        title: "Warning",
        middleText: "Password Not Match",
      );
    }

    if (!formstate.currentState!.validate()) return;

    if (email.isEmpty || token.isEmpty) {
      return Get.defaultDialog(
        title: "Error",
        middleText: "Reset token or email is missing",
      );
    }

    statusRequest = StatusRequest.loading;
    update();

    final res = await resetPasswordData.resetPassword(
      email: email,
      token: token,
      password: password.text.trim(),
      passwordConfirmation: password_confirmation.text.trim(),
    );

    res.fold(
      (failure) {
        statusRequest = StatusRequest.failure;
        update();

        Get.snackbar(
          "Error",
          failure.message,
          backgroundColor: Colors.red.withValues(alpha: 0.9),
          colorText: Colors.white,
        );
      },
      (response) {
        final message = (response["status"] ?? response["message"] ?? "")
            .toString();

        final bool isSuccess =
            message.toLowerCase().contains("reset") ||
            message.toLowerCase().contains("success") ||
            response["success"] == true;

        if (isSuccess) {
          statusRequest = StatusRequest.success;
          update();

          Get.snackbar(
            "Success",
            message.isNotEmpty ? message : "Password reset successfully",
            backgroundColor: Colors.green.withValues(alpha: 0.9),
            colorText: Colors.white,
          );

          Get.offAllNamed(AppRoutes.successresetpassword);
        } else {
          statusRequest = StatusRequest.failure;
          update();

          Get.snackbar(
            "Error",
            mapResetPasswordError(response),
            backgroundColor: Colors.red.withValues(alpha: 0.9),
            colorText: Colors.white,
          );
        }
      },
    );
  }
}
