import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  final String imageUrl;
  const ImageDialog(this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: double.infinity,
        height: 500,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage(imageUrl),
                fit: BoxFit.cover
            )
        ),
      ),
    );
  }
}