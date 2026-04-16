import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/core/class/constant/routes.dart';
import 'package:test/core/class/constant/storagehandler.dart';
import 'package:test/core/class/crud.dart';
import 'package:test/core/class/statusrequest.dart';
import 'package:test/model/datasource/auth/login_data.dart';
import 'package:test/model/static/auth_model.dart';

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

  void togglePassword() {
    isPasswordHidden = !isPasswordHidden;
    update();
  }

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

  // =========================
  // 🚀 LOGIN
  // =========================
  @override
  signIn() async {
    if (!formstate.currentState!.validate()) return;

    statusRequest = StatusRequest.loading;
    update();

    final response = await loginData.postData({
      "email": email.text,
      "password": password.text,
    });

    print("🔵 LOGIN RESPONSE => $response");

    response.fold(
      (failure) {
        statusRequest = StatusRequest.failure;
        update();

        Get.defaultDialog(title: "Error", middleText: failure.message);
      },
      (data) async {
        print("📦 DATA => $data");

        // =========================
        // ✅ CHECK TOKEN
        // =========================
        if (data["token"] != null) {
          final auth = AuthModel.fromJson(data);

          // 🔥 حفظ التوكن بشكل صحيح
          await StorageHandler().setToken(auth.token);
          print("🔥 TOKEN SAVED => ${StorageHandler().token}");

          // 🔥 حفظ اسم المستخدم (QR)
          await StorageHandler().setQrCode(auth.user.fullName);

          statusRequest = StatusRequest.success;
          update();

          Get.offAllNamed(AppRoutes.homepagescreen);
        } else {
          statusRequest = StatusRequest.failure;
          update();

          Get.defaultDialog(
            title: "Error",
            middleText: data["message"] ?? "Login failed",
          );
        }
      },
    );

    statusRequest = StatusRequest.none;
    update();
  }

  @override
  goToSignup() {
    Get.offNamed(AppRoutes.signUp);
  }

  @override
  goToForgetPassword() {
    Get.toNamed(AppRoutes.forgetpassword);
  }
}
