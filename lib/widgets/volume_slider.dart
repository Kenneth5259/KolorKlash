import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kolor_klash/widgets/white_menu_text.dart';
import 'package:redux/redux.dart';

import '../state/actions/update_volume_action.dart';
import '../state/app_state.dart';

class VolumeSlider extends StatefulWidget {
  const VolumeSlider({super.key});

  @override
  State<VolumeSlider> createState() => _VolumeSliderState();
}

class _VolumeSliderState extends State<VolumeSlider> {
  double? volume;
  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const WhiteStyledText(text: 'Volume'),
        Slider(
          value: volume ?? store.state.volume,
          min: 0,
          max: 1,
          divisions: 100,
          onChanged: (val) => handleVolumeChange(store, val),
          activeColor: Colors.white,
        ),
      ],
    );
  }

  void handleVolumeChange(Store<AppState> store, double newVolume) {
    setState(() {
      volume = newVolume;
      store.dispatch(UpdateVolumeAction(newVolume));
    });
  }

}
