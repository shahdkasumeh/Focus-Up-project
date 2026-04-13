import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:test/controller/reservation/type_booking_controller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/view/widget/typeofbooking/buildbookingcard.dart';

class TypebookingScreen extends GetView<TypeBookingControllerImp> {
  const TypebookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TypeBookingControllerImp());
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Appcolor.scondary,
              elevation: 0,
              floating: false,
              pinned: false,
              snap: false,
              expandedHeight: 70,
              automaticallyImplyLeading: true,
            ),

            SliverToBoxAdapter(
              child: SafeArea(
                top: false,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Buildbookingcard(
                      color: Appcolor.scondary,
                      icon: Icons.meeting_room,
                      text: "حجز قاعة",
                      text2: "مثالية للاجتماعات، ورش العمل،",
                      text3: "أختيار القاعة",
                      backgroundColor: Appcolor.scondary,
                      onPressed: () {},
                    ),
                    const SizedBox(height: 30),
                    Buildbookingcard(
                      icon: Icons.event_seat_outlined,
                      color: Appcolor.gren,
                      text: "حجز طاولة",
                      text2: ".بيئة هادئة مصممة لزيادة تركيز او الأنجاز الفردي",
                      text3: "أختيار الطاولة",
                      backgroundColor: Appcolor.gren,
                      onPressed: () {
                        controller.goToDiscoveringTheCongestion();
                      },
                    ),
                    const SizedBox(height: 30),
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
