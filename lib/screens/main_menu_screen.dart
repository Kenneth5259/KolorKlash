import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kolor_klash/screens/new_game_screen.dart';
import 'package:kolor_klash/state/actions/set_active_screen_action.dart';

import '../state/app_state.dart';
import '../widgets/menu_button.dart';

class MainMenuScreen extends StatefulWidget {
  MainMenuScreen({super.key});

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

  Widget buildButton(String label, Animation<Offset> animation, Function onPressed) {
    return SlideTransition(
      position: animation,
      child: MenuButton(buttonText: label, onPressed: onPressed),
    );
  }

  void newGameScreen() {
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(SetActiveScreenAction(const NewGameScreen()));
  }

  @override
  void initState() {
    super.initState();

    void _initAnimations(Duration delay, AnimationController controller, Animation<Offset> offsetAnimation) async {
      await Future.delayed(delay);
      controller.forward();
    }

    controller1 = AnimationController(
      duration: Duration(milliseconds: 250),
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
      duration: Duration(milliseconds: 250),
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
      duration: Duration(milliseconds: 500),
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

    _initAnimations(const Duration(milliseconds: 0), controller1, offsetAnimation1);
    _initAnimations(const Duration(milliseconds: 400), controller2, offsetAnimation2);
    _initAnimations(const Duration(milliseconds: 400), controller3, offsetAnimation3);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                buildButton('Score Board', offsetAnimation2, (){}),
                buildButton('Settings', offsetAnimation3, (){}),
              ],
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: IconButton(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              iconSize: 48,
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
          ),
        ),
      ],
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
