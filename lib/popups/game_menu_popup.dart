import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kolor_klash/popups/popup_container.dart';
import 'package:kolor_klash/popups/settings_menu_popup.dart';
import 'package:kolor_klash/screens/main_menu_screen.dart';
import 'package:kolor_klash/state/actions/start_new_game_action.dart';
import 'package:kolor_klash/state/actions/update_active_popup_action.dart';
import 'package:kolor_klash/state/app_state.dart';
import 'package:kolor_klash/widgets/menu_button.dart';
import 'package:redux/redux.dart';

import '../state/actions/set_active_screen_action.dart';

class GameMenu extends StatelessWidget {
  static const POPUP_ID = 'GAME_MENU_POPUP';
  final AppState state;
  const GameMenu({super.key, required this.state});

  void restartGame(Store<AppState> store) {
    store.dispatch(StartNewGameAction(state.gridSize, state.difficulty));
  }

  void returnToMainMenu(Store<AppState> store) {
    store.dispatch(SetActiveScreenAction(const MainMenuScreen()));
  }

  void settingsMenu(Store<AppState> store) {
    store.dispatch(UpdateActivePopupAction(SettingsMenu.POPUP_ID));
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    return PopupContainer(
        menuTitle: 'Game Menu',
        menuItems: [
          // Takes the user to the new game screen - difficulty selection etc
          MenuButton(buttonText: 'Play', onPressed: (){}),
          // Restarts the game with the users current game settings
          MenuButton(buttonText: 'Restart', onPressed: () => restartGame(store)),
          // Closes the current popup and opens a game options popup for volume, haptics etc
          MenuButton(buttonText: 'Options', onPressed: () => settingsMenu(store)),
          // Closes the menu and returns the user to the opening screen of the app
          MenuButton(buttonText: 'Quit', onPressed: () => returnToMainMenu(store)),
        ]
    );
  }
}

