import 'package:kolor_klash/state/actions/set_gridsize_action.dart';
import 'package:kolor_klash/state/actions/update_deck_action.dart';
import 'package:kolor_klash/widgets/tile_container.dart';

import '../widgets/game_tile.dart';
import 'app_state.dart';

AppState appReducer(AppState previousState, dynamic action) {
  if(action is SetGridSizeAction) {
    return handleSetGridSizeAction(previousState, action);
  }
  if(action is UpdateDeckAction) {
    return handleUpdateDeckAction(previousState, action);
  }
  return previousState;
}


AppState handleSetGridSizeAction(AppState previousState, SetGridSizeAction action) {
  // initialize a clean grid
  List<List<TileContainer>> grid = previousState.grid ?? [];

  // if the previous grid wasn't correct
  if(grid.length != action.gridSize) {
    // for each row in height
    for(var i = 0; i < action.gridSize; i++) {
      // create new row
      List<TileContainer> row = [];
      for(var j = 0; j < action.gridSize; j++) {
        // push new row entry
        row.add(TileContainer(size: action.gridSize, i: i, j: j));
      }
      // stack row onto grid
      grid.add(row);
    }
  }

  return AppState(gridSize: action.gridSize);
}

AppState handleUpdateDeckAction(AppState previousState, UpdateDeckAction action) {
  // get the tile to be removed from the action
  GameTile removedTile = action.removedTile;

  // get the previous deck
  List<GameTile?> deck = [...previousState.deck];

  // remove the tile
  deck[removedTile.index] = null;

  // check if the deck is "empty" ie all are null
  bool isEmpty = true;
  for(var entry in deck) {
    if(entry != null) {
      isEmpty = false;
      break;
    }
  }

  // if the deck is empty, repopulate the deck
  if(isEmpty) {
    for(var i  = 0; i < previousState.gridSize; i++) {
      deck[i] = GameTile(max: previousState.gridSize, index: i);
    }
  }

  AppState updatedState = AppState(gridSize: previousState.gridSize);
  updatedState.deck = deck;

  return updatedState;
}

