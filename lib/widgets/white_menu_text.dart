import 'package:flutter/material.dart';

class WhiteStyledText extends StatelessWidget {
  final String text;
  final double? fontsize;
  const WhiteStyledText({super.key, required this.text, this.fontsize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontsize ?? 16,
          fontWeight: FontWeight.w600
        ),
      ),
    );
  }
}
