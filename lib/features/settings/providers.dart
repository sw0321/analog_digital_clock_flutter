import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../../shared/models/app_settings.dart';

final settingsProvider = StateNotifierProvider<SettingsNotifier, AppSettings>((ref) {
  return SettingsNotifier();
});

class SettingsNotifier extends StateNotifier<AppSettings> {
  SettingsNotifier() : super(AppSettings()) {
    _loadSettings();
  }

  late SharedPreferences _prefs;

  void _loadSettings() async {
    _prefs = await SharedPreferences.getInstance();
    state = state.copyWith(
      font: _prefs.getString('font') ?? 'Orbitron',
      hourHandColor: Color(_prefs.getInt('hourHandColor') ?? Colors.white.value),
      minuteHandColor: Color(_prefs.getInt('minuteHandColor') ?? Colors.white.value),
      secondHandColor: Color(_prefs.getInt('secondHandColor') ?? Colors.red.value),
      digitalNumberColor: Color(_prefs.getInt('digitalNumberColor') ?? Colors.white.value),
    );
  }

  void setFont(String font) {
    _prefs.setString('font', font);
    state = state.copyWith(font: font);
  }

  void setHourHandColor(Color color) {
    _prefs.setInt('hourHandColor', color.value);
    state = state.copyWith(hourHandColor: color);
  }

  void setMinuteHandColor(Color color) {
    _prefs.setInt('minuteHandColor', color.value);
    state = state.copyWith(minuteHandColor: color);
  }

  void setSecondHandColor(Color color) {
    _prefs.setInt('secondHandColor', color.value);
    state = state.copyWith(secondHandColor: color);
  }

  void setDigitalNumberColor(Color color) {
    _prefs.setInt('digitalNumberColor', color.value);
    state = state.copyWith(digitalNumberColor: color);
  }
}