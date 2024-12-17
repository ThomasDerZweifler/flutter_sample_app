import 'package:flutter/material.dart';
import 'package:flutter_sample_app/page/start/start.dart';
import 'package:flutter_sample_app/page/settings/settings.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  ThemeMode themeMode = ThemeMode.system;
  final settings = Settings.instance;

  settingsChanged(settings) {
    if (settings.darkMode) {
      setState(() {
        themeMode = ThemeMode.dark;
      });
    } else {
      setState(() {
        themeMode = ThemeMode.light;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    settings.settingsState.addListener(() {
      settingsChanged(settings);
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        key: Key("root"),
        title: 'Flutter Sample App',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(brightness: Brightness.dark),
        themeMode: themeMode,
        home: const HomePage(title: 'Sample App'),

        //home: const WebPage(title: "WebPage"),

        debugShowCheckedModeBanner: false);
  }
}
