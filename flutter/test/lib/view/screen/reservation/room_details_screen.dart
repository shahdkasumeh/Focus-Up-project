import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/reservation/room_details_controller.dart';
import 'package:test/controller/reservation/booking_controller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/view/widget/typeofbooking/fancy_card.dart';

class RoomDetailsScreen extends StatelessWidget {
  RoomDetailsScreen({super.key});

  final RoomDetailsController controller = Get.put(RoomDetailsController());
  final BookingController bookingController = Get.put(BookingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        title: const Text("Tables"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return GridView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.tables.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),

          itemBuilder: (context, index) {
            final table = controller.tables[index];

            final isOccupied = table.isOccupied == 1;

            return GestureDetector(
              onTap: () => showBookingSheet(table.id, table.tableNum),

              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.14),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),

                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: isOccupied ? Colors.red : Appcolor.scondary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),

                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.table_restaurant,
                            size: 30,
                            color: isOccupied ? Colors.red : Appcolor.scondary,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Table ${table.tableNum}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Appcolor.scondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  void showBookingSheet(int tableId, int tableNum) {
    Get.bottomSheet(
      Container(
        constraints: BoxConstraints(maxHeight: Get.height * 0.85),
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Color(0xFFF9FAFB),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Table $tableNum",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Appcolor.scondary,
                    ),
                  ),
                  const Icon(Icons.event_seat, color: Appcolor.scondary),
                ],
              ),

              const SizedBox(height: 20),

              // DATE
              FancyCard(
                icon: Icons.calendar_today,
                title: "التاريخ",
                child: ElevatedButton(
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: Get.context!,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: Theme.of(context).colorScheme.copyWith(
                              primary: Appcolor.scondary, // اللون الثانوي
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );

                    if (date != null) {
                      bookingController.setDate(date);
                    }
                  },
                  child: Obx(() {
                    final date = bookingController.selectedDate.value;
                    return Text(
                      date == null
                          ? "اختيار التاريخ"
                          : date.toString().split(" ")[0],
                    );
                  }),
                ),
              ),

              const SizedBox(height: 12),

              // TIME
              FancyCard(
                icon: Icons.access_time,
                title: "الوقت",
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          final t = await showTimePicker(
                            context: Get.context!,
                            initialTime: TimeOfDay.now(),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: Theme.of(context).colorScheme
                                      .copyWith(
                                        primary:
                                            Appcolor.scondary, // اللون الثانوي
                                      ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (t != null) bookingController.setStart(t);
                        },
                        child: Obx(() {
                          final t = bookingController.startTime.value;
                          return Text(
                            t == null ? "بداية" : t.format(Get.context!),
                          );
                        }),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          final t = await showTimePicker(
                            context: Get.context!,
                            initialTime: TimeOfDay.now(),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: Theme.of(context).colorScheme
                                      .copyWith(primary: Appcolor.scondary),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (t != null) bookingController.setEnd(t);
                        },
                        child: Obx(() {
                          final t = bookingController.endTime.value;
                          return Text(
                            t == null ? "نهاية" : t.format(Get.context!),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // BUTTONS
              Obx(
                () => Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Appcolor.primary,
                          padding: const EdgeInsets.all(12),
                        ),
                        onPressed: bookingController.isLoading.value
                            ? null
                            : () => bookingController.createBooking(tableId),
                        child: const Text(
                          "احجز الآن",
                          style: TextStyle(color: Appcolor.backgroundcolor),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.all(16),
                        ),
                        onPressed: () {
                          Get.defaultDialog(
                            title: "تأكيد",
                            middleText: "هل تريد الإلغاء؟",
                            onConfirm: () {
                              Get.back();
                              bookingController.cancelBooking();
                            },
                          );
                        },
                        child: const Text(
                          "إلغاء الحجز",
                          style: TextStyle(color: Appcolor.backgroundcolor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
