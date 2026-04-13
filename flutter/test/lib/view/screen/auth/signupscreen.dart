// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:test/controller/auth/signupcontroller.dart';
// import 'package:test/core/class/constant/appcolor.dart';
// import 'package:test/core/function/alertexitapp.dart';
// import 'package:test/core/function/validinput.dart';
// import 'package:test/view/widget/auth/custombuttonauth.dart';
// import 'package:test/view/widget/auth/customtextformauth.dart';
// import 'package:test/view/widget/auth/textfocusup.dart';
// import 'package:test/view/widget/auth/textsignup.dart';

// class Signupscreen extends StatelessWidget {
//   const Signupscreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Get.lazyPut(() => SignUpControllerImp());
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text("Create Account", style: TextStyle(color: Colors.white)),
//         toolbarHeight: 40.0,
//         backgroundColor: Appcolor.scondary,
//       ),
//       body: GetBuilder<SignUpControllerImp>(
//         builder: (controller) => WillPopScope(
//           onWillPop: alertExitApp,
//           child: Container(
//             padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
//             child: Form(
//               key: controller.formstate,
//               child: ListView(
//                 children: [
//                   SizedBox(height: 10),

//                   Center(child: Textfocusup()),
//                   SizedBox(height: 30),
//                   Customtextformauth(
//                     valid: (val) {
//                       return validInput(val!, 4, 20, "FullName");
//                     },
//                     isNumber: false,
//                     mycontroller: controller.fullname,
//                     hinttext: "Enter Your FullName",
//                     iconData: Icons.person_outlined,
//                     labeltext: "FullName",
//                   ),
//                   Customtextformauth(
//                     valid: (val) {
//                       return validInput(val!, 5, 50, "email");
//                     },
//                     isNumber: false,
//                     mycontroller: controller.email,

//                     hinttext: "Enter Your Email",
//                     iconData: Icons.email_outlined,
//                     labeltext: "Email",
//                   ),
//                   Customtextformauth(
//                     valid: (val) {
//                       return validInput(val!, 5, 10, "phone");
//                     },
//                     mycontroller: controller.phone,
//                     isNumber: true,
//                     hinttext: "Enter Your Phone",
//                     iconData: Icons.phone_android_outlined,
//                     labeltext: "Phone",
//                   ),
//                   GetBuilder<SignUpControllerImp>(
//                     builder: (controller) => Customtextformauth(
//                       valid: (val) {
//                         return validInput(val!, 8, 15, "password");
//                       },
//                       onTapIcon: () {
//                         controller.showPassword();
//                         controller.tooglePasswoed();
//                       },
//                       obscureText: controller.isshowPassword,
//                       isNumber: false,
//                       mycontroller: controller.password,
//                       hinttext: "Enter Your password",
//                       iconData: controller.isHidden
//                           ? Icons.visibility_off_outlined
//                           : Icons.visibility,
//                       labeltext: "password",
//                     ),
//                   ),
//                   GetBuilder<SignUpControllerImp>(
//                     builder: (controller) => Customtextformauth(
//                       valid: (val) {
//                         return validInput(val!, 8, 15, "Confirm password");
//                       },
//                       onTapIcon: () {
//                         controller.showPassword();
//                         controller.tooglePasswoed();
//                       },
//                       obscureText: controller.isshowPassword,
//                       isNumber: false,
//                       mycontroller: controller.password,
//                       hinttext: "Enter Your Confirm password",
//                       iconData: controller.isHidden
//                           ? Icons.visibility_off_outlined
//                           : Icons.visibility,
//                       labeltext: "Confirm password",
//                     ),
//                   ),
//                   Custombuttonauth(
//                     onPressed: () {
//                       controller.signUP();
//                     },
//                     text: "Sign Up",
//                   ),
//                   //  SizedBox(height: 10),
//                   Textsignup(
//                     onTap: () {
//                       controller.goToSignIn();
//                     },
//                     textone: " have an account ?",
//                     texttwo: "Sign In",
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
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
    Get.put(SignUpControllerImp());

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
