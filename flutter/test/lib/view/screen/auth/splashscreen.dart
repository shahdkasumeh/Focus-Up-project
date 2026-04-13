import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/auth/splashcontroller.dart';
import 'package:test/core/class/constant/imageassets.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Image.asset(Imageassets.logo, width: 150, height: 150),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
