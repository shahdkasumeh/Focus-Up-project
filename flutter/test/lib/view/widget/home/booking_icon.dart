import 'package:flutter/material.dart';

class BookingIcon extends StatelessWidget {
  const BookingIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 47,
      height: 47,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.38),
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Icon(
        Icons.event_seat_rounded,
        color: Color(0xFF162F50),
        size: 25,
      ),
    );
  }
}