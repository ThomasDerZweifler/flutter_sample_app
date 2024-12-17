import 'package:flutter/material.dart';

import '../settings/settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({required this.settings, super.key});

  final Settings settings;

  @override
  State<SettingsPage> createState() => _MyWebSettingsPageState();
}

class _MyWebSettingsPageState extends State<SettingsPage> {
  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Web Settings Page"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        children: <Widget>[
          SwitchListTile(
            title: const Text('JavaScript enabled'),
            thumbIcon: thumbIcon,
            value: widget.settings.javaScript,
            onChanged: (bool value) {
              setState(() {
                widget.settings.setJavaScript(value);
              });
            },
            secondary: const Icon(Icons.adb),
          ),
          SwitchListTile(
            title: const Text('Load last visited page'),
            thumbIcon: thumbIcon,
            value: widget.settings.loadLastVisitedPage,
            onChanged: (bool value) {
              setState(() {
                widget.settings.setLoadLastVisitedPage(value);
              });
            },
            secondary: const Icon(Icons.ac_unit),
          ),
        ],
      ),
    );
  }
}
