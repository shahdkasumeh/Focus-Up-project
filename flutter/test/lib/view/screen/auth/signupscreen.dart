import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/auth/signupcontroller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/core/function/alertexitapp.dart';
import 'package:test/core/function/validinput.dart';
import 'package:test/view/widget/auth/custombuttonauth.dart';
import 'package:test/view/widget/auth/customtextformauth.dart';
import 'package:test/view/widget/auth/textfocusup.dart';
import 'package:test/view/widget/auth/textsignup.dart';

class Signupscreen extends GetView<SignUpControllerImp> {
  const Signupscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Create Account",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Appcolor.scondary,
      ),
      body: GetBuilder<SignUpControllerImp>(
        builder: (controller) => WillPopScope(
          onWillPop: alertExitApp,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Form(
              key: controller.formstate,
              child: ListView(
                children: [
                  const SizedBox(height: 10),
                  const Center(child: Textfocusup()),
                  const SizedBox(height: 30),

                  // FULL NAME
                  Customtextformauth(
                    valid: (val) => validInput(val!, 4, 20, "username"),
                    isNumber: false,
                    mycontroller: controller.fullname,
                    hinttext: "Enter Full Name",
                    iconData: Icons.person_outline,
                    labeltext: "Full Name",
                  ),

                  // EMAIL
                  Customtextformauth(
                    valid: (val) => validInput(val!, 5, 50, "email"),
                    isNumber: false,
                    mycontroller: controller.email,
                    hinttext: "Enter Email",
                    iconData: Icons.email_outlined,
                    labeltext: "Email",
                  ),

                  // PHONE
                  Customtextformauth(
                    valid: (val) => validInput(val!, 8, 15, "phone"),
                    isNumber: true,
                    mycontroller: controller.phone,
                    hinttext: "Enter Phone",
                    iconData: Icons.phone_android_outlined,
                    labeltext: "Phone",
                  ),

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

                  // CONFIRM PASSWORD
                  Customtextformauth(
                    valid: (val) {
                      return validInput(val!, 6, 20, " password");
                    },
                    isNumber: false,
                    mycontroller: controller.passwordConfirmation,
                    hinttext: "Confirm Password",
                    labeltext: "Confirm Password",
                    obscureText: controller.isConfirmHidden,
                    iconData: controller.isConfirmHidden
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    onTapIcon: () {
                      controller.toggleConfirmPassword();
                    },
                  ),

                  const SizedBox(height: 20),

                  // BUTTON
                  Custombuttonauth(
                    text: "Sign Up",
                    onPressed: () {
                      controller.signUP();
                    },
                  ),

                  const SizedBox(height: 15),

                  // SIGN IN
                  Textsignup(
                    onTap: () {
                      controller.goToSignIn();
                    },
                    textone: "Already have an account?",
                    texttwo: " Sign In",
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
