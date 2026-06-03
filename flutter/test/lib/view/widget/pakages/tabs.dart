import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/home/pakages_controller.dart';
import 'package:test/core/class/constant/appcolor.dart';

class Tabs extends GetView<PackagesController> {
  const Tabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: 58,
        margin: const EdgeInsets.symmetric(horizontal: 18),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.transparent.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: List.generate(controller.tabs.length, (index) {
            final selected = controller.selectedTab.value == index;

            return Expanded(
              child: GestureDetector(
                onTap: () => controller.changeTab(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOut,
                  height: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: selected ? Appcolor.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(17),
                    boxShadow: selected
                        ? [
                            BoxShadow(
                              color: Appcolor.primaryColor.withValues(
                                alpha: 0.25,
                              ),
                              blurRadius: 12,
                              offset: const Offset(0, 5),
                            ),
                          ]
                        : [],
                  ),
                  child: Center(
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 220),
                      style: TextStyle(
                        color: selected
                            ? Appcolor.backgroundColor
                            : const Color(0xFF6A6A6A),
                        fontSize: 13,
                        fontWeight: selected
                            ? FontWeight.w900
                            : FontWeight.w700,
                      ),
                      child: Text(
                        controller.tabs[index],
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
