import 'package:flutter/material.dart';
import 'package:flutter_sample_app/page/settings/settings.dart';

class SettingsDarkMode extends StatefulWidget {
  const SettingsDarkMode({super.key, required this.title});

  final String title;

  @override
  State<SettingsDarkMode> createState() => SettingsDarkModeState();
}

class SettingsDarkModeState extends State<SettingsDarkMode> {
  final settings = Settings.instance;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final MaterialStateProperty<Icon?> thumbIcon =
        MaterialStateProperty.resolveWith<Icon?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return const Icon(Icons.check);
        }
        return const Icon(Icons.close);
      },
    );

    return Column(children: [
      SwitchListTile(
        title: const Text('Use dark mode from system'),
        thumbIcon: thumbIcon,
        value: settings.darkModeSystem,
        onChanged: (bool value) {
          setState(() {
            settings.setDarkModeSystem(value);
          });
        },
        secondary: const Icon(Icons.adb),
      ),
      SwitchListTile(
        title: const Text('Dark mode enabled'),
        thumbIcon: thumbIcon,
        value: settings.darkMode,
        onChanged: (bool value) {
          setState(() {
            settings.setDarkMode(value);
          });
        },
        secondary: const Icon(Icons.adb),
      ),
    ]);
  }
}
