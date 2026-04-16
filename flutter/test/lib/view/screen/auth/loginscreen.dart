import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/auth/logincontroller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/core/function/alertexitapp.dart';
import 'package:test/core/function/validinput.dart';
import 'package:test/view/widget/auth/buildlogoscreen.dart';
import 'package:test/view/widget/auth/custombuttonauth.dart';
import 'package:test/view/widget/auth/customtextformauth.dart';
import 'package:test/view/widget/auth/textsignup.dart';

class Loginscreen extends GetView<LoginControllerImp> {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginControllerImp());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(toolbarHeight: 30.0, backgroundColor: Appcolor.scondary),
      body: GetBuilder<LoginControllerImp>(
        builder: (controller) => WillPopScope(
          onWillPop: alertExitApp,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Form(
              key: controller.formstate,
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  Buildlogoscreen(),
                  const SizedBox(height: 30),

                  // EMAIL
                  Customtextformauth(
                    valid: (val) {
                      return validInput(val!, 5, 50, "email");
                    },
                    isNumber: false,
                    mycontroller: controller.email,
                    hinttext: "Enter Your Email",
                    iconData: Icons.email_outlined,
                    labeltext: "Email",
                  ),

                  const SizedBox(height: 20),

                  // PASSWORD
                  Customtextformauth(
                    valid: (val) => validInput(val!, 6, 20, "password"),
                    isNumber: false,
                    mycontroller: controller.password,
                    hinttext: "Enter Password",
                    labeltext: "Password",
                    obscureText: controller.isPasswordHidden,
                    iconData: controller.isPasswordHidden
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    onTapIcon: () {
                      controller.togglePassword();
                    },
                  ),

                  // FORGET PASSWORD
                  InkWell(
                    onTap: () {
                      controller.goToForgetPassword();
                    },
                    child: Text(
                      "Forget Password ?",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Appcolor.scondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // BUTTON
                  Custombuttonauth(
                    onPressed: () {
                      controller.signIn();
                    },
                    text: "Sign In",
                  ),

                  const SizedBox(height: 30),

                  // SIGNUP
                  Textsignup(
                    textone: "Don't have an account ?",
                    texttwo: " SignUP",
                    onTap: () {
                      controller.goToSignup();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
