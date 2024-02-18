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
    return File('$path/appState.txt');
  }

  static Future<File> writeAppState(AppState appState) async {
    final file = await _localAppState;

    // Write the file
    return file.writeAsString(appState.toJson().toString());
  }

  static Future<AppState?> readAppState() async {
    try {
      final file = await _localAppState;

      // Read the file
      final contents = await file.readAsString();

      return json.decode(contents) as AppState;
    } catch (e) {
      // If encountering an error, return 0
      return null;
    }
  }
}
