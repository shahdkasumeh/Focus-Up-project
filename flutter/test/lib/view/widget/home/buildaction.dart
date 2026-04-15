import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/home/homepagecontroller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/view/widget/home/action_card.dart';

class Buildaction extends StatelessWidget {
  const Buildaction({super.key});

  @override
  Widget build(BuildContext context) {
    HomePageControllerImp controller = Get.put(HomePageControllerImp());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'الخدمات',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.4,
          children: [
            ActionCard(
              label: ' الحجز',
              icon: Icons.event_seat_outlined,
              colors: const [Color(0xFF4E9BFF), Appcolor.scondary],
              onTap: () {
                controller.goToTypeBooking();
              },
            ),
            ActionCard(
              label: 'رمزية الدراسة',
              icon: Icons.qr_code_rounded,
              colors: const [Color(0xFF22C55E), Color(0xFF16A34A)],
              onTap: () {
                controller.goToQrCode();
              },
            ),

            ActionCard(
              label: 'رفيق الدراسة',
              icon: Icons.person,
              colors: const [Color(0xFFFF9B4E), Color(0xFFF07030)],
              onTap: () {
                controller.goToStudyCompanion();
              },
            ),
            ActionCard(
              label: 'البوفيه',
              icon: Icons.local_cafe_outlined,
              colors: const [Color(0xFF2DD4BF), Color(0xFF0D9488)],
              onTap: () => Get.toNamed('/buffet'),
            ),
            ActionCard(
              label: 'عجلة الحظ',
              icon: Icons.casino_outlined,
              colors: const [Color(0xFFA855F7), Color(0xFF7C3AED)],
              onTap: () {
                controller.goToLuckyWheel();
              },
            ),

            // ActionCard(
            //   label: 'البوفيه',
            //   icon: Icons.local_cafe_outlined,
            //   colors: const [Color(0xFF2DD4BF), Color(0xFF0D9488)],
            //   onTap: () => Get.toNamed('/buffet'),
            // ),
            // ActionCard(
            //   label: 'الفعاليات',
            //   icon: Icons.event_outlined,
            //   colors: const [Color(0xFFF87171), Color(0xFFDC2626)],
            //   onTap: () => Get.toNamed('/events'),
            // ),
          ],
        ),
      ],
    );
  }
}
