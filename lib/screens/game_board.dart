import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kolor_klash/widgets/tile_container.dart';
import 'package:kolor_klash/widgets/tile_deck.dart';

import '../state/app_state.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state)
      {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8, 32, 8, 8),
          child: Column(
            children: [
              ...generateRows(state.grid, state.gridSize),
              TileDeck(gridSize: state.gridSize)
            ],
          ),
        );
      },
    );
  }

  List<Expanded> generateRows(List<List<TileContainer>> tiles, int gridSize) {
    List<Expanded> rows = [];
    for(var i = 0; i < gridSize; i++) {
      rows.add(
        Expanded(
          flex: 1,
          child: Row(
            children: generateCells(gridSize, TileContainer(size: gridSize)),
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
