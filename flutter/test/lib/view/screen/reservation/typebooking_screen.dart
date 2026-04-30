import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:test/controller/reservation/type_booking_controller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/view/widget/typeofbooking/buildbookingcard.dart';

class TypebookingScreen extends GetView<TypeBookingControllerImp> {
  const TypebookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: BackButton(color: Colors.white),

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
                      icon: Icons.event_seat_outlined,
                      color: Appcolor.scondary,
                      text: "حجز طاولة",
                      text2: ".بيئة هادئة مصممة لزيادة تركيز او الأنجاز الفردي",
                      text3: "أختيار الطاولة",
                      backgroundColor: Appcolor.scondary,
                      onPressed: () {
                        controller.goToDiscoveringTheCongestion();
                      },
                    ),
                    const SizedBox(height: 30),
                    Buildbookingcard(
                      color: Appcolor.scondary,
                      icon: Icons.meeting_room,
                      text: "قاعة من دون حجز ",
                      text2: "هذه القاعة متاحة للدخول الفوري دون حجز مسبق",
                      text3: "لمعرفة أزدحام القاعة",
                      backgroundColor: Appcolor.scondary,
                      onPressed: () {
                        controller.goToThehallWithoutAReservation();
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
