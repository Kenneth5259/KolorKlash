import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;

  const MenuButton({super.key, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.white54,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [buildStyledText(buttonText)],
      ),
      onPressed: () => onPressed(),
    );
  }

  Padding buildStyledText(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 36,
        ),
      ),
    );
  }
}
