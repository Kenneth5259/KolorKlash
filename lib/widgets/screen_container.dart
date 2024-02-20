import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../state/app_state.dart';

class ScreenContainer extends StatelessWidget {
  final AudioPlayer player;
  const ScreenContainer({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Widget?>(
        converter: (store) {
          player.setVolume(store.state.volume * 0.75);
          return store.state.activeScreen;
          },
        builder: (BuildContext context, Widget? activeScreen) => Container(child: activeScreen)
    );
  }
}
