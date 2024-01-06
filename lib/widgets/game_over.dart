import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kolor_klash/state/app_state.dart';

import '../state/actions/update_show_restart_menu_action.dart';

class GameOver extends StatelessWidget {
  final AppState state;
  const GameOver({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);

    return Stack(
      children: [
        Padding(
            padding: const EdgeInsets.all(32),
            child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(196, 0, 255, 0.95),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.7),
                          spreadRadius: 7,
                          blurRadius: 7,
                          offset: const Offset(0, 3)
                      )
                    ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: Text(
                        state.isGameOver ? "Game Over" : "Game Menu",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            color: Colors.white
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Score: ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              color: Colors.white
                            )
                        ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                            child: Text(
                              "${state.score}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white
                              ),
                            ),
                          ),

                      ],
                    ),
                    Text(
                      "Turns: ${state.turnCount}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 32),
                      child: MaterialButton(
                        onPressed: () => {store.dispatch(UpdateShowRestartMenuAction(false))},
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.restart_alt_rounded, color: Colors.white),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 24),
                              child: Text(
                                "Replay",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
            )
        ),
        Positioned(
            top: 16,
            right:16,
            child: Container(
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
                  splashRadius: 20,
                  onPressed: () => {store.dispatch(UpdateShowRestartMenuAction(false))}, icon: const Icon(Icons.close)
              ),
            )
        )
      ],
    );
  }
}
