import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class YoutubePlayerPage extends StatefulWidget {
  const YoutubePlayerPage({super.key, required this.title});

  final String title;

  @override
  State<YoutubePlayerPage> createState() => _MyYoutubePlayerPageState();
}

getHtml(videoId) {
  return '''
        <html>
        
            <body style="margin:0px;padding:0px;">
               <div id="player"></div>
                <script>
                    var player;
                    function onYouTubeIframeAPIReady() {
                      player = new YT.Player('player', {
                        videoId: '$videoId',
                        width: '100%',
                        playerVars: {
                          'playsinline': 1
                        }
                      });
                    }
                    function seekTo(time) {
                      player.seekTo(time, true);
                    }
                    function playVideo() {
                      player.playVideo();
                    }
                    function pauseVideo() {
                      player.pauseVideo();
                    }
                </script>
                <script src="https://www.youtube.com/iframe_api"></script>
            </body>
        </html>
    ''';
}

startVideo(WebViewController controller) async {
  controller.runJavaScript('''playVideo();'''); // did not work
}

class _MyYoutubePlayerPageState extends State<YoutubePlayerPage> {
  var loadingPercentage = 0;
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      //..loadRequest(Uri.parse('https://www.youtube.com/watch?v=bHQqvYy5KYo'),);
      //..loadFlutterAsset('assets/youtube.html');
      ..loadHtmlString(getHtml("bHQqvYy5KYo"));
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
    Timer(Duration(seconds: 3), () {
      startVideo(controller);
    });
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
