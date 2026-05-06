import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/home/pakages_controller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/view/widget/pakages/row.dart';

class MyPackagesView extends GetView<PackagesController> {
  const MyPackagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.myPackages.isEmpty) {
        return const Center(
          child: Text(
            'لا توجد باقات شخصية',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }

      return RefreshIndicator(
        color: Appcolor.scondary,

        onRefresh: controller.getMyPackages,

        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),

          itemCount: controller.myPackages.length,

          itemBuilder: (context, index) {
            final package = controller.myPackages[index];

            final int total = package.totalHours;

            final int used = package.usedHours;

            final int remaining = package.remainingHours;

            final double progress = total == 0
                ? 0.0
                : (used / total).clamp(0.0, 1.0);

            final String percent = (progress * 100).toStringAsFixed(0);

            return Container(
              margin: const EdgeInsets.only(bottom: 18),

              padding: const EdgeInsets.all(22),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(24),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.06),

                    blurRadius: 18,

                    offset: const Offset(0, 8),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,

                children: [
                  /// الحالة
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),

                    decoration: BoxDecoration(
                      color: _statusColor(package.status).withOpacity(.12),

                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Text(
                      package.status,

                      style: TextStyle(
                        color: _statusColor(package.status),

                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  /// نسبة الاستخدام
                  Text(
                    '$percent% مستخدم من الباقة',

                    style: const TextStyle(
                      color: Appcolor.scondary,

                      fontSize: 17,

                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 12),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),

                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 10,

                      color: Appcolor.scondary,

                      backgroundColor: const Color(0xFFEDEBFF),
                    ),
                  ),

                  const SizedBox(height: 18),

                  Rows(title: 'TotalHours', value: '$total ساعة'),

                  Rows(title: 'UsedHours', value: '$used ساعة'),

                  Rows(title: 'RemainingHours', value: '$remaining ساعة'),

                  Rows(title: 'TotalPrice', value: '${package.totalPrice} ل.س'),

                  Rows(
                    title: 'RemainingPrice',
                    value: '${package.remainingPrice} ل.س',
                  ),

                  Rows(title: 'startsAt', value: package.startsAt),

                  Rows(title: 'expiresAt', value: package.expiresAt),
                ],
              ),
            );
          },
        ),
      );
    });
  }

  Color _statusColor(String status) {
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
