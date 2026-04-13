import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/core/class/constant/appcolor.dart';

import 'package:test/core/class/constant/routes.dart';
import 'package:test/core/class/constant/storagehandler.dart';
import 'package:test/core/class/crud.dart';
import 'package:test/core/class/statusrequest.dart';
import 'package:test/model/datasource/auth/signup_data.dart';
import 'package:test/model/static/auth_model.dart';
import 'package:test/model/static/signup_model.dart';

abstract class SignUpController extends GetxController {
  void signUP();
  void goToSignIn();
}

class SignUpControllerImp extends SignUpController {
  final SignupData signupData = SignupData(Crud());

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController fullname;
  late TextEditingController phone;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController passwordConfirmation;

  StatusRequest statusRequest = StatusRequest.none;

  bool isPasswordHidden = true;
  bool isConfirmHidden = true;

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

  void togglePassword() {
    isPasswordHidden = !isPasswordHidden;
    update();
  }

  void toggleConfirmPassword() {
    isConfirmHidden = !isConfirmHidden;
    update();
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

    try {
      var response = await signupData.postData(model);

      print("🔵 RAW RESPONSE => $response");

      if (response != null && response["token"] != null) {
        print("✅ SUCCESS BLOCK ENTERED");

        /// 🔥 هون أهم سطر (استخدام المودل)
        final auth = AuthModel.fromJson(response);

        statusRequest = StatusRequest.success;
        update();

        /// 💾 حفظ التوكن
        StorageHandler().setToken(auth.token);

        /// 🔥 مثال استخدام user
        print(auth.user.fullName);
        print(auth.user.email);

        Get.offAllNamed(AppRoutes.successsignup);
      } else {
        print("❌ FAILED CONDITION");

        statusRequest = StatusRequest.failure;
        update();

        Get.defaultDialog(
          backgroundColor: Appcolor.grey,
          title: "Error",
          middleTextStyle: const TextStyle(color: Colors.white),
          titleStyle: const TextStyle(color: Colors.white),
          middleText: response?["message"] ?? "Signup failed",
        );
      }
    } catch (e) {
      print("❌ EXCEPTION => $e");

      statusRequest = StatusRequest.failure;
      update();

      Get.defaultDialog(title: "Error", middleText: "Server error occurred");
    }

    statusRequest = StatusRequest.none;
    update();
  }

  @override
  void goToSignIn() {
    Get.offNamed(AppRoutes.login);
  }
}
