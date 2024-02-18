// Import statements remain same

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kolor_klash/popups/settings_menu_popup.dart';
import 'package:redux/redux.dart';

import '../popups/game_menu_popup.dart';
import '../state/actions/update_show_restart_menu_action.dart';
import '../state/app_state.dart';
import '../state/subclasses/tile_container_state.dart';
import '../widgets/tile_deck.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});
  @override
  State<GameBoard> createState() => _GameBoardState();
}
class _GameBoardState extends State<GameBoard> {
  static const double paddingSide = 8;
  static const double paddingTop = 32;
  static const double fontSize = 16;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state)
      {
        return Stack(
            children: getGameBoardChildren(state)
        );
      },
    );
  }

  List<Widget> getGameBoardChildren(AppState state) {
    final store = StoreProvider.of<AppState>(context);
    List<Widget> gameBoardChildren = [
      Padding(
        padding: const EdgeInsets.fromLTRB(paddingSide, paddingTop, paddingSide, paddingSide),
        child: Column(
          children: [
            Row(
              children: [
                buildTurnCount(state.turnCount),
                buildSettingsButton(store),
                buildScore(state.score)
              ],
            ),
            ...generateTileRows(state.grid),
            const TileDeck()
          ],
        ),
      ),
    ];
    if(state.showRestartMenu) {
      gameBoardChildren.add(getGameMenu(state));
    }
    if(state.showSettingsMenu) {
      gameBoardChildren.add(const SettingsMenu());
    }
    return gameBoardChildren;
  }

  GameMenu getGameMenu(AppState state) => GameMenu(state: state);

  Widget buildTurnCount(int turnCount) => Expanded(child: Center(child: Text(
      style: const TextStyle(
          color: Colors.white,
          fontSize: fontSize
      ),
      "Turn Count: ${turnCount}"
  )));

  Widget buildSettingsButton(Store<AppState> store) => Expanded(
    child: Center(
      child: IconButton(
          splashRadius: 16,
          onPressed: () => {store.dispatch(UpdateShowRestartMenuAction(true))},
          icon: const Icon(Icons.settings, color: Colors.white,)
      ),
    ),
  );

  Widget buildScore(int score) => Expanded(child: Center(child: Text(
      style: const TextStyle(
          color: Colors.white,
          fontSize: fontSize
      ),
      "Score: ${score}"
  )));

  List<Expanded> generateTileRows(List<List<TileContainerReduxState>> tiles) {
    List<Expanded> rows = [];
    for(var row in tiles) {
      rows.add(
          Expanded(
              flex: 1,
              child: Row(
                children: generateTileCells(row),
              )
          )
      );
    }
    return rows;
  }

  List<Expanded> generateTileCells(List<TileContainerReduxState> row) {
    List<Expanded> cells = [];
    for(var cell in row) {
      cells.add(Expanded(flex: 1, child: cell.container));
    }
    return cells;
  }
}
