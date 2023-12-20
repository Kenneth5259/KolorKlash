import '../../widgets/game_tile.dart';

class UpdateDeckAction {
  final List<GameTile> _tiles;
  final GameTile _removedTile;

  List<GameTile> get tiles => _tiles;
  GameTile get removedTile => _removedTile;

  UpdateDeckAction(this._tiles, this._removedTile);
}
