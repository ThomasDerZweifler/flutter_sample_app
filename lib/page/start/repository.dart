import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StartRepository {
  Future<String?> loadData() async {
    return await loadPrefsData().then((String? result) {
      if (result != null) {
        return "$result (from prefs)";
      } else {
        return loadRemoteData();
      }
    });
  }

  Future<String> loadLocalData() async {
    final String s = await rootBundle.loadString('assets/demo.json');

    final data = await json.decode(s);

    if (kDebugMode) {
      print('returns data from assets');
    }
    return s;
  }

  Future<String?> loadPrefsData() async {
    final prefs = SharedPreferencesAsync();
    final s = await prefs.getString("response1");

    if (kDebugMode) {
      print('returns data from prefs');
    }
    return s;
  }

  Future<String> loadRemoteData() async {
    final prefs = SharedPreferencesAsync();
    final response = await (http.get(Uri.parse('https://oreil.ly/ndCPN')));
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('response statusCode is 200');
      }
      final result = response.body;
      prefs.setString("response1", result);
      if (kDebugMode) {
        print('returns data from remote');
      }
      return result;
    } else {
      if (kDebugMode) {
        print('Http Error: ${response.statusCode}!');
      }
      throw Exception('Invalid data source.');
    }
  }
}
