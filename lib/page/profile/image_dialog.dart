import 'dart:io';

import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  final String imageUrl;

  const ImageDialog(this.imageUrl, {super.key});

  getImage(String imageUrl) {
    if (imageUrl.contains("assets/")) {
      return ExactAssetImage(imageUrl);
    } else {
      return FileImage(File(imageUrl));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: double.infinity,
        height: 500,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: getImage(imageUrl), fit: BoxFit.cover)),
      ),
    );
  }
}
