import 'dart:ui';

import '../../widgets/tile_container.dart';

class TileContainerReduxState {
  TileContainer container;
  Map<int, Color> colorMap = {};

  TileContainerReduxState({required this.container});

  Map toJson() {
    return {
      'container': container.toJson(),
      'colorMap': colorMap
    };
  }
}
