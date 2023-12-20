import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../state/app_state.dart';
import 'game_tile.dart';

class TileDeck extends StatefulWidget {
  const TileDeck({super.key});

  @override
  State<TileDeck> createState() => _TileDeckState();
}

class _TileDeckState extends State<TileDeck> {
  int tileCount = 0;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) {
        return Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(top: 24.0, bottom: 8),
            child: Row(
              children: displayDeck(state.deck),
            ),
          ),
        );
      }
    );
  }

  List<Expanded> displayDeck(List<GameTile?> tiles) {
    List<Expanded> cells = [];
    for(var tile in tiles) {
      cells.add(Expanded(flex: 1, child: tile ?? Container()));
    }
    return cells;
  }

  void removeGameTile(Key key) {
    // int index = tiles.indexWhere((tile) => tile.child.key.toString() == key.toString());
    // List<Expanded> updatedTiles = [...tiles];
    // updatedTiles.removeAt(index);
    // updatedTiles.insert(index, Expanded(flex: 1, child: Container()));
    // setState(() {
    //   tileCount--;
    //   tiles = updatedTiles;
    // });
  }

}
