import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kolor_klash/state/subclasses/tile_container_state.dart';
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
              ...generateRows(state.grid),
              const TileDeck()
            ],
          ),
        );
      },
    );
  }

  List<Expanded> generateRows(List<List<TileContainerReduxState>> tiles) {
    List<Expanded> rows = [];
    for(var row in tiles) {
      rows.add(
        Expanded(
          flex: 1,
          child: Row(
            children: generateCells(row),
          )
        )
      );
    }
    return rows;
  }

  List<Expanded> generateCells(List<TileContainerReduxState> row) {
    List<Expanded> cells = [];
    for(var cell in row) {
      cells.add(Expanded(flex: 1, child: cell.container));
    }
    return cells;
  }
}
