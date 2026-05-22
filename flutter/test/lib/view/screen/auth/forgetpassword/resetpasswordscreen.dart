import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:test/controller/auth/resetpasswordcontroller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/core/function/validinput.dart';
import 'package:test/view/widget/auth/customtextformauth.dart';

class Resetpasswordscreen extends GetView<ResetpasswordcontrollerImp> {
  const Resetpasswordscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(elevation: 0, backgroundColor: Appcolor.scondary),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),

            child: Form(
              key: controller.formstate,

              child: GetBuilder<ResetpasswordcontrollerImp>(
                builder: (controller) => Container(
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

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// ICON
                      Container(
                        height: 110,
                        width: 110,

                        decoration: BoxDecoration(
                          shape: BoxShape.circle,

                          gradient: LinearGradient(
                            colors: [
                              Appcolor.scondary,
                              Appcolor.scondary.withValues(alpha: 0.7),
                            ],
                          ),
                        ),

                        child: const Icon(
                          Icons.lock_reset_rounded,
                          color: Colors.white,
                          size: 55,
                        ),
                      ),

                      const SizedBox(height: 30),

                      /// TITLE
                      const Text(
                        "Reset Password",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Appcolor.scondary,
                        ),
                      ),

                      const SizedBox(height: 15),

                      /// SUBTITLE
                      Text(
                        "Create a new strong password for your account.",
                        textAlign: TextAlign.center,

                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade600,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 40),

                      /// PASSWORD
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

                      /// CONFIRM PASSWORD
                      Customtextformauth(
                        valid: (val) => validInput(val!, 6, 20, "password"),

                        isNumber: false,
                        mycontroller: controller.password_confirmation,

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

                      /// BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 48,

                        child: ElevatedButton(
                          onPressed: () {
                            controller.goToSuccessResetPassword();
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Appcolor.primary,
                            elevation: 5,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),

                          child: const Text(
                            "Save",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Appcolor.scondary,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// FOOTER
                      Text(
                        "Your password should be unique and secure.",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 13,
                        ),
                      ),
                    ],
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
