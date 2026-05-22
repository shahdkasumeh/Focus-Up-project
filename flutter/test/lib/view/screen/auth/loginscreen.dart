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
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: Appcolor.scondary,
        elevation: 0,
      ),

      body: GetBuilder<LoginControllerImp>(
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
                        color: Colors.grey.withOpacity(0.15),
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
                        const Buildlogoscreen(),
                        const SizedBox(height: 25),

                        Customtextformauth(
                          valid: (val) => validInput(val!, 5, 50, "email"),
                          isNumber: false,
                          mycontroller: controller.email,
                          hinttext: "Enter Your Email",
                          iconData: Icons.email_outlined,
                          labeltext: "Email",
                        ),

                        const SizedBox(height: 15),

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

                        const SizedBox(height: 10),

                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () => controller.goToForgetPassword(),
                            child: Text(
                              "Forget Password ?",
                              style: TextStyle(
                                color: Appcolor.scondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 25),
                        Custombuttonauth(
                          onPressed: () {
                            controller.signIn();
                          },
                          text: "Sign In",
                        ),

                        const SizedBox(height: 20),

                        Textsignup(
                          textone: "Don't Have An Account ?",
                          texttwo: " Sign Up",
                          onTap: () => controller.goToSignup(),
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
