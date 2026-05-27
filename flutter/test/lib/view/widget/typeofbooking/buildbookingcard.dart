import 'package:flutter/material.dart';

class Buildbookingcard extends StatelessWidget {
  final String text;
  final String text2;
  final String text3;
  final Color? color;
  final IconData icon;
  final void Function()? onPressed;
  final Color? backgroundColor;

  const Buildbookingcard({
    super.key,
    required this.text,
    required this.icon,
    required this.text2,
    required this.text3,
    this.color,
    this.onPressed,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    const Color navyColor = Color(0xFF172F4F);
    const Color yellowColor = Color(0xFFF4B942);
    const Color descriptionColor = Color(0xFF7A8699);

    final Color iconColor = color ?? yellowColor;
    final Color buttonColor = backgroundColor ?? navyColor;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: navyColor.withValues(alpha: 0.06)),
        boxShadow: [
          BoxShadow(
            color: navyColor.withValues(alpha: 0.08),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 95,
              height: 95,
              decoration: BoxDecoration(
                color: yellowColor.withValues(alpha: 0.10),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(28),
                  bottomLeft: Radius.circular(80),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 22, 22, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  textDirection: TextDirection.rtl,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                        color: iconColor.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(icon, color: iconColor, size: 34),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            text,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w700,
                              color: navyColor,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            width: 38,
                            height: 4,
                            decoration: BoxDecoration(
                              color: yellowColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Text(
                  text2,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 14.5,
                    height: 1.7,
                    fontWeight: FontWeight.w400,
                    color: descriptionColor,
                  ),
                ),
                const SizedBox(height: 26),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: onPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      textDirection: TextDirection.rtl,
                      children: [
                        Text(
                          text3,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(Icons.arrow_back_ios_new_rounded, size: 17),
                      ],
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
