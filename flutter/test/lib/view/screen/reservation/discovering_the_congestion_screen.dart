import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:test/controller/reservation/discovering_the_congestion_controller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/view/screen/reservation/Hall_congestion_card.dart';

class DiscoveringTheCongestionScreen
    extends GetView<DiscoveringTheCongestionControllerImp> {
  const DiscoveringTheCongestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.rooms.isEmpty) {
          return const Center(child: Text("لا توجد بيانات حالياً"));
        }

        return CustomScrollView(
          slivers: [
            /// AppBar
            SliverAppBar(
              title: const Text(
                'اكتشاف الازدحام',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              floating: true,
              snap: true,
              elevation: 0,
              backgroundColor: Appcolor.fourthColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Get.back(),
              ),
            ),

            /// Content
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final room = controller.rooms[index];

                  final percent = (room.percentage ?? 0).toDouble();

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: HallCongestionCard(
                      name: room.roomName ?? "",
                      percent: percent,
                      occupied: room.occupiedTables ?? 0,
                      total: room.capacity ?? 0,
                      colors: [
                        controller.getColor(percent),
                        controller.getColor(percent),
                      ],
                      message: controller.getMessage(percent),
                      onTap: () {
                        controller.goToRoom(room.roomId ?? 0);
                      },
                    ),
                  );
                }, childCount: controller.rooms.length),
              ),
            ),
          ],
        );
      }),
    );
  }
}
