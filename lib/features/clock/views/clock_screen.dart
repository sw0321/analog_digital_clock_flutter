
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/clock_painter.dart';
import '../widgets/digital_number_widget.dart';
import '../../settings/views/settings_screen.dart';
import '../../settings/providers.dart';
import '../providers.dart';

class ClockScreen extends ConsumerWidget {
  const ClockScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final asyncNow = ref.watch(clockProvider);

    return asyncNow.when(
      data: (now) {
        final hour = DateFormat('HH').format(now);
        final minute = DateFormat('mm').format(now);

        final textStyle = GoogleFonts.getFont(
          settings.font,
          textStyle: TextStyle(
            color: settings.digitalNumberColor,
            fontSize: 60,
          ),
        );

        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(Icons.settings, color: settings.digitalNumberColor),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingsScreen()),
                  );
                },
              ),
            ],
          ),
          body: Stack(
            children: [
              Center(
                child: CustomPaint(
                  size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
                  painter: ClockPainter(context, now, settings.hourHandColor, settings.minuteHandColor, settings.secondHandColor),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween(begin: const Offset(0, -0.5), end: Offset.zero)
                                .animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: DigitalNumberWidget(number: hour, key: ValueKey(hour), textStyle: textStyle),
                    ),
                    DigitalNumberWidget(number: ":", textStyle: textStyle),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                       transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween(begin: const Offset(0, -0.5), end: Offset.zero)
                                .animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: DigitalNumberWidget(number: minute, key: ValueKey(minute), textStyle: textStyle),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: Text('Error: $err')),
      ),
    );
  }
}
