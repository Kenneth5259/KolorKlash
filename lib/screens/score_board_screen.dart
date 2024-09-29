import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kolor_klash/screens/new_game_screen.dart';
import 'package:redux/redux.dart';
import '../services/local_file_service.dart';
import '../state/actions/load_existing_game_action.dart';
import '../state/actions/set_active_screen_action.dart';
import '../state/app_state.dart';
import '../state/subclasses/scoreboard.dart';
import '../widgets/menu_button.dart';
import 'main_menu_screen.dart';

class ScoreBoardScreen extends StatefulWidget {

  const ScoreBoardScreen({Key? key}) : super(key: key);

  @override
  _ScoreBoardScreenState createState() => _ScoreBoardScreenState();
}

class _ScoreBoardScreenState extends State<ScoreBoardScreen> {
  List<ScoreEntry> _scores;
  bool _ascending = true;
  int _sortColumnIndex = 0;

  _ScoreBoardScreenState() : _scores = [];

  @override
  void initState() {
    super.initState();
  }

  void _sort<T>(int columnIndex, T Function(ScoreEntry s) getField, bool ascending) {
    _scores = List.from(_scores)..sort((ScoreEntry a, ScoreEntry b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending ? Comparable.compare(aValue as Comparable, bValue as Comparable) : Comparable.compare(bValue as Comparable, aValue as Comparable);
    });
    setState(() {
      _sortColumnIndex = columnIndex;
      _ascending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    return StoreConnector<AppState, AppState>(
        converter: (store) {
            _scores = store.state.scoreBoard?.getScores() ?? [];
            return store.state;
          },
        builder: (context, state) => SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                _buildHeaderCell("Date", 0),
                _buildHeaderCell("Score", 1),
                _buildHeaderCell("Turns", 2),
              ],
            ),
            _divider(),
            Expanded(
              child: ListView.separated(
                itemCount: _scores.length,
                separatorBuilder: (BuildContext context, int index) => _divider(),
                itemBuilder: (context, index){
                  final ScoreEntry entry = _scores[index];
                  return Row(
                    children: [
                      _buildBodyCell(entry.scoreDateString, 0),
                      _buildBodyCell(entry.scoreValue.toString(), 1),
                      _buildBodyCell(entry.turnCount.toString(), 2),
                    ],
                  );
                },
              ),
            ),
            gameButton(store),
            MenuButton(
              onPressed: () => returnToMainMenu(store),
              buttonText: 'Main Menu',
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.075, vertical: 15.0),
      child: const Divider(color: Colors.white),
    );
  }

  Expanded _buildHeaderCell(String label, int index) {
    return Expanded(
      child: InkWell(
        onTap: () {
          switch (index) {
            case 0:
              _sort<DateTime>(index, (ScoreEntry d) => d.scoreDate, !_ascending);
              break;
            case 1:
              _sort<int>(index, (ScoreEntry s) => s.scoreValue, !_ascending);
              break;
            case 2:
              _sort<int>(index, (ScoreEntry t) => t.turnCount, !_ascending);
              break;
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            if (index == _sortColumnIndex)
              Icon(
                _ascending ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                color: Colors.white,
              ),
          ],
        ),
      ),
    );
  }

  Expanded _buildBodyCell(String label, int index) {
    return Expanded(
      child: Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 16)),
    );
  }

  void returnToMainMenu(Store<AppState> store) {
    store.dispatch(SetActiveScreenAction(const MainMenuScreen()));
  }

  void loadExistingGame(Store<AppState> store) async {

    AppState? loadedState = await LocalFileService.readAppState();

    store.dispatch(LoadExistingGameAction(loadedState: loadedState ?? store.state));
  }

  void startNewGame(Store<AppState> store) {
    store.dispatch(SetActiveScreenAction(const NewGameScreen()));
  }

  MenuButton gameButton(Store<AppState> store) {
    if(store.state.isGameOver) {
      return MenuButton(buttonText: 'New Game', onPressed: () => startNewGame(store));
    }
    return MenuButton(
      onPressed: () => loadExistingGame(store),
      buttonText: 'Continue Game',
    );
  }
}