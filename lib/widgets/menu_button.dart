import 'package:flutter/material.dart';
import 'package:kolor_klash/widgets/gradient_text.dart';

class MenuButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;
  final double? height;

  const MenuButton({super.key, required this.buttonText, required this.onPressed, this.height});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        child: Container(
          constraints: BoxConstraints(
            minHeight: height ?? 50
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientText(buttonText: buttonText)
            ],
          ),
        ),
        onPressed: () => onPressed(),
      ),
    );
  }
}
