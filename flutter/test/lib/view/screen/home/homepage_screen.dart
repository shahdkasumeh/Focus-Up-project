import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:test/controller/home/homepagecontroller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/view/widget/home/bottom_bar.dart';
import 'package:test/view/widget/home/services_tile.dart';

class HomepageScreen extends GetView<HomePageControllerImp> {
  const HomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageControllerImp());

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      bottomNavigationBar: BottomBar(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Appcolor.scondary,
            elevation: 0,
            floating: true,
            snap: true,
            title: Text(
              'FoucsUP',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            actions: const [Padding(padding: EdgeInsets.only(right: 16))],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 18),

                  const Text(
                    'الخدمات',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                  ),

                  const SizedBox(height: 12),

                  ServicesTile(
                    title: 'الحجز',
                    subtitle: 'ابدأ حجزك الآن',
                    icon: Icons.event_seat_rounded,
                    color: const Color(0xFF3B82F6),
                    onTap: controller.goToTypeBooking,
                    featured: true,
                  ),

                  ServicesTile(
                    title: 'رمز الدراسة',
                    subtitle: 'دخول سريع للمكان',
                    icon: Icons.qr_code_rounded,
                    color: const Color(0xFF22C55E),
                    onTap: controller.goToQrCode,
                  ),

                  ServicesTile(
                    title: 'رفيق الدراسة',
                    subtitle: 'شارك تجربتك',
                    icon: Icons.person_rounded,
                    color: const Color(0xFFF97316),
                    onTap: controller.goToStudyCompanion,
                  ),

                  ServicesTile(
                    title: 'عجلة الحظ',
                    subtitle: 'جرب حظك الآن',
                    icon: Icons.casino_rounded,
                    color: const Color(0xFFA855F7),
                    onTap: controller.goToLuckyWheel,
                  ),

                  ServicesTile(
                    title: 'الباقات',
                    subtitle: 'اختر الباقة المناسبة',
                    icon: Icons.workspace_premium_rounded,
                    color: const Color(0xFFEF4444),
                    onTap: () {
                      controller.goToPackages();
                    },
                  ),

                  ServicesTile(
                    title: 'المهام',
                    subtitle: 'تابع إنجازك',
                    icon: Icons.task_alt_rounded,
                    color: const Color(0xFF0EA5E9),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
