import 'package:flutter/material.dart';
import 'package:kolor_klash/state/app_state.dart';

class GameOver extends StatelessWidget {
  final AppState state;
  const GameOver({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(32),
        child: Container(
            decoration: BoxDecoration(
                color: const Color.fromRGBO(196, 0, 255, 0.85),
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
                const Padding(
                  padding: EdgeInsets.only(top: 32),
                  child: Text(
                    "Game Over",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: Colors.white
                    ),
                  ),
                ),
                Text(
                  "Score: ${state.score}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                  ),
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
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () {  },
                        iconSize: 48,
                        color: Colors.white,
                        icon: const Icon(Icons.restart_alt_rounded),
                      ),
                      Text(
                        "Replay",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            color: Colors.white
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
        )
    );
  }
}
