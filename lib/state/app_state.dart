import '../widgets/game_tile.dart';
import '../widgets/tile_container.dart';

class AppState {
  int gridSize;
  late List<List<TileContainer>> grid;

  List<GameTile>? deck;

  AppState({required this.gridSize}) {
    grid = [];
    for(var i = 0; i < gridSize; i++) {
        List<TileContainer> row = [];
        for(var j = 0; j < gridSize; j++) {
          row.add(TileContainer(size: gridSize));
        }
        grid.add(row);
    }
  }

}
