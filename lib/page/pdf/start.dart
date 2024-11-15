import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfPage extends StatefulWidget {
  const PdfPage({super.key, required this.title});

  final String title;

  @override
  State<PdfPage> createState() => _MyPdfPageState();
}

class _MyPdfPageState extends State<PdfPage> with WidgetsBindingObserver {
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String pathPDF = "";
  var loadingPercentage = 0;

  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  Future<File> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");

      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  @override
  void initState() {
    super.initState();
    fromAsset('assets/demo-link.pdf', 'demo.pdf').then((f) {
      setState(() {
        pathPDF = f.path;
        if (kDebugMode) {
          print(pathPDF);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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

        /*
        body: SfPdfViewer.network(
          //pathPDF,
          'https://ontheline.trincoll.edu/images/bookdown/sample-local-pdf.pdf',
          //'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
          key: _pdfViewerKey,
        )
        */

        body: SfPdfViewer.asset('assets/demo-link.pdf'));
  }
}
