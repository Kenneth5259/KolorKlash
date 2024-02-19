import 'package:kolor_klash/services/local_file_service.dart';
import 'package:kolor_klash/state/actions/load_existing_game_action.dart';
import 'package:kolor_klash/state/actions/mark_initialized_action.dart';
import 'package:kolor_klash/state/actions/set_active_screen_action.dart';
import 'package:kolor_klash/state/actions/set_game_tile_size_action.dart';
import 'package:kolor_klash/state/actions/set_gridsize_action.dart';
import 'package:kolor_klash/state/actions/start_new_game_action.dart';
import 'package:kolor_klash/state/actions/update_colors_action.dart';
import 'package:kolor_klash/state/actions/update_show_restart_menu_action.dart';
import 'package:kolor_klash/state/actions/update_show_settings_menu_action.dart';
import 'package:kolor_klash/state/reducers/active_screen_reducer.dart';
import 'package:kolor_klash/state/reducers/grid_size_reducer.dart';
import 'package:kolor_klash/state/reducers/load_existing_game_reducer.dart';
import 'package:kolor_klash/state/reducers/mark_initialized_reducer.dart';
import 'package:kolor_klash/state/reducers/set_game_tile_size_reducer.dart';
import 'package:kolor_klash/state/reducers/start_new_game_reducer.dart';
import 'package:kolor_klash/state/reducers/update_colors_reducer.dart';
import 'package:kolor_klash/state/reducers/update_show_restart_menu_reducer.dart';
import 'package:kolor_klash/state/reducers/update_show_settings__menu_reducer.dart';

import 'app_state.dart';

AppState appReducer(AppState previousState, dynamic action) {
  AppState state = stateFromReducer(previousState, action);
  LocalFileService.writeAppState(state);
  return state;
}

AppState stateFromReducer(AppState previousState, dynamic action) {
  if(action is MarkInitializedAction) {
    return markInitializedReducer(previousState);
  }
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
  if(action is UpdateShowSettingsMenuAction) {
    return updateShowSettingsMenuReducer(previousState, action);
  }
  if(action is LoadExistingGameAction) {
    return loadExistingGameReducer(action.loadedState);
  }
  return previousState;
}
