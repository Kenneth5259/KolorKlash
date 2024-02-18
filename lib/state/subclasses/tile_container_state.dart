import 'dart:convert';
import 'dart:ui';

import '../../widgets/tile_container.dart';

class TileContainerReduxState {
  TileContainer container;
  Map<int, Color> colorMap = {};

  TileContainerReduxState({required this.container});

  Map toJson() {
    return {
      'container': container.toJson(),
      'colorMap': encodeColorMap()
    };
  }

  String encodeColorMap() {
    Map<String, String> stringMap = {};
    for (var element in colorMap.entries) {
      stringMap[element.key.toString()] = element.value.toString();
    }
    return jsonEncode(stringMap);
  }

}
