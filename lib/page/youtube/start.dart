import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'menu.dart';

class YoutubePlayerPage extends StatefulWidget {
  const YoutubePlayerPage({super.key, required this.title});

  final String title;

  @override
  State<YoutubePlayerPage> createState() => _MyYoutubePlayerPageState();
}

getHtml(videoId) {
  return '''
        <html lang="de">
            <body style="margin:0px;padding:0px;">
               <div id="player"></div>
                <script>
                    var player1;
                    function onYouTubeIframeAPIReady() {
                      player1 = new YT.Player('player', {
                        videoId: '$videoId',
                        width: '100%'
                      });
                    }
                    function seekTo(time) {
                      player1.seekTo(time, true);
                    }
                    function playVideo() {
                      player1.playVideo();
                    }
                    function pauseVideo() {
                      player1.pauseVideo();
                    }
                </script>
                <script src="https://www.youtube.com/iframe_api"></script>
            </body>
        </html>
    ''';
}

class _MyYoutubePlayerPageState extends State<YoutubePlayerPage> {
  late final WebViewController controller;
  late FocusNode _focusNode;

  final GlobalKey _key = GlobalKey();

//function for the button triggered
  void _triggerButtonClick() {
    final webView = _key.currentContext!.findRenderObject() as Widget;

  }

  startVideo(WebViewController controller) async {
    _focusNode.requestFocus();
    controller.runJavaScript('''playVideo();'''); // did not work
  }

  showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'tap',
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      //..loadRequest(Uri.parse('https://www.youtube.com/watch?v=bHQqvYy5KYo'),);
      //..loadFlutterAsset('assets/youtube.html');
      ..loadHtmlString(getHtml("bHQqvYy5KYo"));
    if (!kIsWeb) {
      // none supported by web
      controller.setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {},
        onProgress: (progress) {},
        onPageFinished: (url) {
          /*ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'onPageFinished $url',
              ),
            ),
          );*/
        },
      ));
    }
    /*WidgetsBinding.instance.addPostFrameCallback((_) {
      startVideo(controller);
    });*/

    Timer(Duration(seconds: 3), () {
      startVideo(controller);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
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
            Menu(controller: controller),
          ],
        ),
        //passing in the ListView.builder
        body: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Stack(
              children: [

                /// 2. ... and trigger the onTap function of this widget (WIDGET_2)
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    showSnackBar();
                  },
                  child: Container(
                    height: 500,
                    width: 400,
                    color: Colors.deepOrange,
                  ),
                ),

                Focus(
                  focusNode: _focusNode,
                  child: WebViewWidget(
                    controller: controller,
                  ),
                ),
              ],
            )));
  }
}
