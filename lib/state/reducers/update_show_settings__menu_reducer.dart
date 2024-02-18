import 'package:kolor_klash/state/actions/update_show_settings_menu_action.dart';
import 'package:kolor_klash/state/app_state.dart';

AppState updateShowSettingsMenuReducer(AppState previousState, UpdateShowSettingsMenuAction action) {

  previousState.showSettingsMenu = action.showSettingsMenu;
  previousState.showRestartMenu = false;

  return previousState;
}
