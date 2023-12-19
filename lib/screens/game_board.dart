import 'package:flutter/material.dart';
import 'package:kolor_klash/widgets/tile_container.dart';
import 'package:kolor_klash/widgets/tile_deck.dart';

class GameBoard extends StatefulWidget {
  final gridSize = 4;
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 32, 8, 8),
      child: Column(
        children: [
          ...generateRows(widget.gridSize),
          TileDeck(gridSize: widget.gridSize)
        ],
      ),
    );
  }

  List<Expanded> generateRows(int gridSize) {
    List<Expanded> rows = [];
    for(var i = 0; i < gridSize; i++) {
      rows.add(
        Expanded(
          flex: 1,
          child: Row(
            children: generateCells(widget.gridSize, TileContainer(columnCount: gridSize)),
          ),
        )
      );
    }
    return rows;
  }

  List<Expanded> generateCells(int gridSize, Widget childWidget) {
    List<Expanded> cells = [];
    for(var i = 0; i < gridSize; i++) {
      cells.add(Expanded(flex: 1, child: childWidget));
    }
    return cells;
  }
}
