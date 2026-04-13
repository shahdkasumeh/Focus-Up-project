import 'dart:math';

import 'package:flutter/material.dart';

class WheelPainter extends CustomPainter {
  final List<Map<String, dynamic>> segments = const [
    {'label': '50 نقطة', 'color': Color(0xFFF5A623)},
    {'label': 'خصم 10%', 'color': Color(0xFF1D9E75)},
    {'label': 'حظ أوفر', 'color': Color(0xFF185FA5)},
    {'label': '100 نقطة', 'color': Color(0xFFD85A30)},
    {'label': 'مشروب مجاني', 'color': Color(0xFF534AB7)},
    {'label': 'خصم 20%', 'color': Color(0xFF993C1D)},
    {'label': '25 نقطة', 'color': Color(0xFF0F6E56)},
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final sweepAngle = 2 * pi / segments.length;

    for (int i = 0; i < segments.length; i++) {
      final paint = Paint()..color = segments[i]['color'];
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        i * sweepAngle - pi / 2,
        sweepAngle,
        true,
        paint,
      );
      // divider
      final divPaint = Paint()
        ..color = Colors.white
        ..strokeWidth = 2;
      final angle = i * sweepAngle - pi / 2;
      canvas.drawLine(
        center,
        Offset(
          center.dx + cos(angle) * radius,
          center.dy + sin(angle) * radius,
        ),
        divPaint,
      );
      // text
      final mid = (i + 0.5) * sweepAngle - pi / 2;
      final tp = TextPainter(
        text: TextSpan(
          text: segments[i]['label'],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 9,
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.rtl,
      )..layout();
      canvas.save();
      canvas.translate(
        center.dx + cos(mid) * radius * 0.65,
        center.dy + sin(mid) * radius * 0.65,
      );
      canvas.rotate(mid + pi / 2);
      tp.paint(canvas, Offset(-tp.width / 2, -tp.height / 2));
      canvas.restore();
    }

    // Center circle
    canvas.drawCircle(center, 18, Paint()..color = Colors.white);
    canvas.drawCircle(center, 14, Paint()..color = const Color(0xFF1A3A5C));

    // Pointer
    final pointerPaint = Paint()..color = Colors.white;
    final path = Path()
      ..moveTo(center.dx, center.dy - radius - 12)
      ..lineTo(center.dx - 8, center.dy - radius + 8)
      ..lineTo(center.dx + 8, center.dy - radius + 8)
      ..close();
    canvas.drawPath(path, pointerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
