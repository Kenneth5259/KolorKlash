import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:kolor_klash/popups/game_over_popup.dart';
import 'package:kolor_klash/state/actions/update_colors_action.dart';
import 'package:kolor_klash/state/subclasses/emptied_deck.dart';
import 'package:kolor_klash/state/subclasses/flushed_map.dart';
import 'package:kolor_klash/state/subclasses/scoreboard.dart';
import 'package:kolor_klash/state/subclasses/tile_container_state.dart';
import 'package:kolor_klash/state/utilities/GameStateRules.dart';
import 'package:kolor_klash/widgets/tile_container.dart';

import '../../widgets/game_tile.dart';
import '../app_state.dart';
import '../subclasses/enums.dart';

AudioPlayer effectPlayer = AudioPlayer();

AppState updateColorsReducer(AppState previousState, UpdateColorsAction action) {
  effectPlayer.setVolume(previousState.volume);

  List<List<TileContainerReduxState>> grid = previousState.grid;
  Map<int, Color> newColor = action.colorMap;
  List<GameTile?> deck = previousState.deck;
  int score = previousState.score;
  int turnCount = previousState.turnCount;

  deck[action.gameTileIndex] = null;

  EmptiedDeck emptiedDeck = handleEmptyDeck(deck, grid.length, turnCount, previousState.difficulty);
  turnCount = emptiedDeck.turnCount;

  TileContainer tile = action.tile;
  newColor.forEach((key, value) {
    grid[tile.row][tile.column].colorMap[key] = value;
  });

  Set<TileContainerReduxState> flushables = GameStateRules.generateFlushableSet(grid, tile, newColor.values.first);
  List<GameTile?> newDeck = emptiedDeck.deck;

  score += calculateScore(flushables, newColor, previousState.difficulty);

  AppState updatedAppState = AppState(gridSize: previousState.gridSize, difficulty: previousState.difficulty);
  updatedAppState.grid = grid;
  updatedAppState.deck = newDeck;
  updatedAppState.score = score;
  updatedAppState.turnCount = turnCount;
  updatedAppState.isGameOver = GameStateRules.isGameOver(grid, newDeck);
  updatedAppState.activePopupMenu = updatedAppState.isGameOver ? GameOverMenu.POPUP_ID : null;
  updatedAppState.activeScreen = previousState.activeScreen;
  updatedAppState.volume = previousState.volume;
  updatedAppState.scoreBoard = previousState.scoreBoard;

  if (updatedAppState.isGameOver) {
    effectPlayer.play(AssetSource('music/effect/cartoon-slide-whistle-down-2-176648.mp3'));
    updatedAppState.scoreBoard.addScore(ScoreEntry(scoreValue: score, turnCount: turnCount));
  } else if (flushables.isEmpty) {
    effectPlayer.play(AssetSource('music/effect/pop-39222.mp3'));
  }

  return updatedAppState;
}

/// empties a deck and increments turn count if empty
EmptiedDeck handleEmptyDeck(List<GameTile?> deck, int gridSize, int turnCount, Difficulty difficulty) {
  // check if the deck is "empty" ie all are null
  for (var entry in deck) {
    if (entry != null) {
      return EmptiedDeck(deck: deck, turnCount: turnCount);
    }
  }
  var newDeck = generateNewDeck(gridSize, difficulty);
  turnCount = turnCount + 1;
  return EmptiedDeck(deck: newDeck, turnCount: turnCount);
}

/// method to remove the colors from a color map and return the number of times that color was in the map
FlushedMap flushColor(Map<int, Color> colorMap, Color color) {
  int colorCount = colorMap.length;
  colorMap.removeWhere((key, value) => value.value == color.value);
  colorCount -= colorMap.length;
  effectPlayer.play(AssetSource('music/effect/sound-effect-twinklesparkle-115095.mp3'));
  return FlushedMap(colorMap: colorMap, colorCount: colorCount);
}

/// method to generate a new deck
List<GameTile?> generateNewDeck(int gridSize, Difficulty difficulty) {
  List<GameTile?> deck = [];
  for (var i = 0; i < gridSize; i++) {
    deck.add(GameTile.generateNewTile(gridSize, difficulty, i));
  }
  effectPlayer.play(AssetSource('music/effect/clean-fast-swooshaiff-14784.mp3'));
  return deck;
}

int calculateScore(Set<TileContainerReduxState> flushables, Map<int, Color> newColor, Difficulty difficulty) {
  int score = 0;
  bool flushedSecondColor = false;

  for (var tile in flushables) {
    FlushedMap flushedMap = flushColor(tile.colorMap, newColor.values.first);
    score += flushedMap.colorCount;

    // Bonus for flushing more than 5 of a single color
    if (flushedMap.colorCount > 5) {
      score += 10; // Arbitrary bonus value
    }

    // Check if a second color is flushed
    if (tile.colorMap.isNotEmpty) {
      flushedSecondColor = true;
    }

    tile.colorMap = flushedMap.colorMap;
  }

  // Additional bonus for flushing a second color
  if (flushedSecondColor) {
    score += 20; // Arbitrary bonus value
  }

  // Difficulty multiplier
  switch (difficulty) {
    case Difficulty.medium:
      score = (score * 1.5).toInt();
      break;
    case Difficulty.hard:
      score = (score * 2).toInt();
      break;
    default:
      break;
  }

  return score;
}