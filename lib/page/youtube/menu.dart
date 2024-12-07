import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum _MenuOptions { navigationDelegate, playVideo, seekTo, pauseVideo }

class Menu extends StatelessWidget {
  const Menu({required this.controller, super.key});

  final WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_MenuOptions>(
      onSelected: (value) async {
        switch (value) {
          case _MenuOptions.navigationDelegate:
            await controller.loadRequest(Uri.parse('https://youtube.com'));
          case _MenuOptions.playVideo:
            await controller.runJavaScript('''playVideo();''');
          case _MenuOptions.seekTo:
            await controller.runJavaScript('''seekTo(60);''');
          case _MenuOptions.pauseVideo:
            await controller.runJavaScript('''pauseVideo();''');
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem<_MenuOptions>(
          value: _MenuOptions.navigationDelegate,
          child: Text('Navigate to YouTube'),
        ),
        const PopupMenuItem<_MenuOptions>(
          value: _MenuOptions.playVideo,
          child: Text('playVideo()'),
        ),
        const PopupMenuItem<_MenuOptions>(
          value: _MenuOptions.seekTo,
          child: Text('seekTo(60)'),
        ),
        const PopupMenuItem<_MenuOptions>(
          value: _MenuOptions.pauseVideo,
          child: Text('pauseVideo()'),
        ),
      ],
    );
  }
}
