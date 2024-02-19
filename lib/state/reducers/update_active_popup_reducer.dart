import 'package:kolor_klash/state/actions/update_active_popup_action.dart';
import 'package:kolor_klash/state/app_state.dart';

AppState updateActivePopupReducer(AppState previousState, UpdateActivePopupAction action) {

  previousState.activePopupMenu = action.activePopupId;

  return previousState;
}
