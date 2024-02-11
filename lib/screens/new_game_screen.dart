import 'package:flutter/material.dart';
import 'package:kolor_klash/state/subclasses/enums.dart';

class NewGameScreen extends StatefulWidget {
  const NewGameScreen({Key? key}) : super(key: key);

  @override
  State<NewGameScreen> createState() => _NewGameScreenState();
}

class _NewGameScreenState extends State<NewGameScreen> {
  String selectedDifficulty = 'Easy';
  String selectedGridSize = '3';

  updateSelectedDifficulty (String? newValue) {
    setState(() {
      selectedDifficulty = newValue!;
    });
  }

  updateSelectedGridSize (String? newValue) {
    setState(() {
      selectedGridSize = newValue!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildLabeledDropdown('Select Difficulty', {
              'Easy': Difficulty.easy,
              'Medium': Difficulty.medium,
              'Hard': Difficulty.hard
            }, updateSelectedDifficulty, selectedDifficulty),
            buildLabeledDropdown('Select Grid Size', {
              '3': 3,
              '4': 4,
              '5': 5
            }, updateSelectedGridSize, selectedGridSize),
          ],
        ),
      ),
    );
  }

  Widget buildLabeledDropdown(String title, Map<String, dynamic> options, void Function(String?)? onChanged, String selectedValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title),
        DropdownButton(
          value: selectedValue,
          onChanged: onChanged,
          items: options.entries
              .map<DropdownMenuItem<String>>((MapEntry<String, dynamic> entry) {
            return DropdownMenuItem<String>(
              value: entry.key,
              child: Text(entry.key),
            );
          }).toList(),
        ),
      ],
    );
  }
}
