import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kolor_klash/widgets/menu_button.dart';
import 'package:kolor_klash/widgets/white_menu_text.dart';

import '../state/actions/update_show_settings_menu_action.dart';
import '../state/app_state.dart';
import '../styles/background_gradient.dart';

class SettingsMenu extends StatefulWidget {
  const SettingsMenu({super.key});

  @override
  _SettingsMenuState createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu>  with SingleTickerProviderStateMixin {
  double _opacity = 0.0;
  double _currentVolume = 0.5;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  // Example - Assuming you have a way to persist/update volume settings elsewhere
  void _handleVolumeChange(double newValue) {
    setState(() {
      _currentVolume = newValue;
    });
    // Add your logic to save the new volume setting here
  }

  void closeMenu() {
    setState(() {
      _opacity = 0.0;
    });
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(UpdateShowSettingsMenuAction(false));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0), // Adjusted padding
            child: Container(
              decoration: BoxDecoration(
                  gradient: backgroundGradient,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.7),
                        spreadRadius: 7,
                        blurRadius: 7,
                        offset: const Offset(0, 3)
                    )
                  ]
              ),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Settings',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          //  Volume Slider
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const WhiteStyledText(text: 'Volume'),
                              Slider(
                                value: _currentVolume,
                                onChanged: _handleVolumeChange,
                                activeColor: Colors.white,
                              ),
                            ],
                          ),

                          // Restore Purchases Button
                          MenuButton(
                            onPressed: () {
                              // ... Your in-app purchase restoration logic ...
                            },
                            buttonText: 'Restore In-App Purchases',
                          ),

                          // Back Button
                          MenuButton(
                            onPressed: closeMenu,
                            buttonText: 'Back',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Positioned widget for close button (similar to your GameMenu)
        ],
      ),
    );
  }
}
