import 'dart:developer';
import 'dart:ui';

import 'package:kolor_klash/state/actions/update_colors_action.dart';
import 'package:kolor_klash/state/subclasses/emptied_deck.dart';
import 'package:kolor_klash/state/subclasses/flushed_map.dart';
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
  int score = previousState.score;
  int turnCount = previousState.turnCount;
  EmptiedDeck emptiedDeck = handleEmptyDeck(deck, grid.length, turnCount);
  deck = emptiedDeck.deck;
  turnCount = emptiedDeck.turnCount;
  // get the tile
  TileContainer tile = action.tile;

  grid[tile.row][tile.column].colorMap[newColor.keys.first] = newColor.values.first;

  Set<TileContainerReduxState> flushables = {};

  // get the column if it can be flushed
  List<TileContainerReduxState> column = getVerticalMatch(grid, tile, newColor.values.first);
  if(column.isNotEmpty) {
    flushables = addListToSet(flushables, column);
  }
  // get the row if it can be flushed
  List<TileContainerReduxState> row = getHorizontalMatch(grid, tile, newColor.values.first);
  if(row.isNotEmpty) {
    flushables = addListToSet(flushables, row);
  }



  for(var tile in flushables) {
    FlushedMap flushedMap = flushColor(tile.colorMap, newColor.values.first);
    score += flushedMap.colorCount;
    tile.colorMap = flushedMap.colorMap;
  }

  // get backslash diagonal if it can be flushed
  // get forwardslash diagonal if it can be flushed
  // check if tile can selfFlush
  AppState updatedAppState = AppState(gridSize: previousState.gridSize);
  updatedAppState.grid = grid;
  updatedAppState.deck = deck;
  updatedAppState.score = score;
  updatedAppState.turnCount = turnCount;
  return updatedAppState;
}

/// checks each column for a color match
List<TileContainerReduxState> getVerticalMatch(List<List<TileContainerReduxState>> grid, TileContainer tile, Color color) {
  // array containing all tiles in a column that have a color match
  List<TileContainerReduxState> column = [];

  // populate with each tile for the colum or stop if there isn't the color
  for(var row in grid) {
    var currentTile = row[tile.column];
    if(!currentTile.colorMap.containsValue(color)) {
      return [];
    }
    column.add(row[tile.column]);
  }

  return column;
}

/// checks each row for a color match
List<TileContainerReduxState> getHorizontalMatch(List<List<TileContainerReduxState>> grid, TileContainer tile, Color color) {
  // array containing all tiles in a row that have color match
  List<TileContainerReduxState> row = grid[tile.row];

  for(var currentTile in row) {
    if(!currentTile.colorMap.containsValue(color)) {
      return [];
    }
  }

  return row;
}

EmptiedDeck handleEmptyDeck(List<GameTile?> deck, int gridSize, int turnCount) {
  // check if the deck is "empty" ie all are null
  bool isEmpty = true;
  for(var entry in deck) {
    if(entry != null) {
      isEmpty = false;
      return EmptiedDeck(deck: deck, turnCount: turnCount);
    }
  }

  // if the deck is empty, repopulate the deck
  if(isEmpty) {
    for(var i  = 0; i < gridSize; i++) {
      deck[i] = GameTile(max: gridSize, index: i);
    }
  }
  turnCount = turnCount + 1;
  return EmptiedDeck(deck: deck, turnCount: turnCount);
}

/// method to add items to set
Set<TileContainerReduxState> addListToSet(Set<TileContainerReduxState> set, List list) {
  for(var item in list) {
    set.add(item);
  }
  return set;
}

/// method to remove the colors from a color map and return the number of times that color was in the map
///
FlushedMap flushColor(Map<int, Color> colorMap, Color color) {
  int colorCount = colorMap.length;
  colorMap.removeWhere((key, value) => value == color);
  colorCount -= colorMap.length;
  return FlushedMap(colorMap: colorMap, colorCount: colorCount);
}
