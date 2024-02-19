import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../state/app_state.dart';

class LocalFileService {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> get _localAppState async {
    final path = await _localPath;
    // log to repeat file writes on simulator if necessary
    return File('$path/appState.json');
  }

  static Future<File> writeAppState(AppState appState) async {
    final file = await _localAppState;

    // log file contents
    String appStateString = json.encode(appState.toJson());

    // Write the file
    return file.writeAsString(appStateString, mode: FileMode.writeOnly);
  }

  static Future<AppState?> readAppState() async {
    try {
      final file = await _localAppState;

      // Read the file
      final contents = await file.readAsString();



      return AppState.loadFromJson(contents);
    } catch (e) {
      // If encountering an error, return 0
      return null;
    }
  }
}
