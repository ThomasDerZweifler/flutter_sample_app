import 'package:flutter/material.dart';

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

class DetailScreen extends StatelessWidget {
  // In the constructor, require a Section.
  const DetailScreen({super.key, required this.section});

  // Declare a field that holds the Section.
  final Section section;

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(section.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(section.description),
      ),
    );
  }
}

class _MySettingsPageState extends State<SettingsPage> {
  final List<int> _items = List<int>.generate(50, (int index) => index);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

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
          padding: const EdgeInsets.symmetric(horizontal: 40),
          children: <Widget>[
            for (int index = 0; index < _items.length; index += 1)
              ListTile(
                key: Key('$index'),
                tileColor: _items[index].isOdd ? oddItemColor : evenItemColor,
                title: Text('dragging Item ${_items[index]}'),
              ),
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
