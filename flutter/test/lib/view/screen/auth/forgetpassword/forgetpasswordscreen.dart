import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:test/controller/auth/forgetpasswordcontroller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/core/function/validinput.dart';
import 'package:test/view/widget/auth/customtextformauth.dart';

class Forgetpasswordscreen extends GetView<ForgetPasswordControllerImp> {
  const Forgetpasswordscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Appcolor.scondary,
        leading: const BackButton(color: Colors.white),
      ),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),

            child: Form(
              key: controller.formstate,

              child: Container(
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

                    const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Appcolor.scondary,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      "Don't worry! Enter your email address and we'll send you a verification code.",
                      textAlign: TextAlign.center,

                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade600,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 40),

                    Customtextformauth(
                      valid: (val) {
                        return validInput(val!, 5, 50, "email");
                      },

                      isNumber: false,
                      mycontroller: controller.email,
                      hinttext: "Enter your email",
                      iconData: Icons.email_outlined,
                      labeltext: "Email",
                    ),

                    const SizedBox(height: 35),

                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.checkEmail();
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Appcolor.primary,
                          elevation: 5,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),

                        child: const Text(
                          "Continue",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Appcolor.scondary,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      "We'll help you recover your account quickly.",
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
    );
  }
}
