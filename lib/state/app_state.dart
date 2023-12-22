import 'package:flutter/cupertino.dart';
import 'package:kolor_klash/state/subclasses/tile_container_state.dart';

import '../widgets/game_tile.dart';
import '../widgets/tile_container.dart';

class AppState {
  int gridSize;
  late List<List<TileContainerReduxState>> grid;

  late List<GameTile?> deck;

  AppState({required this.gridSize}) {
    grid = [];
    deck = [];
    for(var i = 0; i < gridSize; i++) {
        List<TileContainerReduxState> row = [];
        for(var j = 0; j < gridSize; j++) {
          //GlobalKey<TileContainerState> tileContainerKey = GlobalKey();
          row.add(TileContainerReduxState(container: TileContainer(size: gridSize, row: i, column: j)));
        }
        deck.add(GameTile(max: gridSize, index: i,));
        grid.add(row);
    }
  }

}
