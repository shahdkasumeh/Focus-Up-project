import 'dart:math';
import 'package:flutter/material.dart';
import 'package:test/model/static/luckywheel/wheel_prize_model.dart';

class WheelPainter extends CustomPainter {
  final List<WheelPrizeModel> prizes;

  WheelPainter({
    required this.prizes,
  });

  final List<Color> colors = const [
    Color(0xFFF5A623),
    Color(0xFF1D9E75),
    Color(0xFF185FA5),
    Color(0xFFD85A30),
    Color(0xFF534AB7),
    Color(0xFF993C1D),
    Color(0xFF0F6E56),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    if (prizes.isEmpty) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final sweepAngle = 2 * pi / prizes.length;

    for (int i = 0; i < prizes.length; i++) {
      final paint = Paint()..color = colors[i % colors.length];

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        i * sweepAngle - pi / 2,
        sweepAngle,
        true,
        paint,
      );

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

      final mid = (i + 0.5) * sweepAngle - pi / 2;

      final tp = TextPainter(
        text: TextSpan(
          text: prizes[i].name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 9,
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.center,
      )..layout(maxWidth: 70);

      canvas.save();

      canvas.translate(
        center.dx + cos(mid) * radius * 0.65,
        center.dy + sin(mid) * radius * 0.65,
      );

      canvas.rotate(mid + pi / 2);

      tp.paint(
        canvas,
        Offset(-tp.width / 2, -tp.height / 2),
      );

      canvas.restore();
    }

    canvas.drawCircle(center, 18, Paint()..color = Colors.white);
    canvas.drawCircle(center, 14, Paint()..color = const Color(0xFF1A3A5C));

    final pointerPaint = Paint()..color = Colors.white;

    final path = Path()
      ..moveTo(center.dx, center.dy - radius - 12)
      ..lineTo(center.dx - 8, center.dy - radius + 8)
      ..lineTo(center.dx + 8, center.dy - radius + 8)
      ..close();

    canvas.drawPath(path, pointerPaint);
  }

  @override
  bool shouldRepaint(covariant WheelPainter oldDelegate) {
    return oldDelegate.prizes.length != prizes.length ||
        oldDelegate.prizes != prizes;
  }
}