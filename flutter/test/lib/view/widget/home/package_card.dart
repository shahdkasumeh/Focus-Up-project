import 'package:flutter/material.dart';

class PackageCard extends StatelessWidget {
  final String name;
  final String type;
  final String expiry;
  final int total;
  final int used;

  const PackageCard({
    super.key,
    required this.name,
    required this.type,
    required this.expiry,
    required this.total,
    required this.used,
  });

  @override
  Widget build(BuildContext context) {
    double percent = used / total;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4E9BFF), Color(0xFF3B7DD8)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// اسم الباقة
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          /// النوع
          Text(type, style: const TextStyle(color: Colors.white70)),

          const SizedBox(height: 10),

          /// الساعات
          Text(
            '$used / $total ساعة',
            style: const TextStyle(color: Colors.white),
          ),

          const SizedBox(height: 8),

          /// البار (النسبة)
          LinearProgressIndicator(
            value: percent, // 👈 هون النسبة
            backgroundColor: Colors.white24,
            valueColor: const AlwaysStoppedAnimation(Colors.white),
          ),

          const SizedBox(height: 8),

          /// تاريخ الانتهاء
          Text('ينتهي في $expiry', style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
