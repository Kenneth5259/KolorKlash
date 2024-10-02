import 'package:flutter/material.dart';
import 'package:kolor_klash/widgets/flex_column.dart';
import 'dart:math';

import '../state/subclasses/enums.dart';

class GameTile extends StatefulWidget {
  const GameTile({
    Key? key,
    required this.max,
    required this.index,
    required this.colorIndex,
    this.color,
    required this.difficulty,
  }) : super(key: key);

  final int min = 0;
  final int max;
  final int index;
  final int colorIndex;
  final Color? color;
  final Difficulty difficulty;

  static const List<Color> COLORS = <Color>[Colors.red, Colors.green, Colors.blue, Colors.yellow, Colors.orange];

  @override
  GameTileState createState() => GameTileState();

  static Color generateColor() {
    final shuffledColors = List.from(GameTile.COLORS)..shuffle(Random());
    return shuffledColors[0];
  }

  static int generateColumnIndex(int min, int max) {
    Random random = Random();
    return min + random.nextInt(max - min);
  }

  Map toJson() {
    return {
      'min': min,
      'max': max,
      'index': index,
      'colorIndex': colorIndex,
      'color': color?.value,
      'difficulty': difficulty.toString(),
    };
  }

  static GameTile loadFromJsonMap(Map item) {
    Color color = Color(item['color']);
    Difficulty difficulty = stringToDifficulty(item['difficulty']);
    GameTile tile = GameTile(
      max: item['max'],
      index: item['index'],
      colorIndex: item['colorIndex'],
      color: color,
      difficulty: difficulty,
    );
    return tile;
  }
}

class GameTileState extends State<GameTile> {
  Map<int, Color> generateColorMap(Color currentColor) {
    Map<int, Color> colorMap = {widget.colorIndex: currentColor};

    if (widget.difficulty == Difficulty.medium) {
      if (Random().nextDouble() < 0.3) {
        int secondColorIndex;
        do {
          secondColorIndex = GameTile.generateColumnIndex(widget.min, widget.max);
        } while (secondColorIndex == widget.colorIndex);
        colorMap[secondColorIndex] = GameTile.generateColor();
      }
    } else if (widget.difficulty == Difficulty.hard && widget.max > 3) {
      if (Random().nextDouble() < 0.5) {
        int secondColorIndex;
        do {
          secondColorIndex = GameTile.generateColumnIndex(widget.min, widget.max);
        } while (secondColorIndex == widget.colorIndex);
        colorMap[secondColorIndex] = GameTile.generateColor();
      }
      if (Random().nextDouble() < 0.1) {
        int thirdColorIndex;
        do {
          thirdColorIndex = GameTile.generateColumnIndex(widget.min, widget.max);
        } while (thirdColorIndex == widget.colorIndex || colorMap.containsKey(thirdColorIndex));
        colorMap[thirdColorIndex] = GameTile.generateColor();
      }
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
    final currentColor = widget.color ?? GameTile.generateColor();
    final colorMap = generateColorMap(currentColor);
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
