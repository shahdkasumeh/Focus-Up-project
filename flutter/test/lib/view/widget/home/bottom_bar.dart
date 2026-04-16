import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0x11000000))),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.home_rounded, color: Colors.black),
          Icon(Icons.calendar_month_rounded, color: Colors.grey),
          Icon(Icons.person_outline_rounded, color: Colors.grey),
        ],
      ),
    );
  }
}
