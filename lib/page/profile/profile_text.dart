import 'package:flutter/cupertino.dart';

class ProfileText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const ProfileText(this.text, {super.key, required this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
    );
  }
}