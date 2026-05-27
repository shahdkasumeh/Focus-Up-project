import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/reservation/type_booking_controller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/view/widget/typeofbooking/buildbookingcard.dart';

class TypebookingScreen extends GetView<TypeBookingControllerImp> {
  const TypebookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader()),
            SliverToBoxAdapter(
              child: Transform.translate(
                offset: const Offset(0, -18),
                child: Column(
                  children: [
                    const SizedBox(height: 40),

                    Buildbookingcard(
                      icon: Icons.event_seat_rounded,
                      color: Appcolor.primary,
                      text: "حجز طاولة",
                      text2:
                          "اختاري طاولتك ضمن بيئة هادئة مصممة لزيادة التركيز والإنجاز الفردي.",
                      text3: "اختيار الطاولة",
                      backgroundColor: Appcolor.scondary,
                      onPressed: () {
                        controller.goToDiscoveringTheCongestion();
                      },
                    ),
                    const SizedBox(height: 20),
                    Buildbookingcard(
                      icon: Icons.meeting_room_rounded,
                      color: Appcolor.primary,
                      text: "قاعة بدون حجز",
                      text2:
                          "ادخلي مباشرة إلى القاعة المتاحة وتحققي من نسبة الازدحام قبل الدخول.",
                      text3: "معرفة الازدحام",
                      backgroundColor: Appcolor.scondary,
                      onPressed: () {
                        controller.goToThehallWithoutAReservation();
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 225,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Appcolor.primaryColor,
            Appcolor.scondary.withValues(alpha: 0.90),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(36),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Positioned(
              left: -35,
              top: 12,
              child: Container(
                width: 125,
                height: 125,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.04),
                ),
              ),
            ),
            Positioned(
              right: -38,
              bottom: -35,
              child: Container(
                width: 135,
                height: 135,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Appcolor.primary.withValues(alpha: 0.13),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 10, 22, 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    textDirection: TextDirection.ltr,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.13),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => Get.back(),
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 19,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Row(
                    children: [
                      Icon(
                        Icons.chair_alt_rounded,
                        color: Appcolor.primary,
                        size: 27,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "اختر نوع الحجز",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "اختاري الطريقة الأنسب للدراسة والتركيز",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withValues(alpha: 0.78),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
