import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/core/class/constant/routes.dart';
import 'package:test/core/class/constant/storagehandler.dart';
import 'package:test/core/class/crud.dart';
import 'package:test/core/class/statusrequest.dart';
import 'package:test/model/datasource/auth/login_data.dart';
import 'package:test/model/static/auth_model.dart';

abstract class LoginController extends GetxController {
  login();
  goToSignup();
  goTOForgetPassword();
  signIn();
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

  @override
  login() {}

  @override
  goToSignup() {
    Get.offNamed(AppRoutes.signUp);
  }

  @override
  goTOForgetPassword() {
    Get.toNamed(AppRoutes.forgetpassword);
  }

  @override
  signIn() async {
    if (!formstate.currentState!.validate()) return;

    statusRequest = StatusRequest.loading;
    update();

    var response = await loginData.postData({
      "email": email.text,
      "password": password.text,
    });

    print("🔵 LOGIN RESPONSE => $response");

    response.fold(
      (failure) {
        statusRequest = StatusRequest.failure;
        update();

        Get.defaultDialog(title: "Error", middleText: "Server error");
      },
      (data) async {
        print("📦 DATA => $data");

        if (data["token"] != null) {
          final auth = AuthModel.fromJson(data);

          // 🔥 حفظ التوكن
          await StorageHandler().setToken(auth.token);

          // 🔥 حفظ QR (اسم الطالب)
          await StorageHandler().setQrCode(data['user']['name'].toString());

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
}
