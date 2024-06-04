// Import statements remain same

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kolor_klash/popups/game_over_popup.dart';
import 'package:kolor_klash/popups/settings_menu_popup.dart';
import 'package:kolor_klash/state/actions/update_active_popup_action.dart';
import 'package:redux/redux.dart';

import '../popups/game_menu_popup.dart';
import '../state/app_state.dart';
import '../state/subclasses/tile_container_state.dart';
import '../widgets/tile_deck.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});
  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  static const double defaultPaddingSide = 8;
  static const double defaultPaddingTop = 32;
  static const double fontSize = 16;
  static const double defaultGap = 10;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state)
      {
        return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final double currentWidth = constraints.maxWidth;
              double paddingSide;

              // Check the width of the device and adjust padding accordingly
              if(currentWidth > 600){ // Width greater than 600 is most likely a tablet screen
                paddingSide = currentWidth * 0.1; // Padding is 10% of width
              } else {
                paddingSide = defaultPaddingSide;
              }

              return Stack(
                  children: getGameBoardChildren(state, paddingSide)
              );
            }
        );
      },
    );
  }

  List<Widget> getGameBoardChildren(AppState state, double paddingSide) {
    final store = StoreProvider.of<AppState>(context);
    List<Widget> gameBoardChildren = [
      Padding(
        padding: EdgeInsets.fromLTRB(paddingSide, defaultPaddingTop, paddingSide, defaultPaddingSide),
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

    if(state.activePopupMenu == GameMenu.POPUP_ID) {
      gameBoardChildren.add(getGameMenu(state));
    }
    if(state.activePopupMenu == SettingsMenu.POPUP_ID) {
      gameBoardChildren.add(const SettingsMenu());
    }
    if(state.activePopupMenu == GameOverMenu.POPUP_ID) {
      gameBoardChildren.add(const GameOverMenu());
    }
    return gameBoardChildren;
  }

  GameMenu getGameMenu(AppState state) => GameMenu(state: state);

  Widget buildTurnCount(int turnCount) => Expanded(child: Center(child: Text(
      style: const TextStyle(
          color: Colors.white,
          fontSize: fontSize
      ),
      "Turn Count: $turnCount"
  )));

  Widget buildSettingsButton(Store<AppState> store) => Expanded(
    child: Center(
      child: IconButton(
          splashRadius: 16,
          onPressed: () => {store.dispatch(UpdateActivePopupAction(GameMenu.POPUP_ID))},
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

  List<Widget> generateTileRows(List<List<TileContainerReduxState>> tiles) {
    List<Widget> rows = [];
    for(var row in tiles) {
      rows.add(Expanded(
        flex: 1,
        child: Row(children: generateTileCells(row)),
      ));
      rows.add(const SizedBox(height: defaultGap)); // Specify the gap between the rows.
    }
    return rows;
  }

  List<Widget> generateTileCells(List<TileContainerReduxState> row) {
    List<Widget> cells = [];
    for(var cell in row) {
      cells.add(
        Expanded(
          flex: 1,
          child: Container(
            margin: const EdgeInsets.all(defaultGap / 2), // Specify the gap between the cells.
            child: cell.container,
          ),
        ),
      );
    }
    return cells;
  }
}
