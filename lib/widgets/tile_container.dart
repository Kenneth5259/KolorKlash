import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kolor_klash/state/actions/update_colors_action.dart';
import 'package:kolor_klash/widgets/game_tile.dart';

import '../state/app_state.dart';
import 'flex_column.dart';

class TileContainer extends StatefulWidget {
  final int size;
  // row index for the tile respective to grid
  final int row;
  // column index for the tile respective to grid
  final int column;

  String get coordinate => "($row,$column)";
  GlobalKey<_TileContainerState>? get globalKey => key as GlobalKey<_TileContainerState>?;

  const TileContainer({super.key, required this.size, required this.row, required this.column});

  @override
  State<TileContainer> createState() => _TileContainerState();
}

class _TileContainerState extends State<TileContainer> {

  int filledColumns = 0;

  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) {
        return DragTarget(
          builder: (BuildContext context, List<dynamic> accepted,
              List<dynamic> rejected) {
            return columnView();
          },
          onAccept: (GameTilePayload data) => updateColorMap(data, state),
          onWillAccept: (GameTilePayload? data) => willAccept(data, state),
        );
      },
    );
  }

  Widget columnView() {
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (_, state) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black)
              ),
              child: Row(
                children: List.generate(widget.size, (index) => FlexColumn(color: colorMapFromState(state)[index]))
                ,
              ),
            ),
          );
        }
    );
  }

  updateColorMap(GameTilePayload data, AppState state) {
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(UpdateColorsAction(colorMap: data.colorMap, tile: widget, gameTileIndex: data.tileIndex));
  }

  bool willAccept(GameTilePayload? data, AppState state) {
    if(data == null) {
      return false;
    }
    var entries = data.colorMap.entries;

    bool canAccept = colorMapFromState(state)[entries.first.key] == null;
    if(!canAccept) {
      log("Wont accept");
    }
    return canAccept;
  }

  colorMapFromState(AppState state) {
    return state.grid[widget.row][widget.column].colorMap;
  }

  Set<Color> hasColors(AppState state) {
    Set<Color> colors = {};

    for (MapEntry<int, Color> element in colorMapFromState(state).entries) {
      colors.add(element.value);
    }

    return colors;
  }

  int getColumnCount() {
    return filledColumns;
  }
}
