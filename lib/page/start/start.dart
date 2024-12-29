import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sample_app/page/profile/start.dart';
import 'package:flutter_sample_app/page/start/repository.dart';
import 'package:flutter_sample_app/page/support/support.dart';
import 'package:flutter_sample_app/page/youtube/start.dart';

import '../dynamic/start.dart';
import '../pdf/start.dart';
import '../settings/start.dart';
import '../support/search.dart';
import '../web/start.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final startRepo = StartRepository();
  final support = Support();

  String _result = "n.a.";

  _fab() {
    debugPrint("_fab clicked");
  }

  _loadData() {
    startRepo.loadData().then((String? result) {
      setState(() {
        _result = result ?? "";
      });
    });
  }

  _loadLocalData() {
    startRepo.loadLocalData().then((String? result) {
      setState(() {
        _result = result ?? "";
      });
    });
  }

  handleClick(String value) {
    switch (value) {
      case 'Load JSON remote(cached)':
        _loadData();
        break;
      case 'Load JSON from assets':
        _loadLocalData();
        break;
      case 'DynamicPage':
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const DynamicPage(title: 'Dynamic page')),
        );
        break;
      case 'Web':
        if(Platform.isWindows) {
          support.showDialogPlattformNotSupported(context);
          break;
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WebPage(title: 'Web')),
        );
        break;
      case 'YoutubePlayer':
        if(Platform.isWindows) {
          support.showDialogPlattformNotSupported(context);
          break;
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const YoutubePlayerPage(title: 'Youtube Player')),
        );
        break;
      case 'Pdf':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PdfPage(title: 'Pdf')),
        );
        break;
      case 'Profile':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage(title: 'Profile')),
        );
        break;
      case 'Settings':
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const SettingsPage(title: 'Settings')),
        );
        break;
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
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Load JSON remote(cached)',
                'Load JSON from assets',
                'DynamicPage',
                'Web',
                'YoutubePlayer',
                'Pdf',
                'Profile',
                'Settings'
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
          AsyncSearchAnchor()
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SelectableText.rich(TextSpan(
              text: 'You', // default text style
              children: <TextSpan>[
                TextSpan(
                    text: ' can ',
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 35)),
                TextSpan(
                    text: 'select me!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45)),
              ],
            )),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'lorem ipsum',
                  style: const TextStyle(
                      fontFamily: 'Courier',
                      fontSize: 125,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            const Text(
              'use menu',
            ),
            Semantics(
                child: Text(
              _result,
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fab,
        tooltip: 'FAB action',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
