import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/reservation/discovering_the_congestion_controller.dart';
import 'package:test/view/widget/reservation/empty_state.dart';
import 'package:test/view/widget/reservation/header_discovering.dart';

class DiscoveringTheCongestionScreen
    extends GetView<DiscoveringTheCongestionControllerImp> {
  const DiscoveringTheCongestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      body: Column(
        children: [
          const HeaderDiscovering(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xff2e3a59)),
                );
              }

              if (controller.rooms.isEmpty) {
                return ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: const [SizedBox(height: 180), EmptyState()],
                );
              }

              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
                itemCount: controller.rooms.length,
                itemBuilder: (context, index) {
                  final room = controller.rooms[index];
                  final color = controller.getColorFromString(room.color);
                  final percentage = room.percentage.clamp(0, 100).toDouble();

                  return _CongestionCard(
                    color: color,
                    roomName: room.roomName,
                    percentage: percentage,
                    occupiedTables: room.occupiedTables,
                    totalTables: room.totalTables,
                    status: room.status,
                    message: room.message,
                    onPressed: () {
                      controller.goToRoom(room.roomId);
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
class _CongestionCard extends StatelessWidget {
  final Color color;
  final String roomName;
  final double percentage;
  final int occupiedTables;
  final int totalTables;
  final String status;
  final String message;
  final VoidCallback onPressed;

  const _CongestionCard({
    required this.color,
    required this.roomName,
    required this.percentage,
    required this.occupiedTables,
    required this.totalTables,
    required this.status,
    required this.message,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final progressValue = percentage / 100;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: color.withValues(alpha: 0.22), width: 1.3),
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            offset: const Offset(0, 8),
            color: Colors.black.withValues(alpha: 0.06),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  Icons.meeting_room_outlined,
                  color: color,
                  size: 30,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      roomName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Color(0xff172F4F),
                        fontSize: 19,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "الطاولات المشغولة: $occupiedTables / $totalTables",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Row(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${percentage.toStringAsFixed(1)}%",
                style: TextStyle(
                  color: color,
                  fontSize: 34,
                  height: 1,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(width: 7),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  "ازدحام",
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  children: [
                    Icon(Icons.circle, color: color, size: 10),
                    const SizedBox(width: 7),
                    Text(
                      status,
                      style: TextStyle(
                        color: color,
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: LinearProgressIndicator(
              value: progressValue,
              minHeight: 11,
              backgroundColor: const Color(0xffE8ECF3),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),

          const SizedBox(height: 14),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                Icon(Icons.info_outline_rounded, color: color, size: 20),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    message,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: onPressed,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                textDirection: TextDirection.rtl,
                children: [
                  Icon(
                    Icons.table_restaurant_outlined,
                    color: Colors.white,
                    size: 21,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "عرض الطاولات",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
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
