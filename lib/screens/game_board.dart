import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kolor_klash/state/subclasses/tile_container_state.dart';
import 'package:kolor_klash/widgets/game_over.dart';
import 'package:kolor_klash/widgets/tile_deck.dart';

import '../state/actions/update_show_restart_menu_action.dart';
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
        return Stack(
          children: getGameBoard(state)
        );
      },
    );
  }

  List<Widget> getGameBoard(AppState state) {
    final store = StoreProvider.of<AppState>(context);
    List<Widget> gameBoard = [
      Padding(
        padding: const EdgeInsets.fromLTRB(8, 32, 8, 8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Center(child: Text("Turn Count: ${state.turnCount}"))),
                Expanded(
                  child: Center(
                    child: IconButton(
                        splashRadius: 16,
                        onPressed: () => {store.dispatch(UpdateShowRestartMenuAction(true))},
                        icon: const Icon(Icons.settings)
                    ),
                  ),
                ),
                Expanded(child: Center(child: Text("Score: ${state.score}")))
              ],),
            ...generateRows(state.grid),
            const TileDeck()
          ],
        ),
      ),
    ];
    if(state.showRestartMenu) {
      gameBoard.add(GameOver(state: state,));
    }
    return gameBoard;
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
