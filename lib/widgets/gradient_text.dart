import 'package:flutter/material.dart';
import 'package:kolor_klash/widgets/white_menu_text.dart';

import '../styles/background_gradient.dart';

class GradientText extends StatelessWidget {
  final String buttonText;
  const GradientText({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        shaderCallback: (bounds) => backgroundGradient.createShader(bounds),
        child: WhiteStyledText(text: buttonText)
    );
  }
}
