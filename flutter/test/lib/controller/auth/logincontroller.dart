import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/core/class/constant/routes.dart';
import 'package:test/core/class/crud.dart';
import 'package:test/core/class/statusrequest.dart';
import 'package:test/model/datasource/auth/login_data.dart';
import 'package:test/model/static/auth/auth_model.dart';
import 'package:test/core/class/constant/storagehandler.dart';

abstract class LoginController extends GetxController {
  signIn();
  goToSignup();
  goToForgetPassword();
}

class LoginControllerImp extends LoginController {
  final LoginData loginData = LoginData(Crud());

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController email;
  late TextEditingController password;

  bool isPasswordHidden = true;

  StatusRequest statusRequest = StatusRequest.none;

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  void togglePassword() {
    isPasswordHidden = !isPasswordHidden;
    update();
  }

  // =========================
  // 🔥 ERROR HANDLER
  // =========================

  String mapLoginError(dynamic data) {
    final message = (data["message"] ?? "").toString().toLowerCase();

    if (message.contains("password")) {
      return "Incorrect password. Please try again.";
    }

    if (message.contains("email")) {
      return "Email address is not correct.";
    }

    if (message.contains("user")) {
      return "No account found with this email.";
    }

    if (message.contains("invalid")) {
      return "Invalid login credentials.";
    }

    if (message.contains("network") || message.contains("socket")) {
      return "Network error. Check your internet connection.";
    }

    return "Something went wrong. Please try again later.";
  }

  // =========================
  // 🚀 LOGIN
  // =========================

  @override
  signIn() async {
    if (!formstate.currentState!.validate()) return;

    statusRequest = StatusRequest.loading;
    update();

    final response = await loginData.postData({
      "email": email.text.trim(),
      "password": password.text.trim(),
    });

    response.fold(
      (failure) {
        statusRequest = StatusRequest.failure;
        update();

        Get.snackbar(
          "Login Failed",
          failure.message,
          backgroundColor: Colors.red.withValues(alpha: 0.9),
          colorText: Colors.white,
        );
      },
      (data) async {
        print("LOGIN RESPONSE => $data");

        if (data["token"] != null) {
          final token = data["token"];

          final auth = AuthModel.fromJson(data);

          /// TOKEN
          await StorageHandler().setToken(token);

          /// USER ID
          await StorageHandler().setUserId(auth.user.id);

          /// USER NAME
          await StorageHandler().setUserName(auth.user.fullName);

          /// USER QR
          await StorageHandler().setUserQr("$token|${auth.user.fullName}|null");

          statusRequest = StatusRequest.success;

          update();

          Get.snackbar(
            "Welcome",
            "Login successful 🎉",
            backgroundColor: Colors.green.withValues(alpha: 0.9),
            colorText: Colors.white,
          );

          Get.offAllNamed(AppRoutes.homepagescreen);
        } else {
          statusRequest = StatusRequest.failure;

          update();

          Get.snackbar(
            "Login Failed",
            mapLoginError(data),
            backgroundColor: Colors.red.withValues(alpha: 0.9),
            colorText: Colors.white,
          );
        }
      },
    );

    statusRequest = StatusRequest.none;
    update();
  }

  // =========================
  // NAVIGATION
  // =========================
  @override
  goToSignup() {
    Get.offNamed(AppRoutes.signUp);
  }

  @override
  goToForgetPassword() {
    Get.toNamed(AppRoutes.forgetpassword);
  }
}
