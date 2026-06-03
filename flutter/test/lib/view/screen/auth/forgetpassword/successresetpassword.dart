import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:test/controller/auth/sucessresetpassword.dart';
import 'package:test/core/class/constant/appcolor.dart';

class Successresetpassword extends GetView<SucessResetPasswordControllerImp> {
  const Successresetpassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Appcolor.scondary,
      ),

      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),

            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),

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
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// SUCCESS ICON
                  Container(
                    height: 140,
                    width: 140,

                    decoration: BoxDecoration(
                      shape: BoxShape.circle,

                      gradient: LinearGradient(
                        colors: [
                          Appcolor.scondary,
                          Appcolor.scondary.withValues(alpha: 0.5),
                        ],
                      ),
                    ),

                    child: const Icon(
                      Icons.check_rounded,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 35),

                  /// TITLE
                  const Text(
                    "Password Reset Successful",
                    textAlign: TextAlign.center,

                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Appcolor.scondary,
                    ),
                  ),

                  const SizedBox(height: 18),

                  /// DESCRIPTION
                  Text(
                    "Your password has been changed successfully. You can now log in with your new password.",
                    textAlign: TextAlign.center,

                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade600,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 35),

                  /// BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 48,

                    child: ElevatedButton(
                      onPressed: () {
                        controller.goToPageLogin();
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Appcolor.primary,
                        elevation: 5,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),

                      child: const Text(
                        "Go To Login",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  /// FOOTER
                  Text(
                    "Your account is secure now.",
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
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
