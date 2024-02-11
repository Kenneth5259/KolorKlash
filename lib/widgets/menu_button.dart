import 'package:flutter/material.dart';
import 'package:kolor_klash/widgets/white_menu_text.dart';

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
        children: [WhiteStyledText(text: buttonText)],
      ),
      onPressed: () => onPressed(),
    );
  }
}
