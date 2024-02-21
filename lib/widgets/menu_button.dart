import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kolor_klash/widgets/gradient_text.dart';
import 'package:redux/redux.dart';

import '../state/app_state.dart';

class MenuButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;
  final double? height;

  const MenuButton({super.key, required this.buttonText, required this.onPressed, this.height});

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        onPressed: () => pressWithSound(store),
        child: Container(
          constraints: BoxConstraints(
            minHeight: height ?? 50
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientText(buttonText: buttonText)
            ],
          ),
        ),
      ),
    );
  }

  void pressWithSound(Store<AppState> store) {
    double volume = store.state.volume;
    AudioPlayer effectPlayer = AudioPlayer();
    effectPlayer.setVolume(volume);
    effectPlayer.play(AssetSource('music/effect/click-button-140881.mp3'));
    onPressed();
  }
}
