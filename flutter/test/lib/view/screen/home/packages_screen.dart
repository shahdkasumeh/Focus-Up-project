import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/home/pakages_controller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/view/screen/home/my_current_package_view.dart';
import 'package:test/view/screen/home/my_packages_view.dart';
import 'package:test/view/widget/pakages/header.dart';
import 'package:test/view/widget/pakages/package_card.dart';
import 'package:test/view/widget/pakages/tabs.dart';

class PackagesScreen extends GetView<PackagesController> {
  const PackagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FB),
      body: Column(
        children: [
          Header(),
          const SizedBox(height: 22),

          Tabs(),

          const SizedBox(height: 24),

          Expanded(
            child: Obx(() {
              /// الشخصية
              if (controller.selectedTab.value == 0) {
                return const MyPackagesView();
              }

              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: Appcolor.primary),
                );
              }

              /// الاشتراك
              if (controller.selectedTab.value == 1) {
                if (controller.packagesToBuy.isEmpty) {
                  return const Center(
                    child: Text(
                      'لا توجد باقات للاشتراك حالياً',

                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }

                return RefreshIndicator(
                  color: Appcolor.scondary,

                  onRefresh: controller.getPackagesToBuy,

                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),

                    itemCount: controller.packagesToBuy.length,

                    itemBuilder: (context, index) {
                      return PackageCard(
                        package: controller.packagesToBuy[index],
                      );
                    },
                  ),
                );
              }

              /// الحالية
              if (controller.selectedTab.value == 2) {
                return const MyCurrentPackageView();
              }
              return const SizedBox();
            }),
          ),
        ],
      ),
    );
  }
}
