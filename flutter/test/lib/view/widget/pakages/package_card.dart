import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:test/controller/home/pakages_controller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/model/static/packages/pakage_model.dart';
import 'package:test/view/widget/pakages/feature.dart';

class PackageCard extends GetView<PackagesController> {
  final PackageModel package;

  const PackageCard({super.key, required this.package});

 

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 24),
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
          /// اسم الباقة
          Text(
            package.name,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Appcolor.scondary,
            ),
          ),

          const SizedBox(height: 12),

          /// السعر
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'ل.س / ساعة',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),

              const SizedBox(width: 8),

              Text(
                package.price,
                style: const TextStyle(
                  color: Appcolor.accentYellowColor,
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          /// عدد الساعات
          Feature(text: '${package.hours} Hours', icon: Icons.timer_outlined),

          /// مدة الباقة
          Feature(
            text: '${package.durationDays} durationDays ',
            icon: Icons.calendar_month_outlined,
          ),

          /// سعر الساعة
          Feature(
            text: '${package.pricePerHour} PricePerHour',
            icon: Icons.payments_outlined,
          ),

          /// النوع
          Feature(text: package.type, icon: Icons.category_outlined),

          const SizedBox(height: 22),

          SizedBox(
            width: double.infinity,
            height: 58,
            child: Obx(
              () => ElevatedButton(
                onPressed: controller.isBuying.value
                    ? null
                    : () {
                        controller.buyPackage(package.id);
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Appcolor.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: controller.isBuying.value
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'اشترك الآن',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
