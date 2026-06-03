import 'package:flutter/material.dart';
import 'package:test/core/class/constant/appcolor.dart';

class CurrentBookingCard extends StatelessWidget {
  final String start;
  final String end;
  final VoidCallback onQrTap;
  final VoidCallback onCancelTap;

  const CurrentBookingCard({
    required this.start,
    required this.end,
    required this.onQrTap,
    required this.onCancelTap,
  });

  String _dateOnly(String value) {
    if (value.isEmpty) return "-";
    return value.split(" ").first;
  }

  String _timeOnly(String value) {
    if (value.isEmpty) return "-";

    final parts = value.split(" ");
    if (parts.length < 2) return value;

    final time = parts[1];

    if (time.length >= 5) {
      return time.substring(0, 5);
    }

    return time;
  }

  @override
  Widget build(BuildContext context) {
    final date = _dateOnly(start);
    final startTime = _timeOnly(start);
    final endTime = _timeOnly(end);

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Appcolor.scondary.withValues(alpha: 0.20),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 14,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: Appcolor.scondary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.event_available_rounded,
              color: Appcolor.scondary,
              size: 30,
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Your Current Booking",
                  style: TextStyle(
                    color: Appcolor.scondary,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_rounded,
                      size: 14,
                      color: Appcolor.scondary,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      date,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      size: 15,
                      color: Appcolor.scondary,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        "$startTime - $endTime",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Appcolor.scondary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: IconButton(
              onPressed: onQrTap,
              icon: const Icon(
                Icons.qr_code_2_rounded,
                color: Appcolor.scondary,
                size: 22,
              ),
            ),
          ),

          const SizedBox(width: 8),

          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: IconButton(
              onPressed: onCancelTap,
              icon: const Icon(
                Icons.cancel_rounded,
                color: Colors.red,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}