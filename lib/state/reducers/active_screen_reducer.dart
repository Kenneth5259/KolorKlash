import 'dart:developer';

import 'package:kolor_klash/state/actions/set_active_screen_action.dart';
import 'package:kolor_klash/state/app_state.dart';

AppState activeScreenReducer(AppState previousState, SetActiveScreenAction action) {
  previousState.activeScreen = action.screen;
  previousState.initialized = true;
  log(previousState.toJson().toString());
  return previousState;
}
