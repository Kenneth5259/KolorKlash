import '../widgets/game_tile.dart';
import '../widgets/tile_container.dart';

class AppState {
  int gridSize;
  late List<List<TileContainer>> grid;

  late List<GameTile?> deck;

  AppState({required this.gridSize}) {
    grid = [];
    deck = [];
    for(var i = 0; i < gridSize; i++) {
        List<TileContainer> row = [];
        for(var j = 0; j < gridSize; j++) {
          row.add(TileContainer(size: gridSize));
        }
        deck.add(GameTile(max: gridSize));
        grid.add(row);
    }
  }

}
