import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kolor_klash/state/actions/update_colors_action.dart';
import 'package:kolor_klash/widgets/game_tile.dart';
import '../state/app_state.dart';
import 'flex_column.dart';

class TileContainer extends StatefulWidget {
  final int size;
  final int row;
  final int column;

  const TileContainer({Key? key, required this.size, required this.row, required this.column}) : super(key: key);

  @override
  State<TileContainer> createState() => _TileContainerState();

  Map toJson() {
    return {
      'size': size,
      'row': row,
      'column': column
    };
  }
}

class _TileContainerState extends State<TileContainer> {
  int numberOfFilledColumns = 0;

  @override
  Widget build(BuildContext context) {
    return storeConnectorWidget(context, (state) => DragTarget(
        builder: (BuildContext context, List<dynamic> accepted, List<dynamic> rejected) => columnView(state),
        onAccept: (GameTilePayload data) => updateColorMap(data, state),
        onWillAccept: (GameTilePayload? data) => willAccept(data, state)
    ));
  }

  Widget columnView(AppState state) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: List.generate(widget.size, (index) => FlexColumn(color: colorMapFromState(state)[index])),
      ),
    );
  }

  void updateColorMap(GameTilePayload data, AppState state) {
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(UpdateColorsAction(colorMap: data.colorMap, tile: widget, gameTileIndex: data.tileIndex));
  }

  bool willAccept(GameTilePayload? data, AppState state) {
    if(data == null) {
      return false;
    }
    var entries = data.colorMap.entries;
    bool canAccept = colorMapFromState(state)[entries.first.key] == null;
    return canAccept;
  }

  Widget storeConnectorWidget(BuildContext context, Function(AppState state) builderMethod){
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (_, state) => builderMethod(state));
  }

  Map<int, Color> colorMapFromState(AppState state) => state.grid[widget.row][widget.column].colorMap;

  Set<Color> hasColors(AppState state) {
    Set<Color> colors = {};
    colorMapFromState(state).forEach((key, color) {
      colors.add(color);
    });
    return colors;
  }

  int getColumnCount() {
    return numberOfFilledColumns;
  }
}
