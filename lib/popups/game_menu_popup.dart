import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kolor_klash/state/actions/start_new_game_action.dart';
import 'package:kolor_klash/state/app_state.dart';
import 'package:kolor_klash/styles/background_gradient.dart';
import 'package:kolor_klash/widgets/menu_button.dart';
import 'package:redux/redux.dart';

import '../state/actions/update_show_restart_menu_action.dart';

class GameMenu extends StatefulWidget {
  final AppState state;
  const GameMenu({super.key, required this.state});

  @override
  _GameMenuState createState() => _GameMenuState();
}

class _GameMenuState extends State<GameMenu> with SingleTickerProviderStateMixin {
  double _opacity = 0.0;

  void restartGame(Store<AppState> store) {
    setState(() {
      _opacity = 0.0;   // Start fade-out animation before closing the menu
    });
    Future.delayed(Duration(milliseconds: 200), ()
    {
      store.dispatch(StartNewGameAction(widget.state.gridSize));
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        _opacity = 1.0;  // Start fade-in animation on initState
      });
    });
  }

  void closeMenu(Store<AppState> store) {
    setState(() {
      _opacity = 0.0;   // Start fade-out animation before closing the menu
    });
    Future.delayed(Duration(milliseconds: 200), () {
      store.dispatch(UpdateShowRestartMenuAction(false));
    });
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    return AnimatedOpacity(
      opacity: _opacity,
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 300),
      child: Stack(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 32.0, left: 12.0, right: 12.0, bottom: 8.0),
              child: Container(
                  decoration: BoxDecoration(
                      gradient: backgroundGradient,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.7),
                            spreadRadius: 7,
                            blurRadius: 7,
                            offset: const Offset(0, 3)
                        )
                      ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 32),
                            child: Text(
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                ),
                                'Main Menu'
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Takes the user to the new game screen - difficulty selection etc
                                MenuButton(buttonText: 'Play', onPressed: (){}),
                                // Restarts the game with the users current game settings
                                MenuButton(buttonText: 'Restart', onPressed: () => restartGame(store)),
                                // Closes the current popup and opens a game options popup for volume, haptics etc
                                MenuButton(buttonText: 'Options', onPressed: (){}),
                                // Closes the menu and returns the user to the opening screen of the app
                                MenuButton(buttonText: 'Quit', onPressed: (){}),
                              ],
                            ),
                          )
                        ]
                    ),
                  )
              )
          ),
          Positioned(
              top: 24,
              right:4,
              child: Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.7),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 0.25)
                      )
                    ]
                ),
                child: IconButton(
                    iconSize: 16,
                    splashRadius: 20,
                    onPressed: () => {closeMenu(store)}, icon: const Icon(Icons.close)
                ),
              )
          )
        ],
      ),
    );
  }
}
