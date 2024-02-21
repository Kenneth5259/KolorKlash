import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../state/actions/update_active_popup_action.dart';
import '../state/app_state.dart';
import '../styles/background_gradient.dart';

class PopupContainer extends StatefulWidget {
  final String menuTitle;
  final List<Widget> menuItems;
  const PopupContainer({super.key, required this.menuTitle, required this.menuItems});

  @override
  State<PopupContainer> createState() => _PopupContainerState();
}

class _PopupContainerState extends State<PopupContainer> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration.zero, () {
        setState(() {
          _opacity = 1.0;
        });
      });
    });
  }

  void closeMenu() {
    setState(() {
      _opacity = 0.0;
    });
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(UpdateActivePopupAction(null));
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
              padding: const EdgeInsets.only(top: 32.0, left: 12.0, right: 12.0, bottom: 8.0),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                           Padding(
                            padding: const EdgeInsets.only(top: 32),
                            child: Text(
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                ),
                                widget.menuTitle
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: widget.menuItems,
                            ),
                          )
                        ]
                    ),
                  )
              )
          ),
          Positioned(
              top: 24,
              right:4,
              child: Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.7),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 0.25)
                      )
                    ]
                ),
                child: IconButton(
                    iconSize: 16,
                    splashRadius: 20,
                    onPressed: () => closeMenu(),
                    icon: ShaderMask(
                      shaderCallback: (bounds) => backgroundGradient.createShader(bounds),
                      child: const Icon(Icons.close, color: Colors.white)
                    )
                ),
              )
          )
        ],
      ),
    );
  }
}
