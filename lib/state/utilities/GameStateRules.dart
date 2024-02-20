import 'dart:ui';

import '../../widgets/game_tile.dart';
import '../../widgets/tile_container.dart';
import '../subclasses/tile_container_state.dart';

class GameStateRules {
  /// method to call each matcher to get a unique set of flushable tiles based off color
  static Set<TileContainerReduxState> generateFlushableSet(List<List<TileContainerReduxState>> grid, TileContainer tile, Color color) {
    Set<TileContainerReduxState> flushables = {};
    // get the column if it can be flushed
    List<TileContainerReduxState> column = getVerticalMatch(grid, tile, color);
    if(column.isNotEmpty) {
      flushables = addListToSet(flushables, column);
    }
    // get the row if it can be flushed
    List<TileContainerReduxState> row = getHorizontalMatch(grid, tile, color);
    if(row.isNotEmpty) {
      flushables = addListToSet(flushables, row);
    }
    // get the forward slash diagonal if it can be flushed
    List<TileContainerReduxState> fDiagonal = getForwardSlashDiagonalMatch(grid, color);
    if(fDiagonal.isNotEmpty) {
      flushables = addListToSet(flushables, fDiagonal);
    }

    // get the forward slash diagonal if it can be flushed
    List<TileContainerReduxState> bDiagonal = getBackSlashDiagonalMatch(grid, color);
    if(bDiagonal.isNotEmpty) {
      flushables = addListToSet(flushables, bDiagonal);
    }

    // get the single tile if it can be flushed
    List<TileContainerReduxState> matchedTile = getTileMatch(grid, tile,  color);
    if(matchedTile.isNotEmpty) {
      flushables = addListToSet(flushables, matchedTile);
    }

    return flushables;
  }

  /// checks a single colum for a color match
  static List<TileContainerReduxState> getTileMatch(List<List<TileContainerReduxState>> grid, TileContainer tile, Color color) {
    TileContainerReduxState matchableTile = grid[tile.row][tile.column];
    for(var i = 0; i < grid.length; i++) {
      var column = matchableTile.colorMap[i];
      if(column == null || column.value != color.value) {
        return [];
      }
    }
    return [matchableTile];
  }

  /// checks each column for a color match
  static List<TileContainerReduxState> getVerticalMatch(List<List<TileContainerReduxState>> grid, TileContainer tile, Color color) {
    // array containing all tiles in a column that have a color match
    List<TileContainerReduxState> column = [];

    // populate with each tile for the colum or stop if there isn't the color
    for(var row in grid) {
      var currentTile = row[tile.column];
      if(!hasColorMatch(currentTile.colorMap, color)) {
        return [];
      }
      column.add(row[tile.column]);
    }

    return column;
  }

  /// checks each row for a color match
  static List<TileContainerReduxState> getHorizontalMatch(List<List<TileContainerReduxState>> grid, TileContainer tile, Color color) {
    // array containing all tiles in a row that have color match
    List<TileContainerReduxState> row = grid[tile.row];

    for(var currentTile in row) {
      if(!hasColorMatch(currentTile.colorMap, color)) {
        return [];
      }
    }

    return row;
  }

  /// method to get the back slash diagonal match
  static List<TileContainerReduxState> getBackSlashDiagonalMatch(List<List<TileContainerReduxState>> grid, Color color) {
    // array containing the diagonal
    List<TileContainerReduxState> diagonal = [];
    for(var rowIndex = 0; rowIndex < grid.length; rowIndex++) {
      // setting column index - separate variable for readability
      var columnIndex = rowIndex;
      // get the tile
      var tile = grid[rowIndex][columnIndex];
      if(!hasColorMatch(tile.colorMap, color)) {
        return [];
      }
      diagonal.add(tile);
    }
    return diagonal;
  }

  /// Method to get the forward diagonal match
  static List<TileContainerReduxState> getForwardSlashDiagonalMatch(List<List<TileContainerReduxState>> grid, Color color)  {
    // array containing the diagonal
    List<TileContainerReduxState> diagonal = [];

    for(var rowIndex = 0; rowIndex < grid.length; rowIndex++) {
      // calculate the column off the row
      var columnIndex = grid.length - 1 - rowIndex;
      // get the tile
      var tile = grid[rowIndex][columnIndex];
      if(!hasColorMatch(tile.colorMap, color)) {
        return [];
      }
      diagonal.add(tile);
    }

    return diagonal;
  }

  /// method to add items to set
  static Set<TileContainerReduxState> addListToSet(Set<TileContainerReduxState> set, List list) {
    for(var item in list) {
      set.add(item);
    }
    return set;
  }

  static bool isGameOver(List<List<TileContainerReduxState>> grid, List<GameTile?> deck) {
    bool isGameOver = true;

    for(var row in grid) {
      for(var tileContainer in row) {
        for(var gameTile in deck) {
          if(gameTile != null && tileContainer.colorMap[gameTile.colorIndex] == null) {
            return false;
          }
        }
      }
    }

    return isGameOver;
  }

  static bool hasColorMatch(Map<int, Color> map, Color color) {
    for(var entry in map.entries) {
      if(entry.value.value == color.value) {
        return true;
      }
    }
    return false;
  }
}
