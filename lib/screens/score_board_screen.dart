import 'package:flutter/material.dart';

import '../state/subclasses/scoreboard.dart';

class ScoreBoardScreen extends StatefulWidget {
  final List<ScoreEntry> scores;

  const ScoreBoardScreen({Key? key, required this.scores}) : super(key: key);

  @override
  State<ScoreBoardScreen> createState() => _ScoreBoardScreenState();
}

class _ScoreBoardScreenState extends State<ScoreBoardScreen> {
  late List<ScoreEntry> _scores;
  bool _ascending = true;

  @override
  void initState() {
    super.initState();
    _scores = widget.scores;
  }

  void _sort<T>(T Function(ScoreEntry s) getField, int Function(T a, T b) compare, bool ascending) {
    _scores.sort((ScoreEntry a, ScoreEntry b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? compare(aValue, bValue)
          : compare(bValue, aValue);
    });
    setState(() {
      _ascending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: DataTable(
        sortColumnIndex: 0,
        sortAscending: _ascending,
        columns: [
          DataColumn(label: const Text('Score Date'),
              onSort: (int columnIndex, bool ascending) => _sort<DateTime>((ScoreEntry d) => d.scoreDate, (a, b) => a.compareTo(b), ascending)),
          DataColumn(label: const Text('Score Value'),
              onSort: (int columnIndex, bool ascending) => _sort<int>((ScoreEntry s) => s.scoreValue, (a, b) => a.compareTo(b), ascending)),
          DataColumn(label: const Text('Turn Count'),
              onSort: (int columnIndex, bool ascending) => _sort<int>((ScoreEntry t) => t.turnCount, (a, b) => a.compareTo(b), ascending)),
        ],
        rows: _scores.map((ScoreEntry scoreEntry) {
          return DataRow(cells: [
            DataCell(Text('${scoreEntry.scoreDate}')),
            DataCell(Text('${scoreEntry.scoreValue}')),
            DataCell(Text('${scoreEntry.turnCount}')),
          ]);
        }).toList(),
      ),
    );
  }
}
