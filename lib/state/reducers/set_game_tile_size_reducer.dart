import 'package:kolor_klash/state/actions/set_game_tile_size_action.dart';
import 'package:kolor_klash/state/app_state.dart';

AppState setGameTileSizeReducer(AppState previousState, SetGameTileSizeAction action) {
  previousState.gameTileHeight = action.height;
  previousState.gameTileWidth = action.width;

  return previousState;
}
