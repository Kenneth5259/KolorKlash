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
