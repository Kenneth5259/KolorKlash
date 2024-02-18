enum Difficulty { easy, medium, hard }

String difficultyToString(Difficulty diff) {
  return diff.toString().split('.').last;
}
Difficulty stringToDifficulty(String string) {
  return Difficulty.values.firstWhere((val) => val.toString().split('.').last == string);
}

enum GameSize { three, four, five}

String gameSizeToString(GameSize size) {
  return size.toString().split('.').last;
}
GameSize stringToGameSize(String string) {
  return GameSize.values.firstWhere((val) => val.toString().split('.').last == string);
}
