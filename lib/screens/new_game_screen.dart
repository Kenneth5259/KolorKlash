import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kolor_klash/extensions/string_extensions.dart';
import 'package:kolor_klash/screens/main_menu_screen.dart';
import 'package:kolor_klash/state/actions/set_active_screen_action.dart';
import 'package:kolor_klash/state/actions/start_new_game_action.dart';
import 'package:kolor_klash/widgets/menu_button.dart';
import 'package:kolor_klash/widgets/white_menu_text.dart';

import '../state/app_state.dart';
import '../state/subclasses/enums.dart';

class NewGameScreen extends StatefulWidget {
  const NewGameScreen({Key? key}) : super(key: key);

  @override
  State<NewGameScreen> createState() => _NewGameScreenState();
}

class _NewGameScreenState extends State<NewGameScreen> {
  Difficulty selectedDifficulty = Difficulty.easy;
  GameSize selectedGridSize = GameSize.three;

  Map<Difficulty, Difficulty> difficultyMap = {
    Difficulty.easy: Difficulty.easy,
    Difficulty.medium: Difficulty.medium,
    Difficulty.hard: Difficulty.hard
  };

  Map<GameSize, int> gridSizeMap = {
    GameSize.three: 3,
    GameSize.four: 4,
    GameSize.five: 5
  };

  /// Reorders a map to place the selected value at the top
  Map<T, U> reorderMap<T, U>(Map<T, U> original, T topKey) {
    Map<T, U> tempMap = <T, U>{};
    tempMap.addEntries(original.entries);
    U topValue = original.remove(topKey)!;
    Map<T, U> newMap = {
      topKey: topValue
    };
    newMap.addEntries(tempMap.entries);
    return newMap;
  }

  void updateSelectedDifficulty (Difficulty? newValue) {
    setState(() =>
    {
      selectedDifficulty = newValue!,
      difficultyMap = reorderMap(difficultyMap, newValue)
    });
  }

  void updateSelectedGridSize (GameSize? newValue) {
    setState(() =>
    {
      selectedGridSize = newValue!,
      gridSizeMap = reorderMap(gridSizeMap, newValue)
    });
  }

  void dispatchNewGameAction() {
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(StartNewGameAction(gridSizeMap[gridSizeMap.keys.first]!, selectedDifficulty));
  }

  void dispatchMainMenuAction() {
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(SetActiveScreenAction(const MainMenuScreen()));
  }

  Widget buildLabeledDropdown<T>(String title, Map<T, dynamic> options, void Function(T?)? onChanged, T selectedValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        WhiteStyledText(text: title),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButton<T>(
                value: selectedValue,
                onChanged: onChanged,
                dropdownColor: const Color.fromRGBO(0, 0, 0, 0.75),
                items: options.entries
                    .map<DropdownMenuItem<T>>((MapEntry<T, dynamic> entry) {
                  return DropdownMenuItem<T>(
                    value: entry.key,
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      style: const TextStyle(fontSize: 24, backgroundColor: Colors.transparent, color: Colors.white),
                      entry.key.toString().split('.').last.capitalize()
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32
                ),
                'Create New Game'
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32.0),
                    child: buildLabeledDropdown<Difficulty>('Select Difficulty', difficultyMap, updateSelectedDifficulty, selectedDifficulty),
                  ),
                  buildLabeledDropdown<GameSize>('Select Grid Size', gridSizeMap, updateSelectedGridSize, selectedGridSize),
                ],
              ),
            ),
            Column(
              children: [
                MenuButton(buttonText: 'Start New Game', onPressed: () => dispatchNewGameAction()),
                const Padding(padding: EdgeInsets.symmetric(vertical: 16)),
                MenuButton(buttonText: 'Main Menu', onPressed: () => dispatchMainMenuAction()),
              ],
            )

          ],
        ),
      ),
    );
  }
}
