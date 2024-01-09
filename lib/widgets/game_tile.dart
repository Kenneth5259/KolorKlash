import 'package:flutter/material.dart';
import 'package:kolor_klash/widgets/flex_column.dart';
import 'dart:math';

class GameTile extends StatefulWidget {
  GameTile({
    Key? key,
    required this.max,
    required this.index,
    required this.colorIndex,
    this.color
  }) : super(key: key);

  final int min = 0;
  final int max;
  final int index;
  final int colorIndex;
  final Color? color;

  static const List<Color> COLORS = <Color>[Colors.red, Colors.green, Colors.blue, Colors.yellow, Colors.orange];

  @override
  GameTileState createState() => GameTileState();  // made the GameTileState class public

  static Color generateColor() {
    final shuffledColors = List.from(GameTile.COLORS)..shuffle(Random());
    return shuffledColors[0];
  }

  static int generateColumnIndex(int min, int max) {
    Random random = Random();
    return min + random.nextInt(max - min);
  }
}

class GameTileState extends State<GameTile> { // made the GameTileState class public
  List<FlexColumn> generateColumns(Color currentColor) {
    return List.generate(
        widget.max, (i) => FlexColumn(color: i == widget.colorIndex ? currentColor : null, isAnimated: false,));
  }

  Widget buildTileWidget(Color currentColor, int colorIndex) {
    final columns = generateColumns(currentColor);
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
    final tile = buildTileWidget(currentColor, widget.colorIndex);
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        final payload = GameTilePayload(colorMap: {widget.colorIndex: currentColor}, tileIndex: widget.index);
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
