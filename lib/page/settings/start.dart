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
  @override
  Widget build(BuildContext context) {
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
      body: ListView.builder(
        itemCount: sections.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(sections[index].title),
            // When a user taps the ListTile, navigate to the DetailScreen.
            // Notice that you're not only creating a DetailScreen, you're
            // also passing the current section through to it.
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(section: sections[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
