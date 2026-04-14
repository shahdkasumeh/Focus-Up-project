import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:test/core/class/constant/routes.dart';
import 'package:test/core/class/constant/storagehandler.dart';
import 'package:test/core/class/crud.dart';
import 'package:test/core/class/statusrequest.dart';
import 'package:test/model/datasource/auth/signup_data.dart';
import 'package:test/model/static/auth_model.dart';
import 'package:test/model/static/signup_model.dart';
import 'package:uuid/uuid.dart';

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

    var response = await signupData.postData(model);
    response.fold(
      (failure) {
        statusRequest = StatusRequest.failure;
        update();

        Get.defaultDialog(title: "Error", middleText: failure.message);
      },
      (success) {
        statusRequest = StatusRequest.success;
        update();

        final auth = AuthModel.fromJson(success);

        // 🔥 هون حط الطباعة
        print("USER => ${auth.user}");
        print("ID => ${auth.user.id}");

        StorageHandler().setToken(auth.token);
        StorageHandler().setQr(auth.user.id.toString());

        Get.offAllNamed(AppRoutes.successsignup);
      },
    );
    response.fold(
      (failure) {
        statusRequest = StatusRequest.failure;
        update();

        Get.defaultDialog(title: "Error", middleText: failure.message);
      },
      (success) {
        statusRequest = StatusRequest.success;
        update();

        final auth = AuthModel.fromJson(success);

        StorageHandler().setToken(auth.token);
        StorageHandler().setQr(auth.user.id.toString());

        // 🔥 هون حط الطباعة
        print("QR AFTER SIGNUP => ${StorageHandler().qrCode}");

        Get.offAllNamed(AppRoutes.successsignup);
      },
    );

    statusRequest = StatusRequest.none;
    update();
  }

  @override
  void goToSignIn() {
    Get.offNamed(AppRoutes.login);
  }
}
