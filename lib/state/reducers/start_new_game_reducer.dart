import 'package:kolor_klash/screens/game_board_screen.dart';
import 'package:kolor_klash/services/local_file_service.dart';
import 'package:kolor_klash/state/actions/start_new_game_action.dart';
import 'package:kolor_klash/state/app_state.dart';

AppState startNewGameReducer(AppState previousState, StartNewGameAction action) {
  previousState.difficulty = action.difficulty;
  previousState.gridSize = action.gridSize;
  previousState.activeScreen = const GameBoard();
  previousState.showRestartMenu = false;
  previousState.showSettingsMenu = false;
  previousState.resetGameboard(action.gridSize);
  previousState.resetStats();

  LocalFileService.writeAppState(previousState);

  return previousState;
}
