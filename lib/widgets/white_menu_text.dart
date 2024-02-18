import 'package:flutter/material.dart';

class WhiteStyledText extends StatelessWidget {
  final String text;
  const WhiteStyledText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );;
  }
}
