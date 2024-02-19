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
    Map<String, int> stringMap = {};
    for (var element in colorMap.entries) {
      stringMap[element.key.toString()] = element.value.value;
    }
    return jsonEncode(stringMap);
  }

  static TileContainerReduxState loadFromJson(Map values) {
    TileContainer loadedContainer = TileContainer.containerFromJson(values['container']);
    Map<int, Color> loadedColorMap = {};
    Map decodedMap = jsonDecode(values['colorMap']);

    if(decodedMap.isNotEmpty) {
      for(var entry in decodedMap.entries) {
        loadedColorMap[int.parse(entry.key)] = Color(entry.value);
      }
    }

    TileContainerReduxState loadedReduxState = TileContainerReduxState(container: loadedContainer);
    loadedReduxState.colorMap = loadedColorMap;

    return loadedReduxState;
  }
}

