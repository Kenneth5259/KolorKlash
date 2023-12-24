import 'package:kolor_klash/state/actions/set_gridsize_action.dart';
import 'package:kolor_klash/state/actions/update_colors_action.dart';
import 'package:kolor_klash/state/reducers/grid_size_reducer.dart';
import 'package:kolor_klash/state/reducers/update_colors_reducer.dart';

import 'app_state.dart';

AppState appReducer(AppState previousState, dynamic action) {
  if(action is SetGridSizeAction) {
    return gridSizeReducer(previousState, action);
  }
  if(action is UpdateColorsAction) {
    return updateColorsReducer(previousState, action);
  }
  return previousState;
}
