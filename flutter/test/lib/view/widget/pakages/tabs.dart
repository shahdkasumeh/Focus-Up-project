import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/home/pakages_controller.dart';
import 'package:test/core/class/constant/appcolor.dart';

class Tabs extends GetView<PackagesController> {
  const Tabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),

      child: Obx(
        () => Row(
          children: List.generate(controller.tabs.length, (index) {
            final selected = controller.selectedTab.value == index;

            return Expanded(
              child: GestureDetector(
                onTap: () => controller.changeTab(index),

                child: Container(
                  height: 62,

                  margin: const EdgeInsets.symmetric(horizontal: 4),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(16),

                    border: Border.all(
                      color: selected
                          ? Appcolor.primary
                          : const Color(0xFFE2E2E2),

                      width: selected ? 1.7 : 1,
                    ),
                  ),

                  child: Center(
                    child: Text(
                      controller.tabs[index],

                      textAlign: TextAlign.center,

                      style: TextStyle(
                        color: selected
                            ? Appcolor.primary
                            : const Color(0xFF454545),

                        fontSize: 14,

                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
