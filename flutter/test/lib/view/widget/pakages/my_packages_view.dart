import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/home/pakages_controller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/view/widget/pakages/date_row.dart';
import 'package:test/view/widget/pakages/empty_package.dart';
import 'package:test/view/widget/pakages/info_box.dart';

class MyPackagesView extends GetView<PackagesController> {
  const MyPackagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.myPackages.isEmpty) {
        return EmptyPackage(
          subtitle: 'لا توجد باقات شخصية',
          text1: 'عند شراء باقة ستظهر هنا مباشرة',
        );
      }
      return RefreshIndicator(
        color: Appcolor.scondary,
        onRefresh: controller.getMyPackages,
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          itemCount: controller.myPackages.length,
          itemBuilder: (context, index) {
            final package = controller.myPackages[index];
            final color = statusColor(package.status);

            return Container(
              margin: const EdgeInsets.only(bottom: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
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
                      color: color.withValues(alpha: 0.25),
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
                              color.withValues(alpha: 0.95),
                              color.withValues(alpha: 0.65),
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
                                color: Colors.white.withValues(alpha: 0.22),
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
                                    'My Package',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Package #${package.id}',
                                    style: TextStyle(
                                      color: Colors.white.withValues(
                                        alpha: 0.9,
                                      ),
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
                                package.status,
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
                                    value: '${package.totalPrice} ل.س',
                                    icon: Icons.payments_rounded,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: InfoBox(
                                    title: 'Remaining Price',
                                    value: '${package.remainingPrice} ل.س',
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
                                    value: '${package.totalHours} ساعة',
                                    icon: Icons.access_time_filled_rounded,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: InfoBox(
                                    title: 'Remaining Hours',
                                    value: '${package.remainingHours} ساعة',
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
                                    value: '${package.usedHours} ساعة',
                                    icon: Icons.timer_off_rounded,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: InfoBox(
                                    title: 'Status',
                                    value: package.status,
                                    icon: Icons.verified_rounded,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 18),

                            DateRow(
                              icon: Icons.play_circle_fill_rounded,
                              title: 'Starts At',
                              value: package.startsAt,
                            ),
                            const SizedBox(height: 10),

                            DateRow(
                              icon: Icons.event_busy_rounded,
                              title: 'Expires At',
                              value: package.expiresAt,
                            ),
                            const SizedBox(height: 10),

                            DateRow(
                              icon: Icons.add_circle_rounded,
                              title: 'Created At',
                              value: package.createdAt,
                            ),
                            const SizedBox(height: 10),

                            DateRow(
                              icon: Icons.confirmation_number_rounded,
                              title: 'Package ID',
                              value: '#${package.id}',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
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
