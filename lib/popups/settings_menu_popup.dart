import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kolor_klash/widgets/volume_slider.dart';
import 'package:kolor_klash/popups/popup_container.dart';
import 'package:kolor_klash/widgets/menu_button.dart';
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
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) => PopupContainer(
          menuTitle: 'Settings',
          menuItems: [
            const VolumeSlider(),
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
}
