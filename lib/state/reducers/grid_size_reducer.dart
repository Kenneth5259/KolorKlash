import 'package:kolor_klash/state/app_state.dart';
import 'package:kolor_klash/state/subclasses/tile_container_state.dart';

import '../../widgets/tile_container.dart';
import '../actions/set_gridsize_action.dart';

AppState gridSizeReducer(AppState previousState, SetGridSizeAction action) {
  // initialize a clean grid
  List<List<TileContainerReduxState>> grid = previousState.grid;

  // if the previous grid wasn't correct
  if(grid.length != action.gridSize) {
    // for each row in height
    for(var i = 0; i < action.gridSize; i++) {
      // create new row
      List<TileContainerReduxState> row = [];
      for(var j = 0; j < action.gridSize; j++) {
        // push new row entry
        row.add(TileContainerReduxState(container: TileContainer(size: action.gridSize, row: i, column: j)));
      }
      // stack row onto grid
      grid.add(row);
    }
  }

  return AppState(gridSize: action.gridSize);
}
