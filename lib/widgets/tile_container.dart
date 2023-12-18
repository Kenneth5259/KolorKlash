import 'dart:developer';

import 'package:flutter/material.dart';

import 'flex_column.dart';

class TileContainer extends StatefulWidget {
  final int columnCount;
  const TileContainer({super.key, required this.columnCount});

  @override
  State<TileContainer> createState() => _TileContainerState();
}

class _TileContainerState extends State<TileContainer> {
  final Map<int, Color> colorMap = {};

  @override
  Widget build(BuildContext context) {

    Widget columnView = Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black)
        ),
        child: Row(
          children: List.generate(widget.columnCount, (index) => FlexColumn(color: colorMap[index]))
          ,
        ),
      ),
    );

    return DragTarget(
      builder: (BuildContext context, List<dynamic> accepted, List<dynamic> rejected) {
        return columnView;
      },
      onAccept: (Map<int, Color> data) => updateColorMap(data),
      onWillAccept: (Map<int, Color>? data) => willAccept(data),
    );
  }

  updateColorMap(Map<int, Color> data) {
    setState((){
      var entries = data.entries;
      colorMap[entries.first.key] = entries.first.value;
    });
  }

  bool willAccept(Map<int, Color>? data) {
    if(data == null) {
      return false;
    }
    var entries = data.entries;

    bool canAccept = colorMap[entries.first.key] == null;
    if(!canAccept) {
      log("Wont accept");
    }
    return canAccept;
  }

  Set<Color> hasColors() {
    Set<Color> colors = {};

    for (MapEntry<int, Color> element in colorMap.entries) {
      colors.add(element.value);
    }

    return colors;
  }
}
