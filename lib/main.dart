import 'package:flutter/material.dart';
import 'package:kolor_klash/screens/game_board.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        home: const Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
              child: GameBoard()
          ),
        )
      );
  }
}

