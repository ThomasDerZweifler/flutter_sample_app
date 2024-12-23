import 'package:flutter/material.dart';

class Support {

  Future<void> showDialogPlattformNotSupported(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Attention"),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Platform is not supported!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}