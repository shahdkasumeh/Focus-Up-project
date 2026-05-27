import 'package:flutter/material.dart';
import 'package:test/view/widget/home/booking_icon.dart';

class HomeHeader extends StatelessWidget {
  final VoidCallback onBookingTap;

  const HomeHeader({required this.onBookingTap});

  static const Color primaryColor = Color(0xFF162F50);
  static const Color secondaryColor = Color(0xFF23486C);
  static const Color accentColor = Color(0xFFF5C44B);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -55,
            right: -50,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.045),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            left: -40,
            child: Container(
              width: 145,
              height: 145,
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.09),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 104, 18, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'أهلاً بك 👋',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'جاهز ليوم دراسة منتج ومليء بالإنجاز؟',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.72),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 22),

                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onBookingTap,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 76,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: accentColor.withValues(alpha: 0.25),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Row(
                        children: [
                          BookingIcon(),
                          SizedBox(width: 13),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'احجز مكانك الآن',
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 15.5,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'اختر القاعة والطاولة المناسبة إلك',
                                  style: TextStyle(
                                    color: Color(0xFF67511D),
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: primaryColor,
                            size: 16,
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
    );
  }
}
