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
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Create Account",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Appcolor.scondary,
      ),

      body: GetBuilder<SignUpControllerImp>(
        builder: (controller) => WillPopScope(
          onWillPop: alertExitApp,
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 20,
                ),

                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.15),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),

                  child: Form(
                    key: controller.formstate,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        const SizedBox(height: 10),
                        const Center(child: Textfocusup()),
                        const SizedBox(height: 25),

                        Customtextformauth(
                          valid: (val) => validInput(val!, 4, 20, "username"),
                          isNumber: false,
                          mycontroller: controller.fullname,
                          hinttext: "Enter Full Name",
                          iconData: Icons.person_outline,
                          labeltext: "Full Name",
                        ),

                        Customtextformauth(
                          valid: (val) => validInput(val!, 5, 50, "email"),
                          isNumber: false,
                          mycontroller: controller.email,
                          hinttext: "Enter Email",
                          iconData: Icons.email_outlined,
                          labeltext: "Email",
                        ),

                        Customtextformauth(
                          valid: (val) => validInput(val!, 8, 15, "phone"),
                          isNumber: true,
                          mycontroller: controller.phone,
                          hinttext: "Enter Phone",
                          iconData: Icons.phone_android_outlined,
                          labeltext: "Phone",
                        ),

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
                          onTapIcon: () => controller.togglePassword(),
                        ),

                        Customtextformauth(
                          valid: (val) => validInput(val!, 6, 20, "password"),
                          isNumber: false,
                          mycontroller: controller.passwordConfirmation,
                          hinttext: "Confirm Password",
                          labeltext: "Confirm Password",
                          obscureText: controller.isConfirmHidden,
                          iconData: controller.isConfirmHidden
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          onTapIcon: () => controller.toggleConfirmPassword(),
                        ),

                        const SizedBox(height: 20),

                        Custombuttonauth(
                          text: "Sign Up",
                          onPressed: () {
                            controller.signUP();
                          },
                        ),

                        const SizedBox(height: 10),

                        Textsignup(
                          onTap: () => controller.goToSignIn(),
                          textone: "Already Have An Account?",
                          texttwo: " Sign In",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
