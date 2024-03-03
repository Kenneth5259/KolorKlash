import 'dart:convert';

class ScoreBoard {
  List<ScoreEntry> _scores = [];

  List<ScoreEntry> getScores() {
    return _scores;
  }

  void setScores(List<ScoreEntry> scores) {
    _scores = scores;
  }

  void addScore(ScoreEntry score) {
    _scores.add(score);
  }

  String toJson() {
    List<String> scoreStrings = [];
    for(ScoreEntry score in _scores) {
      scoreStrings.add(score.toJson());
    }
    return jsonEncode({
      'scores': scoreStrings
    });
  }

  static ScoreBoard fromJson(Map jsonMap) {
    ScoreBoard updatedScoreBoard = ScoreBoard();
    List<String> scoreStrings = jsonMap['scores'];
    for(String score in scoreStrings) {
      Map scoreMap = jsonDecode(score);
      updatedScoreBoard.addScore(ScoreEntry.fromJson(scoreMap));
    }
    return updatedScoreBoard;
  }
}

class ScoreEntry {
  DateTime scoreDate;
  final int scoreValue;
  final int turnCount;

  ScoreEntry({required this.scoreValue, required this.turnCount, DateTime? scoreDate}) : scoreDate = scoreDate ?? DateTime.now();

  String toJson() {
    return jsonEncode({
      'scoreDate': scoreDate.toString(),
      'scoreValue': scoreValue,
      'turnCount': turnCount
    });
  }

  static ScoreEntry fromJson(Map jsonMap) {
    return ScoreEntry(
        scoreValue: jsonMap['scoreValue'],
        turnCount: jsonMap['turnCount'],
        scoreDate: DateTime.parse(jsonMap['scoreDate'])
    );
  }
}
