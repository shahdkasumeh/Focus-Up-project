import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/reservation/discovering_the_congestion_controller.dart';
import 'package:test/core/class/constant/appcolor.dart';

class DiscoveringTheCongestionScreen
    extends GetView<DiscoveringTheCongestionControllerImp> {
  const DiscoveringTheCongestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "نسبة الازدحام",
          style: TextStyle(color: Appcolor.backgroundcolor),
        ),
        backgroundColor: const Color(0xff2e3a59),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.rooms.isEmpty) {
          return const Center(child: Text("لا توجد بيانات"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.rooms.length,
          itemBuilder: (context, index) {
            final room = controller.rooms[index];

            /// 🔥 اللون حسب status (مو فقط percentage)
            final color = controller.getColorFromStatus(room.status);

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: color, width: 1.5),
                boxShadow: const [
                  BoxShadow(blurRadius: 6, color: Colors.black12),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// اسم القاعة
                  Text(
                    room.roomName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// progress bar (يبقى حسب percentage)
                  LinearProgressIndicator(
                    value: room.percentage / 100,
                    color: color,
                    backgroundColor: Colors.grey.shade300,
                  ),

                  const SizedBox(height: 8),

                  /// نسبة الازدحام
                  Text("نسبة الازدحام: ${room.percentage.toStringAsFixed(1)}%"),

                  const SizedBox(height: 6),

                  /// الطاولات
                  Text(
                    "الطاولات المشغولة: ${room.occupiedTables} / ${room.totalTables}",
                  ),

                  const SizedBox(height: 6),

                  /// 🔥 status ظاهر للمستخدم
                  Text(
                    "الحالة: ${room.status}",
                    style: TextStyle(fontWeight: FontWeight.bold, color: color),
                  ),

                  const SizedBox(height: 6),

                  /// الرسالة
                  Text(
                    room.message,
                    style: TextStyle(fontSize: 13, color: color),
                  ),

                  const SizedBox(height: 12),

                  /// زر الطاولات
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        controller.goToRoom(room.roomId);
                      },
                      child: const Text(
                        "عرض الطاولات",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
    // Scaffold(
    //   appBar: AppBar(
    //     leading: const BackButton(color: Colors.white),
    //     title: const Text(
    //       "نسبة الازدحام",
    //       style: TextStyle(color: Appcolor.backgroundcolor),
    //     ),
    //     backgroundColor: Color(0xff2e3a59),
    //   ),

    //   body: Obx(() {
    //     if (controller.isLoading.value) {
    //       return const Center(child: CircularProgressIndicator());
    //     }

    //     if (controller.rooms.isEmpty) {
    //       return const Center(child: Text("لا توجد بيانات"));
    //     }

    //     return ListView.builder(
    //       padding: const EdgeInsets.all(16),
    //       itemCount: controller.rooms.length,
    //       itemBuilder: (context, index) {
    //         final room = controller.rooms[index];

    //         /// 🔥 اللون حسب النسبة
    //         final color = controller.getCardColor(room.percentage);

    //         return Container(
    //           margin: const EdgeInsets.only(bottom: 12),
    //           padding: const EdgeInsets.all(16),
    //           decoration: BoxDecoration(
    //             color: color.withOpacity(0.12),
    //             borderRadius: BorderRadius.circular(16),
    //             border: Border.all(color: color, width: 1.5),
    //             boxShadow: const [
    //               BoxShadow(blurRadius: 6, color: Colors.black12),
    //             ],
    //           ),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               /// اسم القاعة
    //               Text(
    //                 room.roomName,
    //                 style: const TextStyle(
    //                   fontSize: 18,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               ),

    //               const SizedBox(height: 10),

    //               /// progress bar
    //               LinearProgressIndicator(
    //                 value: room.percentage / 100,
    //                 color: color,
    //                 backgroundColor: Colors.grey.shade300,
    //               ),

    //               const SizedBox(height: 8),

    //               /// نسبة الازدحام
    //               Text("نسبة الازدحام: ${room.percentage.toStringAsFixed(1)}%"),

    //               const SizedBox(height: 6),

    //               /// الطاولات
    //               Text(
    //                 "الطاولات المشغولة: ${room.occupiedTables} / ${room.totalTables}",
    //               ),

    //               const SizedBox(height: 6),

    //               /// الرسالة
    //               Text(
    //                 room.message,
    //                 style: TextStyle(fontSize: 13, color: color),
    //               ),

    //               const SizedBox(height: 12),

    //               /// زر الطاولات
    //               SizedBox(
    //                 width: double.infinity,
    //                 child: ElevatedButton(
    //                   style: ElevatedButton.styleFrom(
    //                     backgroundColor: color,
    //                     shape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.circular(10),
    //                     ),
    //                   ),
    //                   onPressed: () {
    //                     controller.goToRoom(room.roomId);
    //                   },
    //                   child: const Text(
    //                     "عرض الطاولات",
    //                     style: TextStyle(color: Colors.white),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         );
    //       },
    //     );
    //   }),
    // );
  
