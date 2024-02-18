import 'package:flutter/material.dart';
import 'package:kolor_klash/popups/settings_menu_popup.dart';
import 'package:kolor_klash/screens/game_board_screen.dart';
import 'package:kolor_klash/screens/new_game_screen.dart';
import 'package:kolor_klash/state/subclasses/enums.dart';
import 'package:kolor_klash/state/subclasses/tile_container_state.dart';

import '../screens/main_menu_screen.dart';
import '../widgets/game_tile.dart';
import '../widgets/tile_container.dart';

class AppState {
  int gridSize;
  Difficulty difficulty = Difficulty.easy;
  int turnCount = 0;
  int score = 0;
  double gameTileHeight = 0;
  double gameTileWidth = 0;
  bool initialized = false;
  bool isGameOver = false;
  bool showRestartMenu = false;
  bool showSettingsMenu = false;
  late List<List<TileContainerReduxState>> grid;
  Widget? activeScreen;

  late List<GameTile?> deck;

  AppState({required this.gridSize}) {
    activeScreen = activeScreen ?? MainMenuScreen();
    resetGameboard(gridSize);
  }

  resetStats() {
    turnCount = 0;
    score = 0;
  }

  resetGameboard(int gridSize) {
    grid = [];
    deck = [];
    for(var i = 0; i < gridSize; i++) {
      List<TileContainerReduxState> row = [];
      for(var j = 0; j < gridSize; j++) {
        //GlobalKey<TileContainerState> tileContainerKey = GlobalKey();
        row.add(TileContainerReduxState(container: TileContainer(size: gridSize, row: i, column: j)));
      }
      deck.add(GameTile(max: gridSize, index: i, color: GameTile.generateColor(), colorIndex: GameTile.generateColumnIndex(0, gridSize),));
      grid.add(row);
    }
  }

}
