import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/reservation/crowded_hall_with_out_reservation_controller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/view/widget/pakages/info_box.dart';

class CrowdedHallWithoutReservation extends GetView<CrowdedHallWithOutReservationControllerImp> {
  CrowdedHallWithoutReservation({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final room = controller.room.value;

        if (room == null) {
          return const Center(
            child: Text(
              "لا توجد بيانات",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
        }
        final color = controller.getColor(room.percentage);
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 190,
              pinned: true,
              elevation: 0,
              backgroundColor: Appcolor.primaryColor,
              leading: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.20)),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                    onPressed: () => Get.back(),
                  ),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: const Text(
                  "نسبة الازدحام",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF0B1F3A), Color(0xFF123C69)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.groups_rounded,
                      color: Appcolor.primary,
                      size: 70,
                    ),
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 25,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 95,
                            width: 95,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: color.withValues(alpha: 0.12),
                              border: Border.all(color: color, width: 2),
                            ),
                            child: Center(
                              child: Text(
                                "${room.percentage.toStringAsFixed(0)}%",
                                style: TextStyle(
                                  color: color,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 18),
                          Text(
                            room.roomName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0B1F3A),
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            room.message,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: color,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 24),

                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: LinearProgressIndicator(
                              value: room.percentage / 100,
                              minHeight: 14,
                              color: color,
                              backgroundColor: Colors.grey.shade200,
                            ),
                          ),

                          const SizedBox(height: 24),

                          Row(
                            children: [
                              Expanded(
                                child: InfoBox(
                                  title: "الموجود داخل",
                                  value: "${room.currentInside}",
                                  icon: Icons.person_rounded,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: InfoBox(
                                  title: "السعة الكلية",
                                  value: "${room.capacity}",
                                  icon: Icons.event_seat_rounded,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 18),

                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.10),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: color.withValues(alpha: 0.5),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.circle, color: color, size: 12),
                                const SizedBox(width: 8),
                                Text(
                                  "الحالة: ${room.status}",
                                  style: TextStyle(
                                    color: color,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
