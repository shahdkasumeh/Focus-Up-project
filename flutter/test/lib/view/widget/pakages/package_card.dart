// import 'package:flutter/material.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:get/get_state_manager/src/simple/get_view.dart';
// import 'package:test/controller/home/pakages_controller.dart';
// import 'package:test/core/class/constant/appcolor.dart';
// import 'package:test/model/static/packages/pakage_model.dart';
// import 'package:test/view/widget/pakages/feature.dart';

// class PackageCard extends GetView<PackagesController> {
//   final PackageModel package;

//   const PackageCard({super.key, required this.package});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.only(bottom: 24),
//       padding: const EdgeInsets.all(22),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(24),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(.06),
//             blurRadius: 18,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           /// اسم الباقة
//           Text(
//             package.name,
//             textAlign: TextAlign.right,
//             style: const TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.w800,
//               color: Appcolor.scondary,
//             ),
//           ),

//           const SizedBox(height: 12),

//           /// السعر
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               const Text(
//                 'ل.س / ساعة',
//                 style: TextStyle(color: Colors.grey, fontSize: 15),
//               ),

//               const SizedBox(width: 8),

//               Text(
//                 package.price,
//                 style: const TextStyle(
//                   color: Appcolor.accentYellowColor,
//                   fontSize: 34,
//                   fontWeight: FontWeight.w900,
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 18),

//           /// عدد الساعات
//           Feature(text: '${package.hours} Hours', icon: Icons.timer_outlined),

//           /// مدة الباقة
//           Feature(
//             text: '${package.durationDays} durationDays ',
//             icon: Icons.calendar_month_outlined,
//           ),

//           /// سعر الساعة
//           Feature(
//             text: '${package.pricePerHour} PricePerHour',
//             icon: Icons.payments_outlined,
//           ),

//           /// النوع
//           Feature(text: package.type, icon: Icons.category_outlined),

//           const SizedBox(height: 22),

//           SizedBox(
//             width: double.infinity,
//             height: 58,
//             child: Obx(
//               () => ElevatedButton(
//                 onPressed: controller.isBuying.value
//                     ? null
//                     : () {
//                         controller.buyPackage(package.id);
//                       },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Appcolor.primary,
//                   foregroundColor: Colors.white,
//                   elevation: 0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                 ),
//                 child: controller.isBuying.value
//                     ? const SizedBox(
//                         width: 22,
//                         height: 22,
//                         child: CircularProgressIndicator(
//                           color: Colors.white,
//                           strokeWidth: 2,
//                         ),
//                       )
//                     : const Text(
//                         'اشترك الآن',
//                         style: TextStyle(
//                           fontSize: 17,
//                           fontWeight: FontWeight.w800,
//                         ),
//                       ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:test/controller/home/pakages_controller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/model/static/packages/pakage_model.dart';

class PackageCard extends GetView<PackagesController> {
  final PackageModel package;

  const PackageCard({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Appcolor.scondary,
                      Appcolor.scondary.withOpacity(.72),
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.22),
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
                          Text(
                            package.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            package.type,
                            style: TextStyle(
                              color: Colors.white.withOpacity(.9),
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
                        '${package.hours} H',
                        style: const TextStyle(
                          color: Appcolor.scondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
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
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xffF7F8FA),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        children: [
                          Text(
                            package.price,
                            style: const TextStyle(
                              color: Appcolor.accentYellowColor,
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'ل.س / الباقة',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: _MiniInfoBox(
                            icon: Icons.timer_outlined,
                            title: 'Hours',
                            value: '${package.hours}',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _MiniInfoBox(
                            icon: Icons.calendar_month_outlined,
                            title: 'Duration',
                            value: '${package.durationDays} Days',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: _MiniInfoBox(
                            icon: Icons.payments_outlined,
                            title: 'Per Hour',
                            value: '${package.pricePerHour}',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _MiniInfoBox(
                            icon: Icons.category_outlined,
                            title: 'Type',
                            value: package.type,
                          ),
                        ),
                      ],
                    ),

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
                            disabledBackgroundColor: Appcolor.primary
                                .withOpacity(.45),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
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
                              : const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.shopping_bag_rounded, size: 22),
                                    SizedBox(width: 8),
                                    Text(
                                      'اشترك الآن',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
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
    );
  }
}

class _MiniInfoBox extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _MiniInfoBox({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 104,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xffF7F8FA),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Appcolor.scondary, size: 24),
          const Spacer(),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
