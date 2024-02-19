import 'package:flutter/material.dart';
import 'package:kolor_klash/popups/popup_container.dart';
import 'package:kolor_klash/widgets/menu_button.dart';
import 'package:kolor_klash/widgets/white_menu_text.dart';


class SettingsMenu extends StatelessWidget {
  static const POPUP_ID = 'SETTINGS_MENU_ID';
  const SettingsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupContainer(
      menuTitle: 'Settings',
      menuItems: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const WhiteStyledText(text: 'Volume'),
            Slider(
              value: 0.5,
              onChanged: handleVolumeChange,
              activeColor: Colors.white,
            ),
          ],
        ),
        MenuButton(
          onPressed: () {
            // TODO: Restore App Purchases Logic
          },
          buttonText: 'Restore In-App Purchases',
        ),
      ]
    );
  }


  void handleVolumeChange(double newValue) {
    // TODO: Tie Volume to Redux State, dispatch update volume action
  }
}
