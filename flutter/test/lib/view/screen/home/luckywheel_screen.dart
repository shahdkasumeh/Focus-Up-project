import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/home/luckywheel_controller.dart';
import 'package:test/view/widget/luckywheel/wheelpainter.dart';

class LuckywheelScreen extends GetView<LuckyWheelControllerImp> {
  const LuckywheelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A3A5C),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'عجلة الحظ',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
              _tabs(),

              const SizedBox(height: 25),

              if (controller.selectedTab.value == 0) _wheelTab(),

              if (controller.selectedTab.value == 1) _myPrizesTab(),

              if (controller.selectedTab.value == 2) _currentPrizeTab(),
            ],
          ),
        );
      }),
    );
  }

  Widget _tabs() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
      ),
      child: Row(
        children: [
          _tabButton(title: 'العجلة', index: 0),
          _tabButton(title: 'الجوائز', index: 1),
          _tabButton(title: 'الخصم الحالي', index: 2),
        ],
      ),
    );
  }

  Widget _tabButton({required String title, required int index}) {
    final isSelected = controller.selectedTab.value == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          controller.selectedTab.value = index;
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 13),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? const Color(0xFF1A3A5C) : Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _wheelTab() {
    return Column(
      children: [
        const SizedBox(height: 10),

        Center(
          child: AnimatedRotation(
            turns: controller.turns.value,
            duration: const Duration(seconds: 3),
            curve: Curves.easeOutBack,
            child: SizedBox(
              width: 270,
              height: 270,
              child: CustomPaint(
                painter: WheelPainter(prizes: controller.prizes.toList()),
              ),
            ),
          ),
        ),

        const SizedBox(height: 34),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed:
                  controller.canSpin.value &&
                      !controller.isSpinning.value &&
                      controller.prizes.isNotEmpty
                  ? controller.spin
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                disabledBackgroundColor: Colors.white.withValues(alpha: 0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: controller.isSpinning.value
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Color(0xFF1A3A5C),
                      ),
                    )
                  : Text(
                      controller.canSpin.value
                          ? 'لف العجلة'
                          : 'لا يمكنك اللف الآن',
                      style: const TextStyle(
                        color: Color(0xFF1A3A5C),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        _infoCard(
          title: 'الحجوزات المكتملة هذا الأسبوع',
          value: controller.completedBookings.value.toString(),
        ),

        const SizedBox(height: 12),

        _infoCard(
          title: 'المتبقي حتى اللفة القادمة',
          value: controller.remainingBookings.value.toString(),
        ),

        const SizedBox(height: 14),

        Text(
          controller.canSpin.value
              ? 'يمكنك تدوير العجلة الآن'
              : 'تحتاجين ٣ حجوزات بالأسبوع لتدوير العجلة',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
      ],
    );
  }

  Widget _myPrizesTab() {
    if (controller.myPrizes.isEmpty) {
      return _emptyBox('لا يوجد الجوائز حصلت عليها بعد');
    }

    return Column(
      children: [
        ...controller.myPrizes.map((item) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white.withOpacity(0.12)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.local_offer_rounded,
                  color: Colors.white,
                  size: 22,
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    item.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),

                Text(
                  item.value,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _currentPrizeTab() {
    final discounts = controller.currentPrizes
        .where((item) => item.name.toLowerCase().trim() == 'discount')
        .toList();

    if (discounts.isEmpty) {
      return _emptyBox('لا يوجد خصم حالي');
    }

    return Column(
      children: discounts.map((item) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white.withOpacity(0.12)),
          ),
          child: Column(
            children: [
              const Icon(
                Icons.local_offer_rounded,
                color: Color(0xFFF5A623),
                size: 44,
              ),
              const SizedBox(height: 14),
              const Text(
                'الخصم الحالي',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 14),
              Text(
                item.value,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _infoCard({required String title, required String value}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyBox(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
