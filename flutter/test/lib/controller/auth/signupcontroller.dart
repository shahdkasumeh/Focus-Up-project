import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/core/class/constant/routes.dart';
import 'package:test/core/class/constant/storagehandler.dart';
import 'package:test/core/class/crud.dart';
import 'package:test/core/class/statusrequest.dart';
import 'package:test/model/datasource/auth/signup_data.dart';
import 'package:test/model/static/auth/auth_model.dart';
import 'package:test/model/static/auth/signup_model.dart';

abstract class SignUpController extends GetxController {
  void signUP();
  void goToSignIn();
}

class SignUpControllerImp extends SignUpController {
  late TextEditingController email;
  late TextEditingController fullname;
  late TextEditingController phone;
  late TextEditingController password;
  late TextEditingController passwordConfirmation;

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  bool isPasswordHidden = true;
  bool isConfirmHidden = true;

  StatusRequest statusRequest = StatusRequest.none;

  final SignupData signupData = SignupData(Crud());

  @override
  void onInit() {
    fullname = TextEditingController();
    phone = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    passwordConfirmation = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    fullname.dispose();
    phone.dispose();
    email.dispose();
    password.dispose();
    passwordConfirmation.dispose();
    super.dispose();
  }

  // =========================
  // 🔥 ERROR HANDLER
  // =========================
  String mapSignupError(dynamic data) {
    final message = (data["message"] ?? "").toString().toLowerCase();

    if (message.contains("email") && message.contains("exist")) {
      return "This email is already registered.";
    }

    if (message.contains("password")) {
      return "Password is too weak or invalid.";
    }

    if (message.contains("phone")) {
      return "Phone number is invalid.";
    }

    if (message.contains("network") || message.contains("socket")) {
      return "Network error. Check your internet connection.";
    }

    return "Failed to create account. Try again.";
  }

  // =========================
  // 🚀 SIGN UP
  // =========================
  @override
  void signUP() async {
    if (!formstate.currentState!.validate()) return;

    if (password.text != passwordConfirmation.text) {
      Get.snackbar(
        "Error",
        "Passwords do not match",
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
      );
      return;
    }

    final model = SignupModel(
      fullName: fullname.text.trim(),
      email: email.text.trim(),
      phone: phone.text.trim(),
      password: password.text,
      password_confirmation: passwordConfirmation.text,
    );

    statusRequest = StatusRequest.loading;
    update();

    final response = await signupData.postData(model);

    response.fold(
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
      (data) async {
        print("📦 RESPONSE => $data");

        final bool isSuccess =
            data["success"] == true ||
            data["status"] == true ||
            data["token"] != null;

        if (!isSuccess) {
          statusRequest = StatusRequest.failure;
          update();

          Get.snackbar(
            "Signup Failed",
            mapSignupError(data),
            backgroundColor: Colors.red.withValues(alpha: 0.9),
            colorText: Colors.white,
          );
          return;
        }

        final token = data["token"];

        if (token == null) {
          Get.snackbar(
            "Error",
            "Server did not return token",
            backgroundColor: Colors.red.withValues(alpha: 0.9),
            colorText: Colors.white,
          );
          return;
        }
        await StorageHandler().setToken(token);

        final auth = AuthModel.fromJson(data);

        await StorageHandler().setUserId(auth.user.id);

        statusRequest = StatusRequest.success;
        update();

        Get.snackbar(
          "Success",
          "Account created successfully 🎉",
          backgroundColor: Colors.green.withValues(alpha: 0.9),
          colorText: Colors.white,
        );

        Get.toNamed(AppRoutes.successsignup);
      },
    );

    statusRequest = StatusRequest.none;
    update();
  }

  @override
  void goToSignIn() {
    Get.offNamed(AppRoutes.login);
  }

  void togglePassword() {
    isPasswordHidden = !isPasswordHidden;
    update();
  }

  void toggleConfirmPassword() {
    isConfirmHidden = !isConfirmHidden;
    update();
  }
}
