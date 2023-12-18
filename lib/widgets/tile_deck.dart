import 'package:flutter/material.dart';

import 'game_tile.dart';

class TileDeck extends StatefulWidget {
  final int gridSize;
  const TileDeck({super.key, required this.gridSize});

  @override
  State<TileDeck> createState() => _TileDeckState();
}

class _TileDeckState extends State<TileDeck> {
  List<Expanded> tiles = [];
  int tileCount = 0;

  @override
  Widget build(BuildContext context) {
    if(tileCount == 0) {
      generateDeck(widget.gridSize);
    }
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.only(top: 24.0, bottom: 8),
        child: Row(
          children: tiles,
        ),
      ),
    );
  }

  generateDeck(int gridSize) {
    List<Expanded> cells = [];
    for(var i = 0; i < gridSize; i++) {
      cells.add(Expanded(flex: 1, child: GameTile(key: Key(i.toString()), max: widget.gridSize, onDragAccept: removeGameTile,)));
    }
    setState(() {
      tiles = cells;
      tileCount = gridSize;
    });
  }

  void removeGameTile(Key key) {
    int index = tiles.indexWhere((tile) => tile.child.key.toString() == key.toString());
    List<Expanded> updatedTiles = [...tiles];
    updatedTiles.removeAt(index);
    updatedTiles.insert(index, Expanded(flex: 1, child: Container()));
    setState(() {
      tileCount--;
      tiles = updatedTiles;
    });
  }

}
