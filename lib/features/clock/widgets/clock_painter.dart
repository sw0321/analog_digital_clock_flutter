
import 'package:flutter/material.dart';
import 'dart:math';

class ClockPainter extends CustomPainter {
  final BuildContext context;
  final DateTime dateTime;
  final Color hourHandColor;
  final Color minuteHandColor;
  final Color secondHandColor;

  ClockPainter(this.context, this.dateTime, this.hourHandColor, this.minuteHandColor, this.secondHandColor);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2) * 0.8;
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw the outer circle
    canvas.drawCircle(center, radius, paint);

    // Draw the hour markers
    for (int i = 0; i < 12; i++) {
      final angle = (i - 3) * (pi * 2 / 12);
      final start = center + Offset(cos(angle) * radius, sin(angle) * radius);
      final end = center + Offset(cos(angle) * (radius - 10), sin(angle) * (radius - 10));
      canvas.drawLine(start, end, paint);
    }

    // Draw hour hand
    final hour = dateTime.hour % 12;
    final minute = dateTime.minute;
    final hourAngle = (hour + minute / 60 - 3) * (pi * 2 / 12);
    canvas.drawLine(
      center,
      center + Offset(cos(hourAngle) * radius * 0.5, sin(hourAngle) * radius * 0.5),
      Paint()..color = hourHandColor..strokeWidth = 4,
    );

    // Draw minute hand
    final minuteAngle = (minute - 15) * (pi * 2 / 60);
    canvas.drawLine(
      center,
      center + Offset(cos(minuteAngle) * radius * 0.7, sin(minuteAngle) * radius * 0.7),
      Paint()..color = minuteHandColor..strokeWidth = 3,
    );

    // Draw second hand
    final second = dateTime.second;
    final secondAngle = (second - 15) * (pi * 2 / 60);
    canvas.drawLine(
      center,
      center + Offset(cos(secondAngle) * radius * 0.8, sin(secondAngle) * radius * 0.8),
      Paint()..color = secondHandColor..strokeWidth = 2,
    );

    // Draw the second indicator (dot)
    final position = center + Offset(cos(secondAngle) * radius, sin(secondAngle) * radius);
    final secondPaint = Paint()
      ..color = secondHandColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(position, 5, secondPaint);
  }

  @override
  bool shouldRepaint(covariant ClockPainter oldDelegate) {
    return oldDelegate.dateTime != dateTime ||
        oldDelegate.hourHandColor != hourHandColor ||
        oldDelegate.minuteHandColor != minuteHandColor ||
        oldDelegate.secondHandColor != secondHandColor;
  }
}
