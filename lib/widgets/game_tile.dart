import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kolor_klash/widgets/flex_column.dart';
import 'dart:math';

import '../state/app_state.dart';

class GameTile extends StatelessWidget {
  GameTile({super.key, required this.max, required this.index, required this.colorIndex, this.color});

  final min = 0;
  final int max;
  final int index;
  final int colorIndex;
  final Color? color;


  @override
  Widget build(BuildContext context) {
    var currentColor = color ?? generateColor();

    Widget tile = Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black)
        ),
        child: Row(
          children: generateColumns(colorIndex),
        ),
      ),
    );

    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (_, state) {
          return Draggable<GameTilePayload>(
            data: GameTilePayload(colorMap: {colorIndex: currentColor}, tileIndex: index),
            feedback: SizedBox(
                width: 75,
                height: 75,
                child: tile
            ),
            childWhenDragging: null,
            child: tile,
          );
        }
    );
  }


  List<FlexColumn> generateColumns(int colorIndex) {
    List<FlexColumn> columns = [];

    for (var i = 0; i < max; i++) {
      columns.add(FlexColumn(color: i == colorIndex ? color : null));
    }

    return columns;
  }

  static Color generateColor() {
    const colors = <Color>[Colors.red, Colors.green, Colors.blue, Colors.yellow, Colors.orange];
    // shuffle the available colors
    var shuffledColors = [...colors];
    shuffledColors.shuffle(Random());

    // set the color for the column
    return shuffledColors[0];
  }

  static int generateColumnIndex(int min, int max) {
    Random random = Random();
    return min + random.nextInt(max - min);
  }

}

/// Wrapper for data delivered to the tile container on drop
///
/// tileIndex refers to the index in the deck, 0 being leftmost, max-1 being rightmost
/// colorMap is the index of the colored column(s) and corresponding value(s)
class GameTilePayload {
  final int tileIndex;
  final Map<int, Color> colorMap;

  GameTilePayload({required this.tileIndex, required this.colorMap});
}
