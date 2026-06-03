import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:test/controller/auth/resetpasswordcontroller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/core/class/statusrequest.dart';
import 'package:test/core/function/validinput.dart';
import 'package:test/view/widget/auth/customtextformauth.dart';

class Resetpasswordscreen extends GetView<ResetpasswordcontrollerImp> {
  const Resetpasswordscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Appcolor.primaryColor,
        leading: const BackButton(color: Colors.white),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Form(
              key: controller.formstate,
              child: GetBuilder<ResetpasswordcontrollerImp>(
                builder: (controller) {
                  final bool isLoading =
                      controller.statusRequest == StatusRequest.loading;

                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 30,
                    ),
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
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Appcolor.scondary,
                                Appcolor.scondary.withValues(alpha: 0.7),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: const Icon(
                            Icons.password_rounded,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),

                        const SizedBox(height: 28),

                        const Text(
                          "Reset Password",
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: Appcolor.scondary,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          "Enter the verification code sent to your email, then create a new password.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.5,
                            color: Colors.grey.shade600,
                            height: 1.5,
                          ),
                        ),

                        const SizedBox(height: 32),
                        Customtextformauth(
                          valid: (val) {
                            return validInput(val!, 6, 6, "verifycode");
                          },
                          isNumber: true,
                          mycontroller: controller.otp,
                          hinttext: "Enter 6-digit code",
                          labeltext: "Verification Code",
                          iconData: Icons.verified_user_outlined,
                        ),

                        const SizedBox(height: 20),

                        Customtextformauth(
                          valid: (val) {
                            return validInput(val!, 8, 30, "password");
                          },
                          isNumber: false,
                          mycontroller: controller.password,
                          hinttext: "Enter new password",
                          labeltext: "New Password",
                          obscureText: controller.isPasswordHidden,
                          iconData: controller.isPasswordHidden
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,

                          onTapIcon: () {
                            controller.togglePassword();
                          },
                        ),

                        const SizedBox(height: 20),

                        Customtextformauth(
                          valid: (val) {
                            return validInput(val!, 8, 30, "password");
                          },
                          isNumber: false,
                          mycontroller: controller.passwordConfirmation,
                          hinttext: "Confirm new password",
                          labeltext: "Confirm Password",
                          obscureText: controller.isConfirmHidden,

                          iconData: controller.isConfirmHidden
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,

                          onTapIcon: () {
                            controller.toggleConfirmPassword();
                          },
                        ),

                        const SizedBox(height: 32),

                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () {
                                    controller.goToSuccessResetPassword();
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Appcolor.scondary,
                              disabledBackgroundColor: Appcolor.scondary
                                  .withValues(alpha: 0.55),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: isLoading
                                ? const SizedBox(
                                    width: 23,
                                    height: 23,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.4,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    "Reset Password",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 20),
                        Text(
                          "Didn't receive the code? Go back and send it again.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
