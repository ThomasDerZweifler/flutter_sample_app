import 'package:flutter/material.dart';
//import 'package:json_dynamic_widget/json_dynamic_widget.dart';

/*
page layouts by json
 */
class DynamicPage extends StatefulWidget {
  const DynamicPage({super.key, required this.title});

  final String title;

  @override
  State<DynamicPage> createState() => _DynamicWidgetExampleState();
}

class _DynamicWidgetExampleState extends State<DynamicPage> {
  String json = '''
  {
    "type": "container",
    "padding": "16.0",
    "child": {
      "type": "raised_button",
      "child": {
        "type": "text",
        "data": "Press Me"
      },
      "onPressed": "print('Button pressed!')"
    }
  }
  ''';

  @override
  Widget build(BuildContext context) {
    //final registry = JsonWidgetRegistry.instance;
    //final data = JsonWidgetData.fromDynamic(json);

    return Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          /*actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.bookmark,
                color: Colors.white,
                semanticLabel: 'Bookmark',
              ),
              onPressed: () {
                _pdfViewerKey.currentState?.openBookmarkView();
              },
            ),
          ],*/
        ),

        body: Text(json)); //data.build(context: context, registry: registry));
  }
}
