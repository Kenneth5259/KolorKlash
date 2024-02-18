import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kolor_klash/popups/settings_menu_popup.dart';
import 'package:kolor_klash/screens/new_game_screen.dart';
import 'package:kolor_klash/state/actions/set_active_screen_action.dart';
import 'package:kolor_klash/state/actions/update_show_settings_menu_action.dart';

import '../state/actions/mark_initialized_action.dart';
import '../state/app_state.dart';
import '../widgets/menu_button.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();

}

class _MainMenuScreenState extends State<MainMenuScreen> with TickerProviderStateMixin {
  late AnimationController controller1;
  late AnimationController controller2;
  late AnimationController controller3;
  late Animation<Offset> offsetAnimation1;
  late Animation<Offset> offsetAnimation2;
  late Animation<Offset> offsetAnimation3;

  int animationCount = 0;

  Widget buildButton(String label, Animation<Offset> animation, Function onPressed) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (BuildContext context, AppState state) =>
      !state.initialized ?
          SlideTransition(
            position: animation,
            child: MenuButton(buttonText: label, onPressed: onPressed),
          ) :
          MenuButton(buttonText: label, onPressed: onPressed)
    );
  }

  Widget? buildSettingsMenu() {
    Widget value =  StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (BuildContext context, AppState state) =>
          state.showSettingsMenu ? const SettingsMenu() : Container()
    );
    return value is! Container ? value : null;
  }

  List<Widget> buildMenuStack() {
    List<Widget> menuStack = [
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          const Expanded(
            child: Center(
              child: Text(
                'Kolor Klash',
                style: TextStyle(fontSize: 48.0, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  buildButton('Play', offsetAnimation1, () => newGameScreen()),
                  // TODO: Add Score Board Screen & Score History Locally
                  buildButton('Score Board', offsetAnimation2, (){}),
                ],
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: IconButton(
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                iconSize: 48,
                icon: const Icon(Icons.settings),
                onPressed: () => showSettingsMenu(),
              ),
            ),
          ),
        ],
      ),
    ];
    Widget? settingsMenu = buildSettingsMenu();
    if(settingsMenu != null) {
      menuStack.add(settingsMenu);
    }
    return menuStack;
  }

  void newGameScreen() {
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(SetActiveScreenAction(const NewGameScreen()));
  }

  void showSettingsMenu() {
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(UpdateShowSettingsMenuAction(true));
  }

  void markInitialized() {
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(MarkInitializedAction());
  }

  @override
  void initState() {
    super.initState();

    void initAnimations(Duration delay, AnimationController controller, Animation<Offset> offsetAnimation) async {
      await Future.delayed(delay);
      controller.forward();
      setState(() {
        ++animationCount;
      });
      if(animationCount > 2) {
        markInitialized();
      }
    }

    controller1 = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    offsetAnimation1 = Tween<Offset>(
      begin: const Offset(-3.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: controller1,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeOut,
    ));

    controller2 = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    offsetAnimation2 = Tween<Offset>(
      begin: const Offset(-3.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: controller2,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeOut,
    ));

    controller3 = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    offsetAnimation3 = Tween<Offset>(
      begin: const Offset(-3.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: controller3,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeOut,
    ));

    initAnimations(const Duration(milliseconds: 100), controller1, offsetAnimation1);
    initAnimations(const Duration(milliseconds: 500), controller2, offsetAnimation2);
    initAnimations(const Duration(milliseconds: 900), controller3, offsetAnimation3);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: buildMenuStack(),
    );
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    super.dispose();
  }
}
