import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/home/luckywheel_controller.dart';
import 'package:test/view/widget/luckywheel/current_prize_tab.dart';
import 'package:test/view/widget/luckywheel/my_prizes_tab.dart';
import 'package:test/view/widget/luckywheel/tabs_wheel.dart';
import 'package:test/view/widget/luckywheel/wheel_tab.dart';

class LuckywheelScreen extends GetView<LuckyWheelControllerImp> {
  const LuckywheelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B2A45),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'عجلة الحظ',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          child: Column(
            children: [
              TabsWheel(controller: controller),
              const SizedBox(height: 25),

              if (controller.selectedTab.value == 0)
                WheelTab(controller: controller),
              if (controller.selectedTab.value == 1)
                MyPrizesTab(controller: controller),
              if (controller.selectedTab.value == 2)
                CurrentPrizeTab(controller: controller),
            ],
          ),
        );
      }),
    );
  }
}
