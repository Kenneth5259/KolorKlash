import 'package:kolor_klash/state/actions/update_show_restart_menu_action.dart';
import 'package:kolor_klash/state/app_state.dart';

AppState updateShowRestartMenuActionReducer(AppState previousState, UpdateShowRestartMenuAction action) {
  previousState.showRestartMenu = action.showRestartMenu;

  return previousState;
}
