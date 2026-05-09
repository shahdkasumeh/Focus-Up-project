import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/home/pakages_controller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/view/widget/pakages/date_row.dart' show DateRow;
import 'package:test/view/widget/pakages/empty_package.dart';
import 'package:test/view/widget/pakages/info_box.dart';

class MyCurrentPackageView extends GetView<PackagesController> {
  const MyCurrentPackageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isCurrentPackageLoading.value) {
        return const Center(
          child: CircularProgressIndicator(color: Appcolor.accentPurpleColor),
        );
      }

      final currentPackage = controller.currentPackage.value;

      if (currentPackage == null) {
        return const EmptyPackage(
          subtitle: 'لا توجد باقة حالية',
          text1: 'عند شراء باقة ستظهر هنا مباشرة',
        );
      }
      final color = statusColor(currentPackage.status);
      return RefreshIndicator(
        color: Appcolor.scondary,
        onRefresh: controller.getCurrentPackage,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(26),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: color.withOpacity(0.25),
                      width: 1.2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              color.withOpacity(0.95),
                              color.withOpacity(0.65),
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.22),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.workspace_premium_rounded,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'باقتي الحالية',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Package #${currentPackage.id}',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                currentPackage.status,
                                style: TextStyle(
                                  color: color,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: InfoBox(
                                    title: 'Total Price',
                                    value: '${currentPackage.totalPrice} ل.س',
                                    icon: Icons.payments_rounded,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: InfoBox(
                                    title: 'Remaining Price',
                                    value:
                                        '${currentPackage.remainingPrice} ل.س',
                                    icon: Icons.account_balance_wallet_rounded,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),

                            Row(
                              children: [
                                Expanded(
                                  child: InfoBox(
                                    title: 'Total Hours',
                                    value: '${currentPackage.totalHours} ساعة',
                                    icon: Icons.access_time_filled_rounded,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: InfoBox(
                                    title: 'Remaining Hours',
                                    value:
                                        '${currentPackage.remainingHours} ساعة',
                                    icon: Icons.hourglass_bottom_rounded,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),

                            Row(
                              children: [
                                Expanded(
                                  child: InfoBox(
                                    title: 'Used Hours',
                                    value: '${currentPackage.usedHours} ساعة',
                                    icon: Icons.timer_off_rounded,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: InfoBox(
                                    title: 'Status',
                                    value: currentPackage.status,
                                    icon: Icons.verified_rounded,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 18),

                            DateRow(
                              icon: Icons.play_circle_fill_rounded,
                              title: 'Starts At',
                              value: currentPackage.startsAt,
                            ),
                            const SizedBox(height: 10),

                            DateRow(
                              icon: Icons.event_busy_rounded,
                              title: 'Expires At',
                              value: currentPackage.expiresAt,
                            ),
                            const SizedBox(height: 10),

                            DateRow(
                              icon: Icons.confirmation_number_rounded,
                              title: 'Package ID',
                              value: '#${currentPackage.id}',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Color statusColor(String status) {
    switch (status.toLowerCase()) {
      case "active":
        return Colors.green;
      case "pending":
        return Colors.orange;
      case "expired":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
