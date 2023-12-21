import 'dart:ui';

import 'package:kolor_klash/state/actions/update_colors_action.dart';
import 'package:kolor_klash/widgets/tile_container.dart';

import '../app_state.dart';

AppState updateColorsReducer(AppState previousState, UpdateColorsAction action) {
  // retrieve the grid
  List<List<TileContainer>> grid = previousState.grid;
  // get the color
  Color color = action.color;
  // ge the tile
  TileContainer tile = action.tile;

  // get the column if it can be flushed
  List<TileContainer> column = getVerticalMatch(grid, tile, color);
  // get the row if it can be flushed
  // get backslash diagonal if it can be flushed
  // get forwardslash diagonal if it can be flushed
  // check if tile can selfFlush

  return previousState;
}

/// checks each column for a color match
List<TileContainer> getVerticalMatch(List<List<TileContainer>> grid, TileContainer tile, Color color) {
  // array containing all tiles in a column that have a color match
  List<TileContainer> column = [];

  // populate with each tile for the colum or stop if there isn't the color
  for(var row in grid) {
    var currentTile = row[tile.column];
    if(!currentTile.globalKey!.currentState!.colorMap.containsValue(color)) {
      return [];
    }
    column.add(row[tile.column]);
  }

  return column;
}

/// checks each row for a color match
List<TileContainer> getHorizontalMatch(List<List<TileContainer>> grid, TileContainer tile, Color color) {
  // array containing all tiles in a row that have color match
  List<TileContainer> row = grid[tile.row];

  for(var currentTile in row) {
    if(!currentTile.globalKey!.currentState!.colorMap.containsValue(color)) {
      return [];
    }
  }

  return row;
}
