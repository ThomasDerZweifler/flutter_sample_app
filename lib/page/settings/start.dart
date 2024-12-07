import 'package:flutter/material.dart';

import 'settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.title});

  final String title;

  @override
  State<SettingsPage> createState() => _MySettingsPageState();
}

class Section {
  final String title;
  final String description;

  const Section(this.title, this.description);
}

final sections = List.generate(
  20,
  (i) => Section(
    'Setting $i',
    'A description for setting $i',
  ),
);

class _MySettingsPageState extends State<SettingsPage> {
  final List<int> _items = List<int>.generate(10, (int index) => index);
  final settings = Settings.instance;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);
    final MaterialStateProperty<Icon?> thumbIcon =
        MaterialStateProperty.resolveWith<Icon?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return const Icon(Icons.check);
        }
        return const Icon(Icons.close);
      },
    );

    return Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        //passing in the ListView.builder
        body: ReorderableListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: <Widget>[
            SwitchListTile(
              key: Key('AppSettingsDarkModeSystem'),
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
              key: Key('AppSettingsDarkMode'),
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
            for (int index = 0; index < _items.length; index += 1)
              Container(
                key: Key('Settings $index'),
                color: _items[index].isOdd ? oddItemColor : evenItemColor,
                constraints: BoxConstraints.expand(
                  height: 200.0,
                ),
                transform: Matrix4.rotationZ(0.1),
                child: Text('Hello World',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: Colors.blueGrey)),
              )
          ],
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final int item = _items.removeAt(oldIndex);
              _items.insert(newIndex, item);
            });
          },
        ));
  }
}
