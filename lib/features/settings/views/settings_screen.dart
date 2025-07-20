import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final settingsNotifier = ref.read(settingsProvider.notifier);
    final fonts = [
      'Orbitron',
      'Press Start 2P',
      'VT323',
      'Share Tech Mono',
      'Nova Square',
      'Major Mono Display'
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSettingsCard(
            context,
            icon: Icons.color_lens,
            title: 'Color Settings',
            child: Column(
              children: [
                _buildColorPickerTile(context, 'Digital Numbers', settings.digitalNumberColor, settingsNotifier.setDigitalNumberColor),
                _buildColorPickerTile(context, 'Hour Hand', settings.hourHandColor, settingsNotifier.setHourHandColor),
                _buildColorPickerTile(context, 'Minute Hand', settings.minuteHandColor, settingsNotifier.setMinuteHandColor),
                _buildColorPickerTile(context, 'Second Hand', settings.secondHandColor, settingsNotifier.setSecondHandColor),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildSettingsCard(
            context,
            icon: Icons.font_download,
            title: 'Font Style',
            child: DropdownButton<String>(
              value: settings.font,
              isExpanded: true,
              underline: const SizedBox(),
              onChanged: (font) => settingsNotifier.setFont(font!),
              items: fonts.map((font) {
                return DropdownMenuItem(
                  value: font,
                  child: Text(font, style: GoogleFonts.getFont(font)),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard(BuildContext context, {required IconData icon, required String title, required Widget child}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 10),
                Text(title, style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            const Divider(height: 20, thickness: 1),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildColorPickerTile(BuildContext context, String title, Color currentColor, Function(Color) onColorChanged) {
    return ListTile(
      title: Text(title),
      trailing: CircleAvatar(
        backgroundColor: currentColor,
        radius: 15,
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Pick a color for $title'),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: currentColor,
                onColorChanged: onColorChanged,
                pickerAreaHeightPercent: 0.8,
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Done'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }
}
