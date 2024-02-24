import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kolor_klash/services/local_file_service.dart';

import 'package:kolor_klash/state/app_reducer.dart';
import 'package:kolor_klash/state/app_state.dart';
import 'package:kolor_klash/styles/background_gradient.dart';
import 'package:kolor_klash/widgets/screen_container.dart';
import 'package:redux/redux.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  AppState initialState = await LocalFileService.readAppState() ?? AppState(gridSize: 3);
  initialState.initialized = false;

  final store = Store<AppState>(appReducer, initialState: initialState, syncStream: true);


  final backgroundPlayer = AudioPlayer();
  final backgroundSongs = [
    'music/background/inspirational-background-112290.mp3',
    'music/background/that-background-ambient-114376.mp3',
    'music/background/upbeat-day-190084.mp3'
  ];


  runApp(MyApp(store: store, backgroundPlayer: backgroundPlayer, backgroundSongs: backgroundSongs));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  final AudioPlayer backgroundPlayer;
  final List<String> backgroundSongs;

  const MyApp({super.key, required this.store, required this.backgroundPlayer, required this.backgroundSongs});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    playList();
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
          home: Scaffold(
            body: Container(
              decoration: backgroundBoxDecoration,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32.0),
                  child: ScreenContainer(player: backgroundPlayer),
                )
            ),
          )
        ),
    );
  }

  void playList() async {
    backgroundPlayer.play(AssetSource(backgroundSongs[0]));
    int i = 1;

    backgroundPlayer.onPlayerComplete.listen((_) {
      if(i < backgroundSongs.length) {
        backgroundPlayer.play(AssetSource(backgroundSongs[i]));
        i++;
      } else {
        i = 1;
        backgroundPlayer.play(AssetSource(backgroundSongs[0]));
      }
    });
  }
}

