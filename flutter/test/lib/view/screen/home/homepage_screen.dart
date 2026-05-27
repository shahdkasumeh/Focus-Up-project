import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/home/homepagecontroller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/view/widget/home/bottom_bar.dart';
import 'package:test/view/widget/home/home_header.dart';
import 'package:test/view/widget/home/service_card.dart';

class HomepageScreen extends GetView<HomePageControllerImp> {
  const HomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomePageControllerImp homeController = Get.put(
      HomePageControllerImp(),
    );

    return Scaffold(
      backgroundColor: Appcolor.backgroundColor,
      bottomNavigationBar: BottomBar(),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 292,
            pinned: true,
            elevation: 0,
            backgroundColor: Appcolor.primaryColor,
            surfaceTintColor: Appcolor.primaryColor,
            automaticallyImplyLeading: false,
            title: const Text(
              'FocusUP',
              style: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 18, top: 8, bottom: 8),
                width: 43,
                height: 43,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.notifications_none_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: HomeHeader(
                onBookingTap: homeController.goToTypeBooking,
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(18, 24, 18, 105),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'الخدمات',
                      style: TextStyle(
                        fontSize: 20,
                        color: Appcolor.primaryColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'اختر خدمتك',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF8C97A8),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 1.03,
                  children: [
                    ServiceCard(
                      title: 'الحجز',
                      subtitle: 'احجز طاولتك',
                      icon: Icons.event_seat_rounded,
                      iconBackground: const Color(0xFFE8F0FF),
                      iconColor: const Color(0xFF3978F6),
                      onTap: homeController.goToTypeBooking,
                    ),
                    ServiceCard(
                      title: 'رمز الدراسة',
                      subtitle: 'دخول سريع',
                      icon: Icons.qr_code_scanner_rounded,
                      iconBackground: const Color(0xFFE7F8EF),
                      iconColor: const Color(0xFF18A468),
                      onTap: homeController.goToQrCode,
                    ),
                    ServiceCard(
                      title: 'رفيق الدراسة',
                      subtitle: 'شارك تجربتك',
                      icon: Icons.forum_rounded,
                      iconBackground: const Color(0xFFFFF0E6),
                      iconColor: const Color(0xFFF07A2B),
                      onTap: homeController.goToStudyCompanion,
                    ),
                    ServiceCard(
                      title: 'عجلة الحظ',
                      subtitle: 'اربح جوائز',
                      icon: Icons.casino_rounded,
                      iconBackground: const Color(0xFFF3EAFE),
                      iconColor: const Color(0xFF9349E7),
                      onTap: homeController.goToLuckyWheel,
                    ),
                    ServiceCard(
                      title: 'الباقات',
                      subtitle: 'اختر باقتك',
                      icon: Icons.workspace_premium_rounded,
                      iconBackground: const Color(0xFFFFEBEA),
                      iconColor: const Color(0xFFE7524B),
                      onTap: homeController.goToPackages,
                    ),
                    ServiceCard(
                      title: 'المهام',
                      subtitle: 'تابع إنجازك',
                      icon: Icons.task_alt_rounded,
                      iconBackground: const Color(0xFFE5F5FC),
                      iconColor: const Color(0xFF129BCB),
                      onTap: homeController.goToTasks,
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
