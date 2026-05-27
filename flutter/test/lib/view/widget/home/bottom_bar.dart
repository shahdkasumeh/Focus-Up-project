import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/core/class/constant/routes.dart';
import 'package:test/view/widget/home/bottom_nav_item.dart';

class BottomBar extends StatelessWidget {
  final int currentIndex;

  const BottomBar({super.key, this.currentIndex = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 18,
        right: 18,
        top: 9,
        bottom: MediaQuery.of(context).padding.bottom > 0
            ? MediaQuery.of(context).padding.bottom
            : 9,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(26),
          topRight: Radius.circular(26),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x10162F50),
            blurRadius: 18,
            offset: Offset(0, -6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: BottomNavItem(
              title: 'الرئيسية',
              icon: Icons.home_rounded,
              isSelected: currentIndex == 0,
              onTap: () {
                if (currentIndex != 0) {
                  Get.back();
                }
              },
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: BottomNavItem(
              title: 'حسابي',
              icon: Icons.person_outline_rounded,
              isSelected: currentIndex == 1,
              onTap: () {
                if (currentIndex != 1) {
                  Get.toNamed(AppRoutes.profilescreen);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
