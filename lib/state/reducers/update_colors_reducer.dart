import 'dart:ui';

import 'package:kolor_klash/state/actions/update_colors_action.dart';
import 'package:kolor_klash/state/subclasses/tile_container_state.dart';
import 'package:kolor_klash/widgets/tile_container.dart';

import '../../widgets/game_tile.dart';
import '../app_state.dart';

AppState updateColorsReducer(AppState previousState, UpdateColorsAction action) {
  // retrieve the grid
  List<List<TileContainerReduxState>> grid = previousState.grid;
  // get the color and its column position
  Map<int, Color> newColor = action.colorMap;
  // get the updated deck
  List<GameTile?> deck = previousState.deck;
  // remove the missing tile
  deck[action.gameTileIndex] = null;
  deck = handleEmptyDeck(deck, grid.length);
  // get the tile
  TileContainer tile = action.tile;

  grid[tile.row][tile.column].colorMap[newColor.keys.first] = newColor.values.first;

  // get the column if it can be flushed
  //List<TileContainer> column = getVerticalMatch(grid, tile, color);
  // get the row if it can be flushed
  // get backslash diagonal if it can be flushed
  // get forwardslash diagonal if it can be flushed
  // check if tile can selfFlush
  AppState updatedAppState = AppState(gridSize: previousState.gridSize);
  updatedAppState.grid = grid;
  updatedAppState.deck = deck;
  return updatedAppState;
}

/// checks each column for a color match
List<TileContainer> getVerticalMatch(List<List<TileContainerReduxState>> grid, TileContainer tile, Color color) {
  // array containing all tiles in a column that have a color match
  List<TileContainer> column = [];

  // populate with each tile for the colum or stop if there isn't the color
  // for(var row in grid) {
  //   var currentTile = row[tile.column];
  //   if(!currentTile.globalKey!.currentState!.colorMap.containsValue(color)) {
  //     return [];
  //   }
  //   column.add(row[tile.column]);
  // }

  return column;
}

/// checks each row for a color match
List<TileContainer> getHorizontalMatch(List<List<TileContainer>> grid, TileContainer tile, Color color) {
  // array containing all tiles in a row that have color match
  List<TileContainer> row = grid[tile.row];

  for(var currentTile in row) {
    // if(!currentTile.globalKey!.currentState!.colorMap.containsValue(color)) {
    //   return [];
    // }
  }

  return row;
}

handleEmptyDeck(List<GameTile?> deck, int gridSize) {
  // check if the deck is "empty" ie all are null
  bool isEmpty = true;
  for(var entry in deck) {
    if(entry != null) {
      isEmpty = false;
      return deck;
    }
  }

  // if the deck is empty, repopulate the deck
  if(isEmpty) {
    for(var i  = 0; i < gridSize; i++) {
      deck[i] = GameTile(max: gridSize, index: i);
    }
  }
  return deck;
}
