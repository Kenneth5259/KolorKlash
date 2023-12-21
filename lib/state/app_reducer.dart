import 'package:kolor_klash/state/actions/set_gridsize_action.dart';
import 'package:kolor_klash/state/actions/update_deck_action.dart';
import 'package:kolor_klash/state/reducers/grid_size_reducer.dart';
import 'package:kolor_klash/state/reducers/update_deck_reducer.dart';

import 'app_state.dart';

AppState appReducer(AppState previousState, dynamic action) {
  if(action is SetGridSizeAction) {
    return gridSizeReducer(previousState, action);
  }
  if(action is UpdateDeckAction) {
    return updateDeckReducer(previousState, action);
  }
  return previousState;
}
