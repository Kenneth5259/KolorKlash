import 'package:flutter/cupertino.dart';

import '../widgets/game_tile.dart';
import '../widgets/tile_container.dart';

class AppState {
  int gridSize;
  late List<List<TileContainer>> grid;

  late List<GameTile?> deck;

  AppState({required this.gridSize}) {
    grid = [];
    deck = [];
    for(var i = 0; i < gridSize; i++) {
        List<TileContainer> row = [];
        for(var j = 0; j < gridSize; j++) {
          //GlobalKey<TileContainerState> tileContainerKey = GlobalKey();
          row.add(TileContainer(size: gridSize, row: i, column: j));
        }
        deck.add(GameTile(max: gridSize, index: i,));
        grid.add(row);
    }
  }

}
