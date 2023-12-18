import 'package:flutter/material.dart';
import 'package:kolor_klash/widgets/game_tile.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(flex: 1, child: GameTile()),
                Expanded(flex: 1, child: GameTile()),
                Expanded(flex: 1, child: GameTile())
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(flex: 1, child: GameTile()),
                Expanded(flex: 1, child: GameTile()),
                Expanded(flex: 1, child: GameTile())
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(flex: 1, child: GameTile()),
                Expanded(flex: 1, child: GameTile()),
                Expanded(flex: 1, child: GameTile())
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(top: 24.0, bottom: 8),
              child: Row(
                children: [
                  Expanded(flex: 1, child: GameTile()),
                  Expanded(flex: 1, child: GameTile()),
                  Expanded(flex: 1, child: GameTile())
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
