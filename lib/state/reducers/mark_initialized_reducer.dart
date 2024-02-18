import 'package:kolor_klash/state/app_state.dart';

AppState markInitializedReducer(AppState previous) {
  previous.initialized = true;
  return previous;
}
