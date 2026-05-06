import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:test/core/class/constant/appcolor.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 28),

      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF5E78D9), Appcolor.scondary],

          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),

      child: Row(
        children: [
          InkWell(
            onTap: () => Get.back(),

            borderRadius: BorderRadius.circular(14),

            child: Container(
              width: 48,
              height: 48,

              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.12),

                borderRadius: BorderRadius.circular(14),

                border: Border.all(color: Colors.white.withOpacity(.25)),
              ),

              child: const Icon(
                Icons.arrow_back_ios_new,

                color: Colors.white,
                size: 18,
              ),
            ),
          ),

          const Spacer(),

          const Column(
            children: [
              Text(
                'الباقات',

                style: TextStyle(
                  color: Colors.white,

                  fontSize: 28,

                  fontWeight: FontWeight.w800,
                ),
              ),

              SizedBox(height: 6),

              Text(
                'اختر الباقة المناسبة لك  ',

                style: TextStyle(color: Colors.white70, fontSize: 15),
              ),
            ],
          ),

          const Spacer(),

          const SizedBox(width: 48),
        ],
      ),
    );
  }
}
