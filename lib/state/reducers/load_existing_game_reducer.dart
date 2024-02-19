import 'package:kolor_klash/screens/game_board_screen.dart';
import 'package:kolor_klash/state/app_state.dart';

AppState loadExistingGameReducer(AppState loadedState) {
  loadedState.activeScreen = const GameBoard();
  return loadedState;
}
