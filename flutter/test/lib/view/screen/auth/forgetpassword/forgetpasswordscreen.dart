import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:test/controller/auth/forgetpasswordcontroller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/core/function/validinput.dart';
import 'package:test/view/widget/auth/buildicon.dart';
import 'package:test/view/widget/auth/custombodytitle.dart';
import 'package:test/view/widget/auth/custombuttonauth.dart';
import 'package:test/view/widget/auth/customtextformauth.dart';
import 'package:test/view/widget/auth/customtexttitleauth.dart';

class Forgetpasswordscreen extends GetView<ForgetPasswordControllerImp> {
  const Forgetpasswordscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 40.0,
        backgroundColor: Appcolor.scondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.vertical(
            top: Radius.elliptical(10, 10),
          ),
        ),
        leading: BackButton(color: Colors.white),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Form(
          key: controller.formstate,
          child: ListView(
            children: [
              SizedBox(height: 50),
              Buildicon(iconData: Icons.lock_outline_rounded),

              Customtexttitleauth(text: "Check email"),
              Custombodytitle(text: "Sign Up With Your Email  OR Continue "),
              SizedBox(height: 40),

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

              Custombuttonauth(
                onPressed: () {
                  controller.checkEmail();
                },
                text: "Check ",
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
