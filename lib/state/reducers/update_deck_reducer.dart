import '../../widgets/game_tile.dart';
import '../actions/update_deck_action.dart';
import '../app_state.dart';

AppState updateDeckReducer(AppState previousState, UpdateDeckAction action) {
  // get the tile to be removed from the action
  GameTile removedTile = action.removedTile;

  // get the previous deck
  List<GameTile?> deck = [...previousState.deck];

  // remove the tile
  deck[removedTile.index] = null;

  AppState updatedState = AppState(gridSize: previousState.gridSize);
  updatedState.deck = deck;

  return updatedState;
}
