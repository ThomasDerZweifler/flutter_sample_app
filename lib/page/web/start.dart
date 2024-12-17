import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample_app/page/web/menu.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../settings/settings.dart';
import 'navigation_controls.dart';

class WebPage extends StatefulWidget {
  const WebPage({super.key, required this.title});

  final String title;

  @override
  State<WebPage> createState() => WebPageState();
}

class WebPageState extends State<WebPage> {
  var loadingPercentage = 0;
  late final WebViewController controller;
  final settings = Settings.instance;

  settingsChanged(settings) {
    if (settings.javaScript) {
      controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    } else {
      controller.setJavaScriptMode(JavaScriptMode.disabled);
    }
    if (kDebugMode) {
      print('javaScript enabled:: ${settings.javaScript}');
    }
    if (settings.loadLastVisitedPage) {
    } else {}
    if (kDebugMode) {
      print('loadLastVisitedPage enabled:: ${settings.loadLastVisitedPage}');
    }
  }

  @override
  void initState() {
    super.initState();

    settings.settingsState.addListener(() {
      settingsChanged(settings);
    });

    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://flutter.dev'),
      );

    if (!kIsWeb) {
      // none supported by web
      controller.setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
      ));
    }
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
          actions: [
            NavigationControls(controller: controller),
            Menu(settings: settings, controller: controller),
          ],
        ),
        //passing in the ListView.builder
        body: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Stack(
              children: [
                WebViewWidget(
                  controller: controller,
                ),
                if (loadingPercentage < 100)
                  LinearProgressIndicator(
                    value: loadingPercentage / 100.0,
                  ),
              ],
            )));
  }
}
