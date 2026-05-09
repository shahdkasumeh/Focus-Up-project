import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:test/core/class/constant/routes.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
  height: 70,
  decoration: const BoxDecoration(
    color: Colors.white,
    border: Border(
      top: BorderSide(
        color: Color(0x11000000),
      ),
    ),
  ),
  child: Row(
    mainAxisAlignment:
        MainAxisAlignment.spaceAround,
    children: [

      /// HOME
      IconButton(
        onPressed: () {

        },
        icon: const Icon(
          Icons.home_rounded,
          color: Colors.black,
        ),
      ),

      // PROFILE
      IconButton(
        onPressed: () {
          Get.toNamed(
            AppRoutes.profilescreen,
          );
        },
        icon: const Icon(
          Icons.person_outline_rounded,
          color: Colors.grey,
        ),
      ),
    ],
  ),
);
  }
}
