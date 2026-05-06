import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/home/pakages_controller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/view/widget/pakages/row.dart';

class MyCurrentPackageView extends GetView<PackagesController> {
  const MyCurrentPackageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isCurrentPackageLoading.value) {
        return const Center(
          child: CircularProgressIndicator(color: Appcolor.accentPurpleColor),
        );
      }

      final currentPackage = controller.currentPackage.value;

      if (currentPackage == null) {
        return const Center(
          child: Text(
            'لا توجد باقة حالية',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }

      return RefreshIndicator(
        color: Appcolor.accentPurpleColor,
        onRefresh: controller.getCurrentPackage,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.06),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'باقتي الحالية',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 16),

                  Rows(title: 'status', value: currentPackage.status),
                  Rows(
                    title: 'TotalHours',
                    value: '${currentPackage.totalHours} ساعة',
                  ),
                  Rows(
                    title: 'RemainingHours',
                    value: '${currentPackage.remainingHours} ساعة',
                  ),
                  Rows(
                    title: 'UsedHours',
                    value: '${currentPackage.usedHours} ساعة',
                  ),
                  Rows(
                    title: 'TotalPrice',
                    value: '${currentPackage.totalPrice} ل.س',
                  ),
                  Rows(
                    title: 'RemainingPrice',
                    value: '${currentPackage.remainingPrice} ل.س',
                  ),
                  Rows(title: 'startsAt', value: currentPackage.startsAt),
                  Rows(title: 'expiresAt', value: currentPackage.expiresAt),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
