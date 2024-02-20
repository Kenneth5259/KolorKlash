import 'package:kolor_klash/state/actions/update_volume_action.dart';
import 'package:kolor_klash/state/app_state.dart';

AppState updateVolumeReducer(AppState previousState, UpdateVolumeAction action) {
  previousState.volume = action.volume;
  return previousState;
}
