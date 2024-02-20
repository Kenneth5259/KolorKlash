import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:kolor_klash/popups/popup_container.dart';
import 'package:kolor_klash/state/actions/update_volume_action.dart';
import 'package:kolor_klash/widgets/menu_button.dart';
import 'package:kolor_klash/widgets/white_menu_text.dart';
import 'package:kolor_klash/state/app_state.dart';


class SettingsMenu extends StatefulWidget {
  static const POPUP_ID = 'SETTINGS_MENU_ID';
  const SettingsMenu({super.key});

  @override
  State<SettingsMenu> createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {
  double volume = 0.5;
  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);

    handleVolumeChange(store.state.volume);

    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) => PopupContainer(
          menuTitle: 'Settings',
          menuItems: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const WhiteStyledText(text: 'Volume'),
                Slider(
                  value: volume,
                  onChanged: (val) => handleVolumeChange(val),
                  onChangeEnd: (val) => handleVolumeChangeEnd(store, val),
                  activeColor: Colors.white,
                ),
              ],
            ),
            const SizedBox(width: 0,height: 150,),
            MenuButton(
              onPressed: () {
                // TODO: Restore App Purchases Logic
              },
              buttonText: 'Restore In-App Purchases',
            ),
          ]
      ),
    );
  }

  void handleVolumeChange(double newVolume) {
    setState(() {
      volume = newVolume;
    });
  }

  void handleVolumeChangeEnd(Store<AppState> store, double newVolume) {
    // TODO: Tie Volume to Redux State, dispatch update volume action
    handleVolumeChange(newVolume);
    store.dispatch(UpdateVolumeAction(newVolume));
  }
}
