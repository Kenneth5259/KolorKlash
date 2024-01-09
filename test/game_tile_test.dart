import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:kolor_klash/widgets/game_tile.dart';

void main() {
  const testMax = 5;
  const testIndex = 2;
  const testColorIndex = 0;
  const testColor = Colors.red;

  Widget makeTestableWidget({required Widget child}) {
    return MaterialApp(
      home: Scaffold(
        body: child,
      ),
    );
  }

  testWidgets("GameTile widget renders correctly", (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget(child: GameTile(
      max: testMax,
      index: testIndex,
      colorIndex: testColorIndex,
      color: testColor,
    )));

    await tester.pumpAndSettle();

    expect(find.byType(GameTile), findsOneWidget);
    expect(find.byType(Draggable<GameTilePayload>, skipOffstage: false),
        findsOneWidget);
    expect(find.descendant(
        of: find.byType(GameTile), matching: find.byType(Padding)),
        findsWidgets);
  });

}
