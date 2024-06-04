import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kolor_klash/popups/popup_container.dart';
import 'package:kolor_klash/screens/score_board_screen.dart';
import 'package:kolor_klash/widgets/menu_button.dart';
import 'package:kolor_klash/state/app_state.dart';
import 'package:redux/redux.dart';

import '../screens/main_menu_screen.dart';
import '../screens/new_game_screen.dart';
import '../state/actions/set_active_screen_action.dart';

class GameOverMenu extends StatefulWidget {
  static const POPUP_ID = 'GAMEOVER_MENU_ID';
  const GameOverMenu({Key? key}) : super(key: key);

  @override
  _GameOverMenuState createState() => _GameOverMenuState();
}

class _GameOverMenuState extends State<GameOverMenu> {
  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);

    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) => PopupContainer(
        menuTitle: 'Game Over',
        menuItems: [
          Text(
            'YOUR SCORE: ${state.score}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            'TURNS: ${state.turnCount}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          MenuButton(
            onPressed: () => newGameScreen(store),
            buttonText: 'New Game',
          ),
          MenuButton(
            onPressed: () => returnToMainMenu(store),
            buttonText: 'Main Menu',
          ),
          MenuButton(
            onPressed: () => scoreBoardScreen(store),
            buttonText: 'Score Board',
          ),
        ],
      ),
    );
  }

  void newGameScreen(Store<AppState> store) {
    store.dispatch(SetActiveScreenAction(const NewGameScreen()));
  }

  void scoreBoardScreen(Store<AppState> store) {
    store.dispatch(SetActiveScreenAction(const ScoreBoardScreen(scores: [])));
  }

  void returnToMainMenu(Store<AppState> store) {
    store.dispatch(SetActiveScreenAction(const MainMenuScreen()));
  }
}
