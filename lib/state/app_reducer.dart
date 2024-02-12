import 'package:kolor_klash/state/actions/set_active_screen_action.dart';
import 'package:kolor_klash/state/actions/set_game_tile_size_action.dart';
import 'package:kolor_klash/state/actions/set_gridsize_action.dart';
import 'package:kolor_klash/state/actions/start_new_game_action.dart';
import 'package:kolor_klash/state/actions/update_colors_action.dart';
import 'package:kolor_klash/state/actions/update_show_restart_menu_action.dart';
import 'package:kolor_klash/state/reducers/active_screen_reducer.dart';
import 'package:kolor_klash/state/reducers/grid_size_reducer.dart';
import 'package:kolor_klash/state/reducers/set_game_tile_size_reducer.dart';
import 'package:kolor_klash/state/reducers/start_new_game_reducer.dart';
import 'package:kolor_klash/state/reducers/update_colors_reducer.dart';
import 'package:kolor_klash/state/reducers/update_show_restart_menu_action.dart';

import 'app_state.dart';

AppState appReducer(AppState previousState, dynamic action) {
  if(action is SetGridSizeAction) {
    return gridSizeReducer(previousState, action);
  }
  if(action is UpdateColorsAction) {
    return updateColorsReducer(previousState, action);
  }
  if(action is UpdateShowRestartMenuAction) {
    return updateShowRestartMenuActionReducer(previousState, action);
  }
  if(action is StartNewGameAction) {
    return startNewGameReducer(previousState, action);
  }
  if(action is SetGameTileSizeAction) {
    return setGameTileSizeReducer(previousState, action);
  }
  if(action is SetActiveScreenAction) {
    return activeScreenReducer(previousState, action);
  }
  return previousState;
}
