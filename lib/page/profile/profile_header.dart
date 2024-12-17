import 'package:flutter/material.dart';
import 'package:flutter_sample_app/page/profile/profile_text.dart';

import 'image_dialog.dart';

class ProfileHeader extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String bio;

  const ProfileHeader(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.bio});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: CircleAvatar(
            radius: 70,
            backgroundImage: AssetImage(imageUrl),
          ),
          onPressed: () {
            showDialog(context: context, builder: (_) => ImageDialog(imageUrl));
          },
        ),
        SizedBox(height: 8),
        ProfileText(name, style: TextStyle(fontSize: 24)),
        ProfileText(
          bio,
          style: TextStyle(fontSize: 24),
        ),
      ],
    );
  }
}
