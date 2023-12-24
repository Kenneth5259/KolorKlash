import 'dart:ui';

import 'package:kolor_klash/widgets/tile_container.dart';

class UpdateColorsAction {
  Map<int, Color> colorMap;
  TileContainer tile;
  int gameTileIndex;

  UpdateColorsAction({required this.colorMap, required this.tile, required this.gameTileIndex});
}
