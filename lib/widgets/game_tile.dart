import 'package:flutter/material.dart';
import 'package:kolor_klash/widgets/flex_column.dart';
import 'dart:math';

import '../state/subclasses/enums.dart';

class GameTile extends StatefulWidget {
  const GameTile({
    Key? key,
    required this.max,
    required this.index,
    required this.colorIndexes,
    this.colors,
    required this.difficulty,
  }) : super(key: key);

  final int min = 0;
  final int max;
  final int index;
  final List<int> colorIndexes;
  final List<Color>? colors;
  final Difficulty difficulty;

  static const List<Color> COLORS = <Color>[Colors.red, Colors.green, Colors.blue, Colors.yellow, Colors.orange];
  static const List<Color> EXPANDED_COLORS = <Color>[
    Colors.red, Colors.green, Colors.blue, Colors.yellow, Colors.orange,
    Colors.purple, Colors.cyan, Colors.lime, Colors.pink, Colors.teal
  ];

  @override
  GameTileState createState() => GameTileState();

  static Color generateColor({bool expanded = false}) {
    final colorSet = expanded ? EXPANDED_COLORS : COLORS;
    final shuffledColors = List.from(colorSet)..shuffle(Random());
    return shuffledColors[0];
  }

  static int generateColumnIndex(int min, int max) {
    Random random = Random();
    return min + random.nextInt(max - min);
  }

  static GameTile generateNewTile(int gridSize, Difficulty difficulty, int index) {
    List<int> colorIndexes = [generateColumnIndex(0, gridSize)];
    List<Color> colors = [generateColor(expanded: difficulty == Difficulty.hard && gridSize == 3)];

    if (difficulty == Difficulty.medium && Random().nextDouble() < 0.3) {
      colorIndexes.add(generateColumnIndex(0, gridSize));
      colors.add(generateColor());
    } else if (difficulty == Difficulty.hard) {
      if (gridSize == 3) {
        // Always add a second color for grid size 3
        colorIndexes.add(generateColumnIndex(0, gridSize));
        colors.add(generateColor(expanded: true));
      } else if (gridSize > 3) {
        // Higher chance to add a second color
        if (Random().nextDouble() < 0.5) {
          colorIndexes.add(generateColumnIndex(0, gridSize));
          colors.add(generateColor());
        }
        // 30% chance to add a third color, but only if gridSize > 4
        if (gridSize > 4 && Random().nextDouble() < 0.3) {
          colorIndexes.add(generateColumnIndex(0, gridSize));
          colors.add(generateColor());
        }
      }
    }

    // Ensure the number of colors does not exceed gridSize - 1
    while (colorIndexes.length >= gridSize) {
      colorIndexes.removeLast();
      colors.removeLast();
    }

    return GameTile(
      max: gridSize,
      index: index,
      colorIndexes: colorIndexes,
      colors: colors,
      difficulty: difficulty,
    );
  }

  Map toJson() {
    return {
      'min': min,
      'max': max,
      'index': index,
      'colorIndexes': colorIndexes,
      'colors': colors?.map((color) => color.value).toList(),
      'difficulty': difficulty.toString(),
    };
  }

  static GameTile loadFromJsonMap(Map item) {
    List<Color> colors = (item['colors'] as List).map((colorValue) => Color(colorValue)).toList();
    Difficulty difficulty = stringToDifficulty(item['difficulty']);
    GameTile tile = GameTile(
      max: item['max'],
      index: item['index'],
      colorIndexes: List<int>.from(item['colorIndexes']),
      colors: colors,
      difficulty: difficulty,
    );
    return tile;
  }
}

class GameTileState extends State<GameTile> {
  Map<int, Color> generateColorMap() {
    Map<int, Color> colorMap = {};
    for (int i = 0; i < widget.colorIndexes.length; i++) {
      colorMap[widget.colorIndexes[i]] = widget.colors?[i] ?? GameTile.generateColor();
    }
    return colorMap;
  }

  List<FlexColumn> generateColumns(Map<int, Color> colorMap) {
    return List.generate(
      widget.max,
          (i) => FlexColumn(color: colorMap[i], isAnimated: false),
    );
  }

  Widget buildTileWidget(Map<int, Color> colorMap) {
    final columns = generateColumns(colorMap);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(children: columns),
    );
  }

  Widget buildDraggableGameTile(GameTilePayload payload, double width, double height, Widget tile) {
    return Draggable<GameTilePayload>(
      data: payload,
      feedback: SizedBox(width: width, height: height, child: tile),
      childWhenDragging: Container(),
      child: tile,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorMap = generateColorMap();
    final tile = buildTileWidget(colorMap);
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        final payload = GameTilePayload(colorMap: colorMap, tileIndex: widget.index);
        return buildDraggableGameTile(payload, width, height, tile);
      },
    );
  }
}

/// Wrapper for data delivered to the tile container on drop
class GameTilePayload {
  final int tileIndex;
  final Map<int, Color> colorMap;
  GameTilePayload({required this.tileIndex, required this.colorMap});
}
