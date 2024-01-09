import 'package:flutter/material.dart';

BoxDecoration backgroundBoxDecoration = BoxDecoration(
    gradient: backgroundGradient
);

LinearGradient backgroundGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Colors.purple[800]!,
    Colors.pink[500]!,
  ],
);
