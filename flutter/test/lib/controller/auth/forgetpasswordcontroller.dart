import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/core/class/constant/routes.dart';
import 'package:test/core/class/crud.dart';
import 'package:test/model/datasource/auth/forget_password_data.dart';

abstract class ForgetPasswordController extends GetxController {
  Future<void> checkEmail();
}

class ForgetPasswordControllerImp extends ForgetPasswordController {
  final GlobalKey<FormState> formstate = GlobalKey<FormState>();

  final ForgetPasswordData forgetPasswordData =
      ForgetPasswordData(Crud());

  late TextEditingController email;

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    email = TextEditingController();
  }

  @override
  void onClose() {
    email.dispose();
    super.onClose();
  }

  String mapEmailError(dynamic response) {
    final String message =
        (response["message"] ?? response["status"] ?? "")
            .toString()
            .toLowerCase();

    if (message.contains("not found") ||
        message.contains("doesn't exist") ||
        message.contains("invalid email") ||
        message.contains("selected email is invalid")) {
      return "No account found with this email.";
    }

    if (message.contains("too many") ||
        message.contains("wait") ||
        message.contains("try again later")) {
      return "Please wait before requesting another code.";
    }

    if (message.contains("network") ||
        message.contains("socket") ||
        message.contains("connection")) {
      return "Network error. Please check your connection.";
    }

    return "Unable to send verification code. Try again later.";
  }

  @override
  Future<void> checkEmail() async {
    final bool isValid = formstate.currentState?.validate() ?? false;

    if (!isValid || isLoading.value) return;

    final String emailText = email.text.trim();

    isLoading.value = true;

    final res = await forgetPasswordData.sendEmail(emailText);

    isLoading.value = false;

    res.fold(
      (failure) {
        Get.snackbar(
          "Error",
          failure.message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.withValues(alpha: 0.9),
          colorText: Colors.white,
        );
      },
      (response) {
        final String message =
            (response["message"] ?? "").toString().toLowerCase();

        final String status =
            (response["status"] ?? "").toString().toLowerCase();

        final bool isSuccess =
            response["success"] == true ||
            response["status"] == true ||
            status == "success" ||
            message.contains("otp sent") ||
            message.contains("sent successfully") ||
            message.contains("sent to your email") ||
            message.contains("success");

        if (isSuccess) {
          Get.snackbar(
            "Success",
            "Verification code sent to your email 📩",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green.withValues(alpha: 0.9),
            colorText: Colors.white,
          );

          Get.toNamed(
            AppRoutes.resetpassword,
            arguments: {
              "email": emailText,
            },
          );
        } else {
          Get.snackbar(
            "Error",
            mapEmailError(response),
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red.withValues(alpha: 0.9),
            colorText: Colors.white,
          );
        }
      },
    );
  }
}