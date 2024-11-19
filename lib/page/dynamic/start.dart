import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:json_dynamic_widget/json_dynamic_widget.dart';

/*
page layouts by json

https://medium.com/@nesattalhakurtulus/a-flexible-solution-or-a-dynamic-nightmare-json-dynamic-widget-for-starters-32a97aff20b8
 */
class DynamicPage extends StatefulWidget {
  const DynamicPage({super.key, required this.title});

  final String title;

  @override
  State<DynamicPage> createState() => _DynamicWidgetExampleState();
}

class _DynamicWidgetExampleState extends State<DynamicPage> {
  late Future<JsonWidgetData?> _jsonWidgetData;

  final jsonData = {
    "type": "column",
    "args": <String, List<Map<String, Object>>>{
      "children": [
        {
          "type": "text",
          "args": {"text": "json_dynamic_widget : string"}
        }
      ]
    }
  };

  Future<JsonWidgetData> getWidgetDataFromString() async {
    if (kDebugMode) {
      print('returns widget data from string');
    }
    final registry = JsonWidgetRegistry.instance;
    return JsonWidgetData.fromDynamic(jsonData, registry: registry);
  }

  Future<JsonWidgetData> getWidgetDataFromAssets() async {
    final String s = await rootBundle.loadString('assets/ui.json');

    final jsonData = json.decode(s);

    if (kDebugMode) {
      print('returns widget data from assets');
    }
    final registry = JsonWidgetRegistry.instance;
    return JsonWidgetData.fromDynamic(jsonData, registry: registry);
  }

  Future<JsonWidgetData?> fetchWidgetData() async {
    final response =
        await http.get(Uri.parse('https://example.com/api/widget'));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (kDebugMode) {
        print('returns widget data from http');
      }
      final registry = JsonWidgetRegistry.instance;
      return JsonWidgetData.fromDynamic(jsonResponse, registry: registry);
    } else {
      throw Exception('Failed to load widget data');
    }
  }

  @override
  void initState() {
    super.initState();
    //_jsonWidgetData = fetchWidgetData();
    _jsonWidgetData = getWidgetDataFromAssets();
    //_jsonWidgetData = getWidgetDataFromString();

  }

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
        body: FutureBuilder<JsonWidgetData?>(
          future: _jsonWidgetData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return snapshot.data!.build(context: context);
            } else {
              return Center(child: Text('No widget data'));
            }
          },
        ));
  }
}
