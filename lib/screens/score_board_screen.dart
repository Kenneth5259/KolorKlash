import 'package:flutter/material.dart';
import '../state/subclasses/scoreboard.dart';

class ScoreBoardScreen extends StatefulWidget {
  final List<ScoreEntry> scores;

  const ScoreBoardScreen({Key? key, required this.scores}) : super(key: key);

  @override
  ScoreBoardScreenState createState() => ScoreBoardScreenState();
}

class ScoreBoardScreenState extends State<ScoreBoardScreen> {
  List<ScoreEntry> _scores;
  bool _ascending = true;
  int _sortColumnIndex = 0;

  ScoreBoardScreenState() : _scores = [];

  @override
  void initState() {
    super.initState();
    _scores.addAll(widget.scores);
  }

  void _sort<T>(int columnIndex, T Function(ScoreEntry s) getField, bool ascending) {
    _scores = List.from(_scores)..sort((ScoreEntry a, ScoreEntry b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue as Comparable, bValue as Comparable)
          : Comparable.compare(bValue as Comparable, aValue as Comparable);
    });
    setState(() {
      _sortColumnIndex = columnIndex;
      _ascending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            IconTheme(
              data: const IconThemeData(color: Colors.white),
              child: DataTable(
                sortColumnIndex: _sortColumnIndex,
                sortAscending: _ascending,
                columns: [
                  DataColumn(
                    label: const Text('Date', style: TextStyle(color: Colors.white, fontSize: 20)),
                    onSort: (columnIndex, ascending) =>
                        _sort<DateTime>(columnIndex, (ScoreEntry d) => d.scoreDate, ascending),
                  ),
                  DataColumn(
                    label: const Text('Score', style: TextStyle(color: Colors.white, fontSize: 20)),
                    onSort: (columnIndex, ascending) =>
                        _sort<int>(columnIndex, (ScoreEntry s) => s.scoreValue, ascending),
                  ),
                  DataColumn(
                    label: const Text('Turns', style: TextStyle(color: Colors.white, fontSize: 20)),
                    onSort: (columnIndex, ascending) =>
                        _sort<int>(columnIndex, (ScoreEntry t) => t.turnCount, ascending),
                  ),
                ],
                rows: _scores.map((ScoreEntry scoreEntry) {
                  return DataRow(cells: [
                    DataCell(Text('${scoreEntry.scoreDate}')),
                    DataCell(Text('${scoreEntry.scoreValue}')),
                    DataCell(Text('${scoreEntry.turnCount}')),
                  ]);
                }).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}