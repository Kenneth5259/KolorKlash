import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../state/app_state.dart';

class ScreenContainer extends StatelessWidget {
  const ScreenContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Widget?>(
        converter: (store) => store.state.activeScreen,
        builder: (BuildContext context, Widget? activeScreen) => Container(child: activeScreen)
    );
  }
}
