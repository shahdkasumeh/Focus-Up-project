import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/auth/successsignupcontroller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/view/widget/auth/custombuttonauth.dart';

class SuccessSignup extends GetView<SuccessSignupControllerImp> {
  const SuccessSignup({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SuccessSignupControllerImp());
    return Scaffold(
      appBar: AppBar(toolbarHeight: 40.0, backgroundColor: Appcolor.scondary),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const Center(
              child: Icon(
                Icons.check_circle_outline,
                size: 200,
                color: Appcolor.scondary,
              ),
            ),
            Text(
              "Sent Succesfully ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Appcolor.scondary,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 30),

            Text(
              "A Password Reset Link has been sent to ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Appcolor.scondary,
                fontSize: 14,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: Custombuttonauth(
                text: "Go to login",
                onPressed: () {
                  controller.goToPageLogin();
                },
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
