import 'package:kolor_klash/state/subclasses/enums.dart';

class StartNewGameAction {
  final int _gridSize;
  final Difficulty _difficulty;
  int get gridSize => _gridSize;
  Difficulty get difficulty => _difficulty;

  StartNewGameAction(this._gridSize, this._difficulty);
}
