import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/reservation/type_booking_controller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/view/widget/typeofbooking/build_header.dart';
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
            SliverToBoxAdapter(child: BuildHeader()),
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
}

