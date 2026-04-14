import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
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
    Get.put(DiscoveringTheCongestionControllerImp());
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
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

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: HallCongestionCard(
                      name: room.roomName,
                      percent: room.percentage,
                      occupied: room.currentOccupancy,
                      total: room.capacity,
                      colors: [
                        controller.getColor(room.percentage),
                        controller.getColor(room.percentage),
                      ],
                      message: controller.getMessage(room.percentage),
                      onTap: () {
                        controller.goToRoom(room.id);
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
