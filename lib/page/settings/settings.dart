import 'package:flutter/cupertino.dart';

class Settings {
  // Private constructor
  Settings._privateConstructor();

  // The single instance of the class
  static final Settings _instance = Settings._privateConstructor();

  // Public getter to access the instance
  static Settings get instance => _instance;

  invalid() {
    settingsState.value = javaScript.toString() +
        loadLastVisitedPage.toString() +
        darkModeSystem.toString() +
        darkMode.toString();
  }

  final settingsState = SettingsState(null);
  bool javaScript = true;

  setJavaScript(enabled) {
    javaScript = enabled;
    invalid();
  }

  bool loadLastVisitedPage = true;
  String lastVisitingPage = "";

  setLoadLastVisitedPage(enabled) {
    loadLastVisitedPage = enabled;
    invalid();
  }

  bool darkModeSystem = true;

  setDarkModeSystem(enabled) {
    darkModeSystem = enabled;
    invalid();
  }

  bool darkMode = true;

  setDarkMode(enabled) {
    darkMode = enabled;
    invalid();
  }
}

class SettingsState extends ValueNotifier<String?> {
  SettingsState(super.value);
}