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
    this.onPressed,
    this.backgroundColor,
    required this.text2,
    required this.text3,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 14,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 42),
            ),
          ),
          const SizedBox(height: 28),

          Text(
            text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xff555555),
            ),
          ),

          const SizedBox(height: 18),

          Text(
            text2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              height: 1.9,
              color: Color(0xff555555),
            ),
          ),

          const SizedBox(height: 50),
          SizedBox(
            width: double.infinity,
            height: 68,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 10),
                  Text(
                    text3,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
