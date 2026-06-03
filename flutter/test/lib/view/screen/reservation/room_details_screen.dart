import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/reservation/room_details_controller.dart';
import 'package:test/controller/reservation/booking_controller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/view/widget/reservation/current_booking_card.dart';
import 'package:test/view/widget/reservation/table_card.dart';
import 'package:test/view/widget/reservation/tables_header.dart';
import 'package:test/view/widget/reservation/time_button.dart';
import 'package:test/view/widget/typeofbooking/fancy_card.dart';

class RoomDetailsScreen extends StatelessWidget {
  RoomDetailsScreen({super.key});

  final RoomDetailsController controller = Get.put(RoomDetailsController());
  final BookingController bookingController = Get.put(BookingController());

  Future<void> _refreshData() async {
    await controller.fetchTables();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: Appcolor.scondary,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 58,
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
        title: const Text(
          "Tables",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Appcolor.scondary),
          );
        }

        if (controller.tables.isEmpty) {
          return RefreshIndicator(
            color: Appcolor.scondary,
            onRefresh: _refreshData,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: const [
                SizedBox(height: 250),
                Center(
                  child: Text(
                    "No tables available",
                    style: TextStyle(
                      color: Appcolor.scondary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        final occupiedCount = controller.tables
            .where((table) => table.isOccupied == 1)
            .length;

        final availableCount = controller.tables.length - occupiedCount;

        return Column(
          children: [
            TablesHeader(
              totalTables: controller.tables.length,
              availableTables: availableCount,
              occupiedTables: occupiedCount,
            ),

            Obx(() {
              final booking = bookingController.currentBooking.value;

              if (booking == null) {
                return const SizedBox.shrink();
              }

              return CurrentBookingCard(
                start: booking["start"]?.toString() ?? "",
                end: booking["end"]?.toString() ?? "",
                onQrTap: () {
                  Get.toNamed("/qrcodescreen");
                },
                onCancelTap: () {
                  Get.defaultDialog(
                    title: "تأكيد الإلغاء",
                    middleText: "هل تريدين إلغاء الحجز؟",
                    textConfirm: "نعم، إلغاء",
                    textCancel: "تراجع",
                    confirmTextColor: Colors.white,
                    buttonColor: Colors.red,
                    radius: 16,
                    onConfirm: () async {
                      Get.back();
                      await bookingController.cancelBooking();
                      await _refreshData();
                    },
                  );
                },
              );
            }),

            Expanded(
              child: RefreshIndicator(
                color: Appcolor.scondary,
                onRefresh: _refreshData,
                child: GridView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
                  itemCount: controller.tables.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 0.88,
                  ),
                  itemBuilder: (context, index) {
                    final table = controller.tables[index];

                    final bool isOccupied = table.isOccupied;

                    return TableCard(
                      tableNumber: table.tableNum,
                      isOccupied: isOccupied,
                      onTap: () {
                        if (isOccupied) {
                          Get.snackbar(
                            "Unavailable",
                            "This table is occupied now",
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.red.withValues(alpha: 0.92),
                            colorText: Colors.white,
                            margin: const EdgeInsets.all(14),
                            borderRadius: 14,
                            icon: const Icon(
                              Icons.info_outline_rounded,
                              color: Colors.white,
                            ),
                          );
                          return;
                        }

                        showBookingSheet(table.id, table.tableNum);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  void showBookingSheet(int tableId, int tableNum) {
    Get.bottomSheet(
      Container(
        constraints: BoxConstraints(maxHeight: Get.height * 0.88),
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),
        decoration: const BoxDecoration(
          color: Color(0xFFF9FAFB),
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 18),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Appcolor.scondary,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Appcolor.scondary.withValues(alpha: 0.25),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        Icons.table_restaurant_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Table $tableNum",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Choose date and time to continue",
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.75),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              FancyCard(
                icon: Icons.calendar_today_rounded,
                title: "التاريخ",
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: Get.context!,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
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

                      if (date != null) {
                        bookingController.setDate(date);
                      }
                    },
                    icon: const Icon(Icons.date_range_rounded, size: 19),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Appcolor.scondary,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: Colors.grey.shade200),
                      ),
                    ),
                    label: Obx(() {
                      final date = bookingController.selectedDate.value;

                      return Text(
                        date == null
                            ? "اختيار التاريخ"
                            : date.toString().split(" ")[0],
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      );
                    }),
                  ),
                ),
              ),

              const SizedBox(height: 12),
              FancyCard(
                icon: Icons.access_time_rounded,
                title: "الوقت",
                child: Row(
                  children: [
                    Expanded(
                      child: TimeButton(
                        icon: Icons.play_arrow_rounded,
                        onTap: () async {
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

                          if (t != null) {
                            bookingController.setStart(t);
                          }
                        },
                        child: Obx(() {
                          final t = bookingController.startTime.value;

                          return Text(
                            t == null ? "بداية" : t.format(Get.context!),
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          );
                        }),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: TimeButton(
                        icon: Icons.stop_rounded,
                        onTap: () async {
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

                          if (t != null) {
                            bookingController.setEnd(t);
                          }
                        },
                        child: Obx(() {
                          final t = bookingController.endTime.value;

                          return Text(
                            t == null ? "نهاية" : t.format(Get.context!),
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              Obx(
                () => Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Appcolor.scondary,
                          disabledBackgroundColor: Colors.grey.shade300,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: bookingController.isLoading.value
                            ? null
                            : () async {
                                await bookingController.createBooking(tableId);

                                await _refreshData();
                              },
                        child: bookingController.isLoading.value
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.4,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                "احجز الآن",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: BorderSide(
                            color: Colors.red.withValues(alpha: 0.45),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text(
                          "إغلاق",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
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
      isScrollControlled: true,
    );
  }
}
