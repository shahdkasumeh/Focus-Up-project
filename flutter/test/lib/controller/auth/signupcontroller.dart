import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/core/class/constant/routes.dart';
import 'package:test/core/class/constant/storagehandler.dart';
import 'package:test/core/class/crud.dart';
import 'package:test/core/class/statusrequest.dart';
import 'package:test/model/datasource/auth/signup_data.dart';
import 'package:test/model/static/auth_model.dart';
import 'package:test/model/static/signup_model.dart';
import 'dart:convert';

abstract class SignUpController extends GetxController {
  void signUP();

  void goToSignIn();
}

class SignUpControllerImp extends SignUpController {
  late TextEditingController email;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController fullname;
  bool isConfirmHidden = true;
  bool isPasswordHidden = true;
  late TextEditingController password;
  late TextEditingController passwordConfirmation;
  late TextEditingController phone;
  RxString qr = "".obs;
  final SignupData signupData = SignupData(Crud());
  StatusRequest statusRequest = StatusRequest.none;

  @override
  void dispose() {
    fullname.dispose();
    phone.dispose();
    email.dispose();
    password.dispose();
    passwordConfirmation.dispose();
    super.dispose();
  }

  @override
  void goToSignIn() {
    Get.offNamed(AppRoutes.login);
  }

  @override
  void onInit() {
    fullname = TextEditingController();
    phone = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    passwordConfirmation = TextEditingController();

    super.onInit();
    loadQr();
  }

  @override
  void signUP() async {
    if (!formstate.currentState!.validate()) return;

    if (password.text != passwordConfirmation.text) {
      Get.defaultDialog(title: "Warning", middleText: "Passwords do not match");
      return;
    }

    final model = SignupModel(
      fullName: fullname.text,
      email: email.text,
      phone: phone.text,
      password: password.text,
      password_confirmation: passwordConfirmation.text,
    );

    statusRequest = StatusRequest.loading;
    update();

    var response = await signupData.postData(model);

    response.fold(
      (failure) {
        statusRequest = StatusRequest.failure;
        update();

        Get.defaultDialog(title: "Error", middleText: failure.message);
      },
      (success) async {
        print("📦 FULL RESPONSE => $success");

        // ✅ تأكد من وجود التوكن
        final token = success["token"];

        if (token == null) {
          Get.defaultDialog(
            title: "Error",
            middleText: "Token not found in response",
          );
          return;
        }

        print("✅ TOKEN DIRECT => $token");

        // 🔥 حفظ التوكن الصحيح
        await StorageHandler().setToken(token);

        print("🔥 TOKEN SAVED => ${StorageHandler().token}");

        // 👇 استخدم الموديل فقط لليوزر
        final auth = AuthModel.fromJson(success);

        print("USER => ${auth.user}");
        print("ID => ${auth.user.id}");

        // 🔥 حفظ QR
        final qrData = {"user_id": auth.user.id};
        await StorageHandler().setQrCode(jsonEncode(qrData));

        print("QR SAVED => ${StorageHandler().qrCode}");

        statusRequest = StatusRequest.success;
        update();

        Get.toNamed(AppRoutes.successsignup);
      },
    );

    statusRequest = StatusRequest.none;
    update();
  }

  void loadQr() {
    final storedQr = StorageHandler().qrCode;

    print("QR FROM STORAGE => $storedQr");

    qr.value = storedQr ?? "";
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
