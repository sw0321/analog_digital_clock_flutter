import 'package:flutter/material.dart';

class AppSettings {
  final String font;
  final Color hourHandColor;
  final Color minuteHandColor;
  final Color secondHandColor;
  final Color digitalNumberColor;

  AppSettings({
    this.font = 'Orbitron',
    this.hourHandColor = Colors.white,
    this.minuteHandColor = Colors.white,
    this.secondHandColor = Colors.red,
    this.digitalNumberColor = Colors.white,
  });

  AppSettings copyWith({
    String? font,
    Color? hourHandColor,
    Color? minuteHandColor,
    Color? secondHandColor,
    Color? digitalNumberColor,
  }) {
    return AppSettings(
      font: font ?? this.font,
      hourHandColor: hourHandColor ?? this.hourHandColor,
      minuteHandColor: minuteHandColor ?? this.minuteHandColor,
      secondHandColor: secondHandColor ?? this.secondHandColor,
      digitalNumberColor: digitalNumberColor ?? this.digitalNumberColor,
    );
  }
}